import 'dart:math';

import 'package:flutter/material.dart';

class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _loanAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _loanTermController = TextEditingController();

  double _monthlyPayment = 0.0;
  double _totalPayment = 0.0;
  double _totalInterest = 0.0;

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _loanTermController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final double loanAmount = double.parse(_loanAmountController.text);
      final double interestRate =
          double.parse(_interestRateController.text) / 100 / 12;
      final int loanTerm = int.parse(_loanTermController.text) * 12;

      final double monthlyPayment = (loanAmount * interestRate) /
          (1 - (1 / (pow(1 + interestRate, loanTerm))));
      final double totalPayment = monthlyPayment * loanTerm;
      final double totalInterest = totalPayment - loanAmount;

      setState(() {
        _monthlyPayment = monthlyPayment;
        _totalPayment = totalPayment;
        _totalInterest = totalInterest;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset('assets/images/car.png'),
              ),
              TextFormField(
                cursorColor: Colors.white,
                controller: _loanAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Loan Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.currency_rupee,
                    color: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a loan amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: Colors.white,
                controller: _interestRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Interest Rate (%)',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.money,
                    color: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an interest rate';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: Colors.white,
                controller: _loanTermController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Loan Term (Years)',
                  prefixIcon: Icon(Icons.calendar_today,
                    color: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a loan term';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: _calculate,
                  child: Text('Calculate Loan'),
                ),
              ),
              SizedBox(height: 32.0),
              if (_monthlyPayment > 0)
                Center(
                  child: Text(
                    'Monthly Payment: \₹${_monthlyPayment.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
