import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String imageUrl;

  const ServiceCard({required this.title, required this.imageUrl});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    // Responsive sizing
    double imageWidth = isMobile ? 80 : isTablet ? 90 : 100;
    double imageHeight = isMobile ? 50 : isTablet ? 60 : 70;
    double selectedImageWidth = isMobile ? 75 : isTablet ? 85 : 90;
    double selectedImageHeight = isMobile ? 45 : isTablet ? 55 : 60;
    double fontSize = isMobile ? 12 : isTablet ? 13 : 14;

    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: isSelected
                    ? Border.all(color: Colors.black, width: 1)
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(isSelected ? (isMobile ? 4 : 6) : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: isSelected ? selectedImageWidth : imageWidth,
                    height: isSelected ? selectedImageHeight : imageHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: isSelected ? selectedImageWidth : imageWidth,
                        height: isSelected ? selectedImageHeight : imageHeight,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[600],
                          size: isMobile ? 24 : 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: isMobile ? 2 : 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}