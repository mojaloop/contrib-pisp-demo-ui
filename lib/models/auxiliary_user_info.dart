import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/repositories/firebase/user_data_repository.dart';
import 'package:pispapp/utils/utils.dart';

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

  static AuxiliaryUserInfo fromJson(Map<String, dynamic> json) {
    final String phoneNo = json[UserDataRepository.PHONE_NO_KEY] as String;
    final String countryCode =
        json[UserDataRepository.PHONE_NO_COUNTRY_CODE_KEY] as String;
    final String dateRegistered =
        json[UserDataRepository.REGISTRATION_DATE_KEY] as String;
    final PISPPhoneNumber number = (phoneNo == null || countryCode == null)
        ? null
        : PISPPhoneNumber(countryCode, phoneNo);

    final DemoType demoType = Utils.$enumDecodeNullable(
        DemoTypeEnumMap, json[UserDataRepository.DEMO_TYPE_KEY]);
    final LiveSwitchLinkingScenario liveSwitchLinkingScenario =
        Utils.$enumDecodeNullable(LiveSwitchLinkingScenarioMap,
            json[UserDataRepository.LIVE_SWITCH_LINKING_SCENARIO]);

    return AuxiliaryUserInfo(
        phoneNumber: number,
        registrationDate: dateRegistered,
        demoType: demoType,
        liveSwitchLinkingScenario: liveSwitchLinkingScenario);
  }

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
