import 'package:app/Home_screen/home_screen.dart';
import 'package:app/Loan_Screen/home_loan_step1.dart';
import 'package:app/News_Screen/news_screen.dart';
import 'package:app/Product_Screen/product_screen.dart';
import 'package:app/Profile/profile_screen.dart';
import 'package:app/Property_Comparison/property_comparison1.dart';
import 'package:app/calculator/emi_calculator_screen.dart';
import 'package:app/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductDetailScreen(),
    //home: MainScreen(),
  ));
}
  