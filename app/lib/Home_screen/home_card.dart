import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String image;
  final bool isArticle;

  const HomeCard({super.key,
  required this.title,
  required this.subtitle,
  required this.color,
  required this.image,
  this.isArticle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4,),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 2,),
          Image.asset(image,),
          SizedBox(height: 2,)
        ],
      ),
      
    );
  }
}
