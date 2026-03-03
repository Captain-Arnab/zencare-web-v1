import 'package:flutter/material.dart';

class ExpansionTileData {
  final String title;
  final String content;

  ExpansionTileData({required this.title, required this.content});
}

class PackageCard extends StatefulWidget {
  final String packageTitle;
  final String packageDescription;
  final String packageHighlight;
  final String packagePrice;
  final List<ExpansionTileData> expansionData;
  final VoidCallback onAdd;

  const PackageCard({
    super.key,
    required this.packageTitle,
    required this.packageDescription,
    required this.packageHighlight,
    required this.packagePrice,
    required this.expansionData,
    required this.onAdd,// List of ExpansionTileData
  });

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool knowMoreButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PACKAGE",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.green)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87, // Background color
                    foregroundColor: Colors.white, // Text color
                    elevation: 5, // Elevation or shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10), // Padding
                    textStyle:
                    Theme.of(context).textTheme.displayMedium, // Text style
                  ),
                  onPressed: widget.onAdd,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(widget.packageTitle,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.grey[700])),
            SizedBox(height: 4),
            Text(widget.packageDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(height: 15),
            if(!widget.packageHighlight.isEmpty) Text(widget.packageHighlight),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.packagePrice, style: Theme.of(context).textTheme.labelMedium),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      knowMoreButton = !knowMoreButton;
                    });
                  },
                  child: Text(!knowMoreButton ? 'More Details' : 'Read Less', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.green),),
                )
              ],
            ),
            knowMoreButton
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                                children: widget.expansionData.map((data) {
                  return ExpansionTile(
                    expandedAlignment: Alignment.topLeft,
                    title: Text(data.title,
                        style: Theme.of(context).textTheme.displayMedium),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          data.content,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w200, color: Colors.grey[700]),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  );
                                }).toList(),
                              ),
                )
                : Container(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
