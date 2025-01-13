import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_advisory/services/api_service.dart';
import 'package:eczema_advisory/services/websocket_service.dart';
import 'package:intl/intl.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<dynamic> _conversations = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    _setupWebSocket();
  }

  void _setupWebSocket() {
    final webSocketService = Provider.of<WebSocketService>(context, listen: false);
    webSocketService.onMessageReceived = (data) {
      // TODO: Handle new message
      _loadConversations();
    };
  }

  Future<void> _loadConversations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = Provider.of<ApiService>(context, listen: false);
      // TODO: Implement get conversations API
      // _conversations = await apiService.getConversations();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading conversations: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_conversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.message_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with your doctor',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        final lastMessage = conversation['lastMessage'];
        final timestamp = DateTime.parse(lastMessage['timestamp']);
        final now = DateTime.now();
        final difference = now.difference(timestamp);

        String formattedTime;
        if (difference.inDays > 7) {
          formattedTime = DateFormat('MMM d').format(timestamp);
        } else if (difference.inDays > 0) {
          formattedTime = DateFormat('E').format(timestamp);
        } else {
          formattedTime = DateFormat('h:mm a').format(timestamp);
        }

        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    doctorId: conversation['doctor']['id'],
                    doctorName: conversation['doctor']['name'],
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversation['doctor']['imageUrl']),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'Dr. ${conversation['doctor']['name']}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  formattedTime,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    lastMessage['content'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: lastMessage['read']
                              ? Colors.grey
                              : Theme.of(context).colorScheme.primary,
                          fontWeight:
                              lastMessage['read'] ? FontWeight.normal : FontWeight.bold,
                        ),
                  ),
                ),
                if (!lastMessage['read'])
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;

  const ChatScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  List<dynamic> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _setupWebSocket();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _setupWebSocket() {
    final webSocketService = Provider.of<WebSocketService>(context, listen: false);
    webSocketService.joinRoom(widget.doctorId);
    webSocketService.onMessageReceived = (data) {
      if (data['senderId'] == widget.doctorId) {
        setState(() {
          _messages.insert(0, data);
        });
      }
    };
  }

  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = Provider.of<ApiService>(context, listen: false);
      _messages = await apiService.getMessages(widget.doctorId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading messages: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    _messageController.clear();

    try {
      final apiService = Provider.of<ApiService>(context, listen: false);
      final webSocketService = Provider.of<WebSocketService>(context, listen: false);

      final messageData = {
        'content': message,
        'receiverId': widget.doctorId,
      };

      await apiService.sendMessage(messageData);
      webSocketService.sendMessage(messageData);

      setState(() {
        _messages.insert(0, {
          'content': message,
          'senderId': 'me',
          'timestamp': DateTime.now().toIso8601String(),
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. ${widget.doctorName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isMe = message['senderId'] == 'me';
                      final timestamp = DateTime.parse(message['timestamp']);
                      final formattedTime = DateFormat('h:mm a').format(timestamp);

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['content'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : null,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isMe
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // TODO: Implement file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
