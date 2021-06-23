import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/phone_number.dart';

import 'model.dart';

enum DemoType {
  @JsonValue('simulatedSwitch')
  simulatedSwitch,

  @JsonValue('liveSwitch')
  liveSwitch,
}

const DemoTypeEnumMap = {
  DemoType.simulatedSwitch: 'simulatedSwitch',
  DemoType.liveSwitch: 'liveSwitch',
};

extension DemoTypeJson on DemoType {
  String toJsonString() {
    return DemoTypeEnumMap[this];
  }
}

enum LiveSwitchLinkingScenario {
  // Use none if using the simulated switch
  // or if you don't want the demo to prefill variables for you
  // such as the consentRequestId
  @JsonValue('none')
  none,

  @JsonValue('webLoginSuccess')
  webLoginSuccess,

  @JsonValue('otpLoginSuccess')
  otpLoginSuccess,

  // Add other linking scenarios here if you want
}

const LiveSwitchLinkingScenarioMap = {
  LiveSwitchLinkingScenario.none: 'none',
  LiveSwitchLinkingScenario.otpLoginSuccess: 'otpLoginSuccess',
  LiveSwitchLinkingScenario.webLoginSuccess: 'webLoginSuccess',
};

extension LiveSwitchLinkingScenarioJson on LiveSwitchLinkingScenario {
  String toJsonString() {
    return LiveSwitchLinkingScenarioMap[this];
  }
}

// ignore: must_be_immutable
class AuxiliaryUserInfo extends Equatable implements Model {
  AuxiliaryUserInfo(
      {this.registrationDate,
      this.phoneNumber,
      this.demoType,
      this.liveSwitchLinkingScenario});

  String registrationDate;
  PISPPhoneNumber phoneNumber;
  DemoType demoType;
  LiveSwitchLinkingScenario liveSwitchLinkingScenario;

  @override
  List<Object> get props => [registrationDate, phoneNumber];

  String getFormattedPhoneNoForDisplay() {
    if (phoneNumber == null ||
        (phoneNumber.countryCode == null && phoneNumber.number == null)) {
      return 'n/a';
    }
    return (phoneNumber.countryCode ?? '') + (phoneNumber.number ?? '');
  }

  String getFormattedRegistrationDateForDisplay() {
    return registrationDate == null ? 'n/a' : registrationDate.split('T')[0];
  }
}
