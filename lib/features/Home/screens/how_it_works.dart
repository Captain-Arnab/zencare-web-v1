import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HowItWorks extends StatelessWidget {

  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05),
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 50),
                    child: Column(
                      children: [
                        Text(
                          "How It Works",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Straightforward process designed to make your experience seamless and hassle-free.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  // Service Steps
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ServiceStep(
                            imagePath: 'assets/img/icons/about-hands.svg',
                            title: '1. Search and Browse',
                            description:
                            'Customers can browse or search for specific products or services using categories, filters, or search bars.',
                          ),
                        ),
                        Expanded(
                          child: ServiceStep(
                            imagePath: 'assets/img/icons/about-documents.svg',
                            title: '2. Add to Cart or Book Now',
                            description:
                            'Customers can add items to their shopping cart. For services, they may select a service and proceed to book.',
                          ),
                        ),
                        Expanded(
                          child: ServiceStep(
                            imagePath: 'assets/img/icons/about-book.svg',
                            title: '3. Amazing Places',
                            description:
                            'The Customer fulfills the order by either\n providing the service to the buyer.',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Background Image 1
                  SvgPicture.asset(
                    'assets/img/bg/work-bg-01.svg',
                    fit: BoxFit.cover,
                    height: 20.0,
                  ),
                  const SizedBox(height: 20.0),
                  // Background Image 2
                  SvgPicture.asset(
                    'assets/img/bg/work-bg-02.svg',
                    fit: BoxFit.cover,
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ServiceStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ServiceStep({super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight/3,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: Column(
            children: [
              SvgPicture.asset(imagePath, height: 60.0,color: Colors.green.shade200,),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[600])
              ),
            ],
          ),
        ),
      ),
    );
  }
}