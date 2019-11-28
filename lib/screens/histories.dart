import 'package:flutter/material.dart';
import 'package:gucbrain/util/data.dart';


class Histories extends StatefulWidget {
  @override
  _HistoriesState createState() => _HistoriesState();
}

class _HistoriesState extends State<Histories> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        Map hist = history[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                hist['dp'],
              ),
              radius: 25,
            ),
            title: Text(hist['name']),
            subtitle: Text(hist['date']),
            trailing: Text(
              hist['type'] == "sent"
                  ?"-${hist['amount']}"
                  :"+${hist['amount']}",
              style: TextStyle(
                color: hist['type'] == "sent"
                    ?Colors.red
                    :Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },

    );
  }
}
