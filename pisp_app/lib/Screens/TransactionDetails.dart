import 'package:flutter/material.dart';

class TransactionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Column(
                      children: <Widget>[
                        CardRow('Payer Account Alias', 'Business', Colors.red),
                        CardRow('Payee Account name', 'John Doe', Colors.black),
                        CardRow('Payee Phone no', '+9898989898', Colors.black),
                        CardRow('Payee Bank Name', 'Bank Of India', Colors.black),
                        CardRow('Payee Account Number', '123123123123', Colors.black),
                        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: Colors.red, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.clear)),
                      onTap: ()  {
                        
                      },
                    ),
                  ),
                )),
                Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: Colors.green, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.arrow_forward)),
                      onTap: ()  {
                        
                      },
                    ),
                  ),
                )),
                ]
                   
            )
          ),
        ),
        

                      ],
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class CardRow extends StatelessWidget {
  String left, right;
  Color color;
  CardRow(this.left, this.right, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: left,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: right, style: TextStyle(color: color, fontSize: 16)),
              ])),
            ],
          ),
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        )
      ],
    );
  }
}

class MyAlert extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return Padding(  
      padding: const EdgeInsets.all(20.0),  
      child: RaisedButton(  
        child: Text('Show alert'),  
        onPressed: () {  
          showAlertDialog(context);  
        },  
      ),  
    );  
  }  
}  
  
showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Simple Alert"),  
    content: Text("This is an alert message."),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}  
