// The following class will model the data that is returned from the firebase call, based on the patient-records collection.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRecords {
  String firstName, lastName, emailAddress, cellNumber, dateOfBirth, firebaseID;

  // Constructor.
  UserRecords(
      {required this.firstName,
      required this.lastName,
      required this.emailAddress,
      required this.cellNumber,
      required this.dateOfBirth,
      required this.firebaseID});

  // Factory method.
  UserRecords.fromJson(Map<String, Object?> json)
      : this(
          firstName: json['firstName']! as String,
          lastName: json['lastName']! as String,
          emailAddress: json['emailAddress']! as String,
          cellNumber: json['cellNumber']! as String,
          dateOfBirth: json['dateOfBirth']! as String,
          firebaseID: json['firebaseID']! as String,
        );

  // Takes the pateint-records, returns a copy, but allows us to modify the instance returned (copy).
  UserRecords copyWith(
      {String? firstName,
      String? lastName,
      String? emailAddress,
      String? cellNumber,
      String? dateOfBirth,
      String? firebaseID}) {
    return UserRecords(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        emailAddress: emailAddress ?? this.emailAddress,
        cellNumber: cellNumber ?? this.cellNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        firebaseID: firebaseID ?? this.firebaseID);
  }

  // Returns a map formatted with the data.
  Map<String, Object?> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'cellNumber': cellNumber,
      'dateOfBirth': dateOfBirth,
      'firebaseID': firebaseID
    };
  }
}
