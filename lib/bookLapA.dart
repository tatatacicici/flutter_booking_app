import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_booking_app/menuBooking.dart';
import 'package:flutter_booking_app/widget.dart';

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
  int _selectedPrice = 100000;

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

  Future<bool> isTimeSlotAvailable(DateTime selectedDate,
      TimeOfDay selectedTime, String selectedSession) async {
    try {
      // Check if the time slot is available in Firestore
      QuerySnapshot<Map<String, dynamic>> bookings = await FirebaseFirestore
          .instance
          .collection('booking')
          .where('lapangan', isEqualTo: "Lapangan A")
          .where('tanggal',
              isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
          .where('jam',
              isLessThan: selectedTime
                  .format(context)) // Jam harus kurang dari waktu yang dipilih
          .where('sesi', isEqualTo: selectedSession)
          .get();

      // If there are no bookings at the selected time slot, consider it available
      return bookings.docs.isEmpty;
    } catch (error) {
      print('Error checking availability: $error');
      return false; // Assume not available in case of an error
    }
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      // Check availability before submitting the booking
      final isAvailable = await isTimeSlotAvailable(
          _selectedDate, _selectedTime, _selectedSession);

      if (!isAvailable) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sesi tidak tersedia'),
              content: Text(
                  'Waktu dan sesi yang dipilih tidak tersedia. Mohon pilih waktu lainnya'),
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
        return; // Do not proceed with booking
      }

      // Proceed with booking if the time slot is available
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final formattedTime = _selectedTime.format(context);
      final kodeBooking = _generateKodeBooking();

      try {
        // Menentukan lapangan, misalnya "Lapangan A"
        final lapangan = "Lapangan A";

        await FirebaseFirestore.instance.collection('booking').add({
          'userEmail': widget.userEmail,
          'tanggal': formattedDate,
          'jam': formattedTime,
          'sesi': _selectedSession,
          'kodeBooking': kodeBooking,
          'harga': _selectedPrice,
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
                  Text('Harga: $_selectedPrice'),
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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white), // Mengubah warna judul menjadi hitam
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
                ),
              ),
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Mengubah posisi teks dan ikon ke tengah
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today), // Icon kalender di sini
                        SizedBox(width: 8.0),
                        Text(
                          'Pilih Tanggal',
                          style: TextStyle(
                              color: Colors
                                  .black), // Mengubah warna teks menjadi hitam
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      child: Text(
                        'DD-MM-YYYY',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Mengubah posisi teks dan ikon ke tengah
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time), // Icon jam di sini
                        SizedBox(width: 8.0),
                        Text(
                          'Pilih Jam',
                          style: TextStyle(
                              color: Colors
                                  .black), // Mengubah warna teks menjadi hitam
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      child: Text(
                        '00:08',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_empty, color: Colors.black),
                          SizedBox(width: 8.0),
                          Text(
                            'Pilih Sesi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Tampilan(
                            userEmail: widget.userEmail,
                          ).buildSessionButton(
                            '1 Jam',
                            _selectedSession,
                            100000, // Updated price for 1 Jam
                            () {
                              setState(() {
                                _selectedSession = '1 Jam';
                                _selectedPrice = 100000;
                              });
                            },
                          ),
                          SizedBox(width: 8.0),
                          Tampilan(
                            userEmail: widget.userEmail,
                          ).buildSessionButton(
                            '2 Jam',
                            _selectedSession,
                            180000, // Updated price for 2 Jam
                            () {
                              setState(() {
                                _selectedSession = '2 Jam';
                                _selectedPrice = 180000;
                              });
                            },
                          ),
                          SizedBox(width: 8.0),
                          Tampilan(
                            userEmail: widget.userEmail,
                          ).buildSessionButton(
                            '3 Jam',
                            _selectedSession,
                            250000, // Updated price for 3 Jam
                            () {
                              setState(() {
                                _selectedSession = '3 Jam';
                                _selectedPrice = 250000;
                              });
                            },
                          ),
                          SizedBox(width: 8.0),
                          Tampilan(
                            userEmail: widget.userEmail,
                          ).buildSessionButton(
                            '4 Jam',
                            _selectedSession,
                            320000, // Updated price for 4 Jam
                            () {
                              setState(() {
                                _selectedSession = '4 Jam';
                                _selectedPrice = 320000;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                ),
                child: Text(
                  'Booking',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
