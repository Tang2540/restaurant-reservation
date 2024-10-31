import 'package:flutter/material.dart';
import 'package:team_app/component/calendar.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;

  Set<DateTime> _getReservedDates(List<dynamic> dateStrings) {
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toSet();
  }

  bool _isDateReserved(DateTime date, Set<DateTime> reservedDates) {
    return reservedDates.any((reservedDate) =>
        reservedDate.year == date.year &&
        reservedDate.month == date.month &&
        reservedDate.day == date.day);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableModel>(
      builder: (context, tableModel, child) {
        // Convert the list of ISO date strings from tableModel to DateTime Set
        final Set<DateTime> reservedDates = _getReservedDates(tableModel.dates);

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
                  CalendarComponent(
                    reservedDates: reservedDates,
                    selectedDate: _selectedDate,
                    onDaySelected: (selectedDay) {
                      if (!_isDateReserved(selectedDay, reservedDates)) {
                        setState(() {
                          _selectedDate = selectedDay;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('This date is already reserved'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  if (_selectedDate != null)
                    Text(
                      'Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Reserved'),
                        SizedBox(width: 16),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Selected'),
                      ],
                    ),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Processing Booking for ${tableModel.tableID} on ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                          ),
                        );
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
