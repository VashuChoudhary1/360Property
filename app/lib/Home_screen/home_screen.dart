import 'package:app/Home_screen/bottom_nav_bar.dart';
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
                            Container(
                                height: 30,
                                width: 110,
                              child: Image.asset("assets/home_assets/home_icon.png",
                              fit: BoxFit.fill,),
                            ),
                           Container(
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
                        Container(
                            width: 150,
                           child: Image.asset("assets/home_assets/post_icon.png",
                           fit: BoxFit.fill,),
                        )
                    ],
                   ),
                  
                const SizedBox(height: 10),
               
                Row(
                  children: [
                    Container(
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
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
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
                  Container(
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
