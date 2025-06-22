import 'package:app/Home_screen/bottom_nav_bar.dart';
import 'package:app/Home_screen/home_card.dart';
import 'package:app/Home_screen/nearby_property.dart';
import 'package:app/Home_screen/property_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            SizedBox(
                                height: 30,
                                width: 110,
                              child: Image.asset("assets/home_assets/home_icon.png",
                              fit: BoxFit.fill,),
                            ),
                           SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/home_assets/profile_icon.png"))
                        ],
                    ),
                    SizedBox(height:5),
                    Text("Hi UserName Searching in ", style: TextStyle(color: Colors.grey,fontSize: 10),),
                    SizedBox(height: 5,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        LocationButton(),
                        SizedBox(
                            width: 150,
                           child: Image.asset("assets/home_assets/post_icon.png",
                           fit: BoxFit.fill,),
                        )
                    ],
                   ),
                  
                const SizedBox(height: 10),
               
                Row(
                  children: [
                    SizedBox(
                        width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search City, Location, Landmark',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: const Icon(Icons.search,color: Color(0xFFFF0000),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                        height: 40,
                        width:40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFFF0000),
                        ),
                        
                        child: Image.asset("assets/home_assets/filter_icon.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,),

                    )
                  ],
                ),
                const SizedBox(height: 15),
                // Category buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CategoryButton(suffixWidget: CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(0xFFFF0000),
                        child: Icon(Icons.home,color: Colors.white,size: 20,),
                    ) ,title: 'Residential'),
                    CategoryButton(suffixWidget: Image.asset("assets/home_assets/commercial_icon.png",width: 20,height: 20,fit: BoxFit.fill,),title: 'Commercial'),
                     CategoryButton(suffixWidget: Image.asset("assets/home_assets/agriculture_icon.png",width: 20,height: 20,fit: BoxFit.fill,),title: 'Agricultural Land'),
                  ],
                ),
                const SizedBox(height: 20),
                // Best for You
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Best for You",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return const PropertyCard();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Nearby Property
                const Text("Nearby Property",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(2, (index) => const NearbyCard()),
                ),
                const SizedBox(height:12),
                const Text(
                  "Apartments, Villas and more",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                const Text("In Noida"),
                const SizedBox(height: 12,),
                Row(children: [
                  HomeCard(
                    title: "Luxury\nProperty",
                  subtitle: "Where Luxury Begins at ₹1 Cr.",
                  color: Color(0xFFFFEF80),
                  image: 'assets/home_assets/home_card1.png',
                  ),
                  SizedBox(width: 15,),
                  HomeCard(
                    title: "Residential\nApartment",
                  subtitle: "1000+ Properties",
                  color: Color(0xFFCCF2F4),
                  image: 'assets/home_assets/home_card2.png',
                  )
                ],),
                const SizedBox(height: 16),
                            Container(
              height: 200,
                  width:470,
              decoration: BoxDecoration(
                color: Color(0xFFDCECFD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                  "assets/home_assets/home_loans.png",
                  fit:BoxFit.cover
                  ),
            ),

            const SizedBox(height: 16),
      
               const Text(
          "Top articles on home buying",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12), 
                Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ArticleCard(),
                ArticleCard(),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ArticleCard(),
                ArticleCard(),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),
                Row(
          children: const [
            Text(
              "Read More articles on home buying",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_right_alt, color: Colors.blue),
          ],
        ),
        SizedBox(height:12),
         Container(
              height: 200,
                  width:470,
              decoration: BoxDecoration(
                color: Color(0xFFDCECFD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                  "assets/home_assets/post_property.png",
                  fit:BoxFit.cover
                  ),
            ),
        SizedBox(height: 10,),
       
           Text(
          "Explore popular cities",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              SizedBox(width: 22),
              CityCircle(image: 'assets/home_assets/delhi.png', name: "Delhi / NCR"),
              SizedBox(width: 22),
              CityCircle(image: 'assets/home_assets/Mumbai.png', name: "Mumbai"),
              SizedBox(width: 22),
              CityCircle(image: 'assets/home_assets/Banglore.png', name: "Bangalore"),
              SizedBox(width: 22),
              CityCircle(image: 'assets/home_assets/Hyderabad.png', name: "Hyderabad"),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE0F7FA), // light blue background
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Center(
                child: Text(
                  "Liking 360Property so far?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Center(child: Text("Tell us how we can make it even better for you!")),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FeedbackButton(
                    icon: Icons.thumb_up_alt_outlined,
                    label: "You Liking it",
                  ),
                  FeedbackButton(
                    icon: Icons.thumb_down_alt_outlined,
                    label: "Not really",
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
   final Widget? suffixWidget;
  const CategoryButton({super.key, required this.title,this.suffixWidget,});

  @override
  Widget build(BuildContext context) {
    return  Chip(
      backgroundColor: Colors.white,
      side:  BorderSide(color: Colors.grey),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            if (suffixWidget != null) ...[
            const SizedBox(width: 4),
            suffixWidget!,
          ],
            SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
class LocationButton extends StatelessWidget{
    const LocationButton({super.key});
    @override
    Widget build(BuildContext context){
        return Container(
            child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/home_assets/location_icon.png",
                    fit: BoxFit.fill,),
                  ),
                  SizedBox(width: 5,),
                  Text("Location Name v", 
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)

                ],
            ),
        );
    }
}
class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 24, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/home_assets/article_home.png', 
              height: 50,
              width: 40,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "How to Choose the right location in Noida?",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "Mar 12, 2025",
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class CityCircle extends StatelessWidget {
  final String image;
  final String name;

  const CityCircle({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
class FeedbackButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeedbackButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
