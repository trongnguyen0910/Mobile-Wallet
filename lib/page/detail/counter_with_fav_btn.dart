import 'package:flutter/material.dart';

class CounterWithFavBtn extends StatefulWidget {
  const CounterWithFavBtn({Key? key}) : super(key: key);

  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  final _formKey = GlobalKey<FormState>();
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Input Quantity',
      theme: ThemeData(primarySwatch: Colors.green), //theme of the app
      home: Scaffold(
        appBar: AppBar(
          title: Text('Input Quantity'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number, // loại bàn phím chỉ nhập số
              decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter quantity',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity';
                }
                final n = num.tryParse(value);
                if (n == null || n <= 0) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
              onSaved: (value) {
                _quantity = int.parse(value!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
