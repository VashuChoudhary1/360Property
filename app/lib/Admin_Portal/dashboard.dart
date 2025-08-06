import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with time and profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '09:50',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                        radius: 20,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('User Name', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Property Manager', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Top Stat Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
                children: [
                  _statCard(Icons.assignment_ind, 'Leads Assigned', '11'),
                  _statCard(Icons.home, 'Visits Done', '32'),
                  _statCard(Icons.pending_actions, 'Tasks Pending', '05'),
                  _checkInCard(),
                ],
              ),
              const SizedBox(height: 20),

              // Recent Leads
              const Text('Recent Leads', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              _leadsTable(),

              const SizedBox(height: 20),

              // Work Stats Graph Placeholder
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Work Statistics', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('This Week'),
                    SizedBox(height: 12),
                    Placeholder(fallbackHeight: 120), // Replace with chart widget
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _checkInCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
          SizedBox(height: 8),
          Text('Check in', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text('00:02:59', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _leadsTable() {
    final List<Map<String, String>> leads = [
      {"name": "User Name", "type": "Commercial", "date": "25/06"},
      {"name": "User Name", "type": "Commercial", "date": "25/06"},
      {"name": "User Name", "type": "Residential", "date": "25/06"},
      {"name": "User Name", "type": "Commercial", "date": "25/06"},
      {"name": "User Name", "type": "Agricultural", "date": "25/06"},
      {"name": "User Name", "type": "Commercial", "date": "25/06"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: leads.asMap().entries.map((entry) {
          int index = entry.key + 1;
          var lead = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Text("$index", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(child: Text(lead['name']!)),
                _propertyChip(lead['type']!),
                const SizedBox(width: 10),
                Text(lead['date']!),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _propertyChip(String label) {
    Color bgColor;
    if (label == 'Commercial') {
      bgColor = Colors.green;
    } else if (label == 'Residential') {
      bgColor = Colors.orange;
    } else {
      bgColor = Colors.brown;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: bgColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
