import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'party.g.dart';

@JsonSerializable()
class Party implements JsonModel {
  Party({
    this.name,
    this.partyIdInfo,
    this.merchantClassificationCode,
    this.personalInfo,
  });

  @override
  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  /// Display name of the Party, could be a real name or a nick name.
  String name;

  /// Party Id type, id, sub ID or type, and FSP Id.
  PartyIdInfo partyIdInfo;

  /// Used in the context of Payee Information, where the Payee happens
  /// to be a merchant accepting merchant payments.
  String merchantClassificationCode;

  /// Personal information used to verify identity of Party such as
  /// first, middle, last name and date of birth.
  PartyPersonalInfo personalInfo;

  @override
  Map<String, dynamic> toJson() => _$PartyToJson(this);
}

@JsonSerializable()
class PartyIdInfo implements JsonModel {
  PartyIdInfo({
    this.fspId,
    this.partyIdType,
    this.partyIdentifier,
  });

  @override
  factory PartyIdInfo.fromJson(Map<String, dynamic> json) =>
      _$PartyIdInfoFromJson(json);

  /// Type of the identifier.
  PartyIdType partyIdType;

  /// An identifier for the Party.
  String partyIdentifier;

  /// A sub-identifier or sub-type for the Party.
  String partySubIdOrType;

  /// FSP ID.
  String fspId;

  @override
  Map<String, dynamic> toJson() => _$PartyIdInfoToJson(this);
}

/// Current allowed enumerations for the type of party id.
enum PartyIdType {
  @JsonValue('MSISDN')
  msisdn,

  @JsonValue('OPAQUE')
  opaque,
}

extension PartyIdTypeJson on PartyIdType {
  String toJsonString() {
    return _$PartyIdTypeEnumMap[this];
  }
}

@JsonSerializable()
class PartyPersonalInfo implements JsonModel {
  PartyPersonalInfo({
    this.complexName,
    this.dateOfBirth,
  });

  factory PartyPersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PartyPersonalInfoFromJson(json);

  /// First, middle and last name for the Party.
  PartyComplexName complexName;

  /// Date of birth for the Party.
  String dateOfBirth;

  @override
  Map<String, dynamic> toJson() => _$PartyPersonalInfoToJson(this);
}

@JsonSerializable()
class PartyComplexName implements JsonModel {
  PartyComplexName({
    this.firstName,
    this.middleName,
    this.lastName,
  });

  @override
  factory PartyComplexName.fromJson(Map<String, dynamic> json) =>
      _$PartyComplexNameFromJson(json);

  /// First name of the Party (Name Type).
  String firstName;

  /// Middle name of the Party (Name Type).
  String middleName;

  /// Last name of the Party (Name Type).
  String lastName;

  @override
  Map<String, dynamic> toJson() => _$PartyComplexNameToJson(this);
}
