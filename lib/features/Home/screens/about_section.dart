import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight*0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/img/providers/provider-23.jpg',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.black.withOpacity(0.7),
                            child: Text(
                              '12+ years of experiences',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABOUT ZEN CARE',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We connect you to the right service',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Welcome to Zen Care, your platform for salon and beauty bookings and other home lifestyle services! We are dedicated to making your life easier with professional, reliable providers. Whether it’s keeping your home cool with AC servicing, ensuring your appliances run smoothly with refrigerator repair, or giving your space a fresh look with home cleaning—we''ve got you covered!',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Looking for beauty and grooming? Our expert salon partners bring hair, makeup, and styling services to your doorstep. Worried about pests? Our pest control solutions help keep your home comfortable. Need a carpenter for home improvements? We connect you with skilled professionals for fixes and renovations. And if you''re dreaming of a beautifully designed home, our interior design services turn your vision into reality.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'At Zen Care, we believe in quality, convenience, and customer satisfaction. Our skilled professionals ensure top-notch service while maintaining affordability and efficiency. Your comfort is our priority!',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildListItem('We prioritize quality and reliability'),
                              _buildListItem('We save your time and effort'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildListItem('Clear, detailed service listings & reviews'),
                              _buildListItem('Smooth and satisfactory experience'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.check_circle, color: Colors.black87,size: 15,weight: 2,fill: 0.2,),
          ),
          SizedBox(width: 2),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
