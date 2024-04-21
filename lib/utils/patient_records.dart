// The following class will model the data that is returned from the firebase call, based on the patient-records collection.
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientRecords {
  int age;
  String firstName, lastName, insuranceCarrier, emailAddress, cellNumber;
  Map<String, Timestamp> recentVisits;

  // Constructor.
  PatientRecords(
      {required this.age,
      required this.firstName,
      required this.lastName,
      required this.insuranceCarrier,
      required this.recentVisits,
      required this.emailAddress,
      required this.cellNumber});

  // Factory method.
  PatientRecords.fromJson(Map<String, Object?> json)
      : this(
          age: json['age']! as int,
          firstName: json['firstName']! as String,
          lastName: json['lastName']! as String,
          insuranceCarrier: json['insuranceCarrier']! as String,
          recentVisits: (json['recentVisits'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, value as Timestamp),
          ),
          emailAddress: json['emailAddress']! as String,
          cellNumber: json['cellNumber']! as String,
        );

  // Takes the pateint-records, returns a copy, but allows us to modify the instance returned (copy).
  PatientRecords copyWith({
    int? age,
    String? firstName,
    String? lastName,
    String? insuranceCarrier,
    Map<String, Timestamp>? recentVisits,
    String? emailAddress,
    String? cellNumber,
  }) {
    return PatientRecords(
        age: age ?? this.age,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        insuranceCarrier: insuranceCarrier ?? this.insuranceCarrier,
        recentVisits: recentVisits ?? this.recentVisits,
        emailAddress: emailAddress ?? this.emailAddress,
        cellNumber: cellNumber ?? this.cellNumber);
  }

  // Returns a map formatted with the data.
  Map<String, Object?> toJson() {
    return {
      'age': age,
      'firstName': firstName,
      'lastName': lastName,
      'insuranceCarrier': insuranceCarrier,
      'recentVisits': recentVisits,
      'emailAddress': emailAddress,
      'cellNumber': cellNumber,
    };
  }
}
