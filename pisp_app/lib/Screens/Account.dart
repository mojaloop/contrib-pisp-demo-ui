import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "\nTotal Balance\n",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 18)),
                  TextSpan(
                      text: "\$ ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 30)),
                  TextSpan(
                      text: "1,234.00 \n",
                      style: TextStyle(color: Colors.black, fontSize: 36)),
                ])),
              ),
              IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {})
            ],
          ),
          
        ],
      ),
    );
  }
}
