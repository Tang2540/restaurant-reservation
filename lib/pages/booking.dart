import 'package:flutter/material.dart';
import 'package:team_app/component/calendar.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart'; // Make sure this import path is correct

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableModel>(
      builder: (context, tableModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("Select Date and Time"),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Table: ${tableModel.tableID}',
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 20),
                      Text('Number of Guests: ${tableModel.count}',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Add the TableCalendarComponent here
                  CalendarComponent(
                    onDaySelected: (selectedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Display selected date
                  if (_selectedDate != null)
                    Text(
                      'Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Phone Number (Optional):',
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (input) {
                            if (input != null && input.isNotEmpty) {
                              if (input.length != 10) {
                                return "Phone number must be 10 digits";
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        // Form is valid and date is selected, proceed with booking
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Processing Booking for ${tableModel.tableID} on ${_selectedDate!.toLocal().toString().split(' ')[0]}')),
                        );
                        // Add your booking logic here
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } else if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a date')),
                        );
                      }
                    },
                    child: Text('Book Now'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
