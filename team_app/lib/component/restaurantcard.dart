import 'package:flutter/material.dart';

class NamecardData {
  const NamecardData({
    required this.name,
    required this.date,
    required this.imageUrl,
  });

  final String name;
  final String date;
  final String imageUrl;
}

class Namecard extends StatelessWidget {
  const Namecard({
    super.key,
    required this.namecarddata,
  });
  final NamecardData namecarddata;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 100.0,
          child: Image.asset(
            'assets/image/GettyImages-1389862392.webp',
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('name: ${namecarddata.name}'),
          Text('DOB: ${namecarddata.date}'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, namecarddata.name);
              },
              child: Text('Select'))
        ])
      ]),
    );
  }
}
