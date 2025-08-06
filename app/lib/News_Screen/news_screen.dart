import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = [
    'Latest',
    'Property trends',
    'Home decor',
    'Current news'
  ];

  final List<List<String>> tabData = [
    // Latest
    List.generate(6, (index) => 'Latest News Item ${index + 1}'),
    // Property trends
    List.generate(4, (index) => 'Property Trend ${index + 1}'),
    // Home decor
    List.generate(3, (index) => 'Home Decor Tip ${index + 1}'),
    // Current news
    List.generate(5, (index) => 'Current News Update ${index + 1}'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'News for you',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    child: TabItem(
                      title: tabs[index],
                      isSelected: selectedTabIndex == index,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // List of news items according to selected tab
            Expanded(
              child: ListView.builder(
                itemCount: tabData[selectedTabIndex].length,
                itemBuilder: (context, index) {
                  return NewsCard(
                      title: tabData[selectedTabIndex][index]);
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'View More',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
class TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const TabItem({super.key, required this.title, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// Custom news card widget
class NewsCard extends StatelessWidget {
  final String title;

  const NewsCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.white, width: 0.3),
      ),
      margin: const EdgeInsets.only(bottom: 12),
     color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: Image.asset(
              'assets/news.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tellus diam vel qui vel quis...',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Text(
                        'Category Name ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        '• Apr 25',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
         Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Icon(
                  Icons.ios_share,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
