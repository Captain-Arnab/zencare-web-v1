import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentBookingWidget extends StatefulWidget {

  late final Map<String, dynamic>? appointmentDetails;


  AppointmentBookingWidget({this.appointmentDetails});

  @override
  _AppointmentBookingWidgetState createState() =>
      _AppointmentBookingWidgetState();
}

class _AppointmentBookingWidgetState extends State<AppointmentBookingWidget>
    with TickerProviderStateMixin<AppointmentBookingWidget> {
  final _formKey = GlobalKey<FormState>();

  late TabController bottomTabController;
  // State variables
  String? selectedCategory;
  DateTime? selectedDate;
  String? selectedTimeSlot;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  late DateTime date = DateTime.now();
  bool isSelected = true;

  // Dummy data
  List<String> categories = [];
  final timeSlots = [
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '01:00 PM - 02:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
    '05:00 PM - 06:00 PM',
  ];
  final availableDates = List.generate(
    14,
    (index) => DateTime.now().add(Duration(days: index)),
  );

  @override
  void initState() {
    super.initState();
    _loadStringList();
    if (widget.appointmentDetails != null &&
        widget.appointmentDetails!.isNotEmpty) {
      setState(() {
        selectedDate = widget.appointmentDetails!['date'];
        isSelected = true;
        selectedCategory = widget.appointmentDetails!['category'];
        selectedTimeSlot = widget.appointmentDetails!['timeSlot'];
        addressController.text = widget.appointmentDetails!['address'];
        landmarkController.text = widget.appointmentDetails!['landmark'];
      });
    } else {
      date = selectedDate = DateTime.now(); // Default to current date
    }
    bottomTabController = TabController(length: 4, vsync: this);
  }

  Future<void> _loadStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cachedCategories');
    if (cachedData != null) {
      setState(() {
        List<dynamic> decodedData = json.decode(cachedData);
        categories = decodedData.map((json) => json['NAME'] as String).toList();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(
          'Book Service',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Category Selection with Box Border
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  filled: true, // Enable fill
                  fillColor: Colors.white, // Set the background to white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                value: selectedCategory,
                items: categories
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a category' : null,
              ),

              SizedBox(height: 16),

              // Date Selection as List View
              Text(
                'Select Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableDates.length,
                itemBuilder: (context, index) {
                  final currentDate = availableDates[index]; // Use this for clarity
                  isSelected = selectedDate == currentDate;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = currentDate;
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(currentDate), // Day (e.g., Mon)
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.blue,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            DateFormat('d MMM').format(currentDate), // Date (e.g., 4 Jan)
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

              // Time Slot Selection as Grid View
              Text(
                'Select Time Slot',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: timeSlots.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final slot = timeSlots[index];
                  final isSelected = selectedTimeSlot == slot;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = slot;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),

              // Address Input with Box Border
              _buildBorderedField(
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: InputBorder.none,
                  ),
                  maxLines: 2,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your address' : null,
                ),
              ),
              SizedBox(height: 16),

              // Landmark Input with Box Border
              _buildBorderedField(
                child: TextFormField(
                  controller: landmarkController,
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    border: InputBorder.none,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a landmark' : null,
                ),
              ),
              SizedBox(height: 16),

              // Submit Button
              Container(
                padding: EdgeInsets.all(10),
                height: 70,
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate() && selectedDate != null && selectedTimeSlot != null){
                      _submitForm();
                    }
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 16, // Text size
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                        vertical: 14, horizontal: 30), // Padding
                    elevation: 5, // Shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBorderedField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: child,
    );
  }

  _submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    String userId = await prefs.getString('userId') ?? "";

    print(isLoggedIn);

        final appointmentDetails = {
          'category': selectedCategory,
          'date': selectedDate,
          'timeSlot': selectedTimeSlot,
          'address': addressController.text,
          'landmark': landmarkController.text,
        };

        if (isLoggedIn!) {
          // TODO: Send appointment details to server or perform other actions
          print('Appointment Details: $appointmentDetails');

          final response = await createServiceBooking(
            category: selectedCategory!,
            subcategories: "Window Cleaning",
            date: selectedDate.toString(),
            location: addressController.text,
            landmark:  landmarkController.text,
            userId: userId,
            serviceSlot: selectedTimeSlot!,
          );

          if (response["success"] == true) {
            print("Booking Successful!");
            print("Message: ${response['message']}");
            print("Unique Booking ID: ${response['uniqueBookingId']}");
          } else {
            print("Booking Failed!");
            print("Message: ${response['message']}");
          }

          // Show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Your appointment has been booked and you will receive a confirmation shortly.')),
          );

          // Wait for 2 seconds before navigating
          /*Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          });*/
        }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please login to proceed')),
        );

        // Wait for 2 seconds before navigating
        /*Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeBackPage(fromPage:'booking',appointmentDetails: appointmentDetails)),
          );
        });*/
      }
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<bool> isLoggedIn = prefs.setBool('isLoggedIn', true);
    return isLoggedIn; // For testing, assuming the user is not logged in
  }

  Future<Map<String, dynamic>> createServiceBooking({
    required String category,
    required String subcategories,
    required String date,
    required String location,
    String? landmark,
    required String userId,
    required String serviceSlot,
  }) async {
    final String apiUrl = "https://zencareservice.com/servicy/api/book_appointment.php"; // Replace with your actual API URL

    try {
      // Prepare the request payload
      Map<String, dynamic> requestPayload = {
        "category": category,
        "subcategories": subcategories,
        "date": date,
        "location": location,
        "landmark": landmark,
        "user_id": userId,
        "service_slot": serviceSlot,
      };

      // Send POST request to the API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestPayload),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body
        final responseData = jsonDecode(response.body);

        // Check if the API call was successful
        if (responseData['status'] == "success") {
          return {
            "success": true,
            "message": responseData['message'],
            "uniqueBookingId": responseData['unique_booking_id'],
          };
        } else {
          return {
            "success": false,
            "message": responseData['message'],
          };
        }
      } else {
        return {
          "success": false,
          "message": "Failed to create service booking. Please try again later.",
        };
      }
    } catch (error) {
      return {
        "success": false,
        "message": "An error occurred: $error",
      };
    }
  }
}