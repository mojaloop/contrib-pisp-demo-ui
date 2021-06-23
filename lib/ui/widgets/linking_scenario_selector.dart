import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';

class LinkingScenarioSelector extends StatefulWidget {
  LinkingScenarioSelector({this.onUpdate, this.initialValue});

  final LiveSwitchLinkingScenario initialValue;
  final void Function(LiveSwitchLinkingScenario) onUpdate;

  @override
  _LinkingScenarioSelectorState createState() => _LinkingScenarioSelectorState(
      onUpdate: onUpdate, initialValue: initialValue);
}

class _LinkingScenarioSelectorState extends State<LinkingScenarioSelector> {
  _LinkingScenarioSelectorState({this.onUpdate, this.initialValue});

  final LiveSwitchLinkingScenario initialValue;
  LiveSwitchLinkingScenario currentValue;

  final void Function(LiveSwitchLinkingScenario) onUpdate;

  @override
  Widget build(BuildContext context) {
    currentValue ??= initialValue;

    return DropdownButton<LiveSwitchLinkingScenario>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.blueGrey),
        underline: Container(
          height: 2,
          color: Colors.blueAccent,
        ),
        value: currentValue,
        onChanged: (LiveSwitchLinkingScenario newValue) {
          setState(() {
            currentValue = newValue;
          });
          currentValue = newValue;

          onUpdate(currentValue);
        },
        items: LiveSwitchLinkingScenario.values
            .map((LiveSwitchLinkingScenario value) {
          return DropdownMenuItem<LiveSwitchLinkingScenario>(
              value: value, child: Text(value.toJsonString()));
        }).toList());
  }
}
