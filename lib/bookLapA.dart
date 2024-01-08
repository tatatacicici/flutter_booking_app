import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_booking_app/menuBooking.dart';

class BookLapA extends StatefulWidget {
  final String userEmail;

  const BookLapA({Key? key, required this.userEmail}) : super(key: key);

  @override
  _BookLapAState createState() => _BookLapAState();
}

class _BookLapAState extends State<BookLapA> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String _selectedSession = '1 Jam';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _generateKodeBooking() {
    // Implementasi untuk menghasilkan kode booking unik
    return 'BK' + DateTime.now().millisecondsSinceEpoch.toString();
  }

  int _hitungHarga() {
    // Implementasi untuk menghitung harga berdasarkan sesi
    switch (_selectedSession) {
      case '1 Jam':
        return 100000; // Misalnya, harga untuk 1 jam adalah 100000
      case '2 Jam':
        return 180000; // Harga untuk 2 jam
      case '3 Jam':
        return 250000; // Harga untuk 3 jam
      case '4 Jam':
        return 320000; // Harga untuk 4 jam
      default:
        return 0;
    }
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final formattedTime = _selectedTime.format(context);
      final kodeBooking = _generateKodeBooking();
      final harga = _hitungHarga();

      try {
        // Menentukan lapangan, misalnya "Lapangan A"
        final lapangan = "Lapangan A";

        await FirebaseFirestore.instance.collection('booking').add({
          'userEmail': widget.userEmail,
          'tanggal': formattedDate,
          'jam': formattedTime,
          'sesi': _selectedSession,
          'kodeBooking': kodeBooking,
          'harga': harga,
          'lapangan': lapangan,
          // tambahkan informasi lainnya sesuai kebutuhan
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Berhasil'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Email: ${widget.userEmail}'),
                  Text('Tanggal: $formattedDate'),
                  Text('Jam: $formattedTime'),
                  Text('Sesi: $_selectedSession'),
                  Text('Kode Booking: $kodeBooking'),
                  Text('Harga: $harga'),
                  Text('Lapangan: $lapangan'),
                  // tambahkan informasi lainnya sesuai kebutuhan
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Lapangan A',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuBooking(
                        userEmail: widget.userEmail,
                      )),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Pilih Tanggal'),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Pilih Tanggal'),
              ),
              SizedBox(height: 16.0),
              Text('Pilih Jam'),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Pilih Jam'),
              ),
              SizedBox(height: 16.0),
              Text('Pilih Sesi'),
              DropdownButton<String>(
                value: _selectedSession,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSession = value!;
                  });
                },
                items: <String>['1 Jam', '2 Jam', '3 Jam', '4 Jam']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text('Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
