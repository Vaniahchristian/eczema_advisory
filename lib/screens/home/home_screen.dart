import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickActions = [
      {
        'icon': Icons.medical_services,
        'label': 'New Diagnosis',
        'color': Colors.blue,
      },
      {
        'icon': Icons.calendar_today,
        'label': 'Book Appointment',
        'color': Colors.green,
      },
      {
        'icon': Icons.chat,
        'label': 'Chat with Doctor',
        'color': Colors.purple,
      },
      {
        'icon': Icons.article,
        'label': 'View Reports',
        'color': Colors.orange,
      },
    ];

    final List<Map<String, dynamic>> recentActivities = [
      {
        'type': 'diagnosis',
        'title': 'Skin Analysis',
        'description': 'Moderate eczema detected on left arm',
        'date': '13 Jan 2024',
        'icon': Icons.medical_services,
        'color': Colors.blue,
      },
      {
        'type': 'appointment',
        'title': 'Dr. Sarah Johnson',
        'description': 'Follow-up consultation',
        'date': '15 Jan 2024',
        'icon': Icons.calendar_today,
        'color': Colors.green,
      },
      {
        'type': 'chat',
        'title': 'Dr. Michael Chen',
        'description': 'New message about treatment plan',
        'date': '12 Jan 2024',
        'icon': Icons.chat,
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: quickActions.map((action) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            switch (action['label']) {
                              case 'New Diagnosis':
                                Navigator.pushNamed(context, '/diagnosis');
                                break;
                              case 'Book Appointment':
                                Navigator.pushNamed(context, '/appointments');
                                break;
                              case 'Chat with Doctor':
                                Navigator.pushNamed(context, '/chat');
                                break;
                              case 'View Reports':
                                Navigator.pushNamed(context, '/reports');
                                break;
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: action['color'].withOpacity(0.1),
                                child: Icon(
                                  action['icon'],
                                  color: action['color'],
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                action['label'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...recentActivities.map((activity) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: activity['color'].withOpacity(0.1),
                          child: Icon(
                            activity['icon'],
                            color: activity['color'],
                          ),
                        ),
                        title: Text(activity['title']),
                        subtitle: Text(activity['description']),
                        trailing: Text(
                          activity['date'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          // Handle activity tap
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
