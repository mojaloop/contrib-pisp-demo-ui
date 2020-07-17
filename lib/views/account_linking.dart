import 'package:flutter/material.dart';
import 'package:pispapp/widgets/title_text.dart';

class AccountLinking extends StatelessWidget {
  Widget _buildBankTile(String bankName) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: bankName,
        fontSize: 14,
      ),
    );
  }

  List<String> _getBanks() {
    return <String>[
      'Bank Of India',
      'Axis Bank',
      'Canara Bank',
      'Bank of Delhi',
      'Ahmedabad Bank',
      'Bank Of India',
      'Axis Bank',
    ];
  }

  List<Widget> _columnWidgets() {
    final List<Widget> widgets = <Widget>[
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 0, 50),
        child: TitleText(
          text: 'Choose your Bank',
          fontSize: 20,
        ),
      ),
    ];

    final List<Widget> bankWidgets = <Widget>[];

    for (final String bank in _getBanks()) {
      bankWidgets.add(_buildBankTile(bank));
    }

    widgets.addAll(bankWidgets);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _columnWidgets(),
          ),
        ),
      ),
    );
  }
}
