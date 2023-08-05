import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';

class CreateAvailableTime extends StatefulWidget {
  const CreateAvailableTime({super.key});

  @override
  State<CreateAvailableTime> createState() => _CreateAvailableTimeState();
}

class _CreateAvailableTimeState extends State<CreateAvailableTime> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _descriptionController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Available Time'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                    'Select Date: ${_selectedDate.toString().split(' ')[0]}'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time: ${_selectedTime.format(context)}'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(33, 150, 243, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Button(
                    width: 400,
                    title: 'Create Available Time',
                    onPressed: () {},
                    disable: true,
                    height: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
