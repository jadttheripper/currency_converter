import 'package:flutter/material.dart';
import 'exchange_rates.dart';
import 'themes.dart' ;


class CurrencyConverter extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  CurrencyConverter({required this.toggleTheme, required this.isDarkMode});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController inputController = TextEditingController();
  String selectedFromCurrency = 'USD';
  String selectedToCurrency = 'LBP';
  String result = '';

  // Key for AnimatedSwitcher to animate result changes
  late ValueKey<String> resultKey;

  @override
  void initState() {
    super.initState();
    resultKey = ValueKey<String>('initial'); // Initialize with a default key
  }

  void convert() {
    double? inputValue = double.tryParse(inputController.text);
    if (inputValue == null) {
      setState(() {
        result = 'Invalid input';
        resultKey = ValueKey<String>(result);
      });
      return;
    }

    double rate =
        exchangeRates[selectedFromCurrency]?[selectedToCurrency] ?? 1.0;
    double convertedValue = inputValue * rate;

    setState(() {
      result = convertedValue.toStringAsFixed(2);
      resultKey = ValueKey<String>(result); // Update key to trigger animation
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";

    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge ?? TextStyle(fontSize: 16, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'today is: ',
              style: textStyle.copyWith(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(
              formattedDate,
              style: textStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: Colors.white,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Currency Converter',
              style: textStyle.copyWith(fontSize: 28, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                labelStyle: TextStyle(color: Colors.red),
              ),
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFromCurrency,
                    items: exchangeRates.keys
                        .map((currency) => DropdownMenuItem(
                      value: currency,
                      child: Text(
                        currency,
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFromCurrency = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'From',
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedToCurrency,
                    items: exchangeRates.keys
                        .map((currency) => DropdownMenuItem(
                      value: currency,
                      child: Text(
                        currency,
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedToCurrency = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'To',
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: Text(
                'Convert',
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              switchInCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Text(
                'Converted Amount: $result',
                key: resultKey,
                style: textStyle.copyWith(
                  fontSize: 20,
                  color: widget.isDarkMode ? Colors.yellow : Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}