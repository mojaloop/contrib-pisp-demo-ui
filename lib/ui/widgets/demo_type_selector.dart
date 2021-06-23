import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pispapp/main.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';

class DemoTypeSelector extends StatefulWidget {
  DemoTypeSelector({this.onUpdate, this.initialValue});

  final DemoType initialValue;
  final void Function(DemoType) onUpdate;

  @override
  _DemoTypeSelectorState createState() =>
      _DemoTypeSelectorState(onUpdate: onUpdate, initialValue: initialValue);
}

class _DemoTypeSelectorState extends State<DemoTypeSelector> {
  _DemoTypeSelectorState({this.onUpdate, this.initialValue});

  final DemoType initialValue;
  DemoType currentValue;

  final void Function(DemoType) onUpdate;

  @override
  Widget build(BuildContext context) {
    currentValue ??= initialValue;
    logger.i('currentValue is ' + currentValue.toString());

    return DropdownButton<DemoType>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.blueGrey),
        underline: Container(
          height: 2,
          color: Colors.blueAccent,
        ),
        value: currentValue,
        onChanged: (DemoType newValue) {
          setState(() {
            currentValue = newValue;
          });
          currentValue = newValue;

          onUpdate(currentValue);
        },
        items: DemoType.values.map((DemoType value) {
          return DropdownMenuItem<DemoType>(
              value: value, child: Text(value.toJsonString()));
        }).toList());
  }
}
