import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StepModel {
  String stepName = "";
  String stepInstruction = "";
  String personalTouch = "";

  StepModel(this.stepName, this.stepInstruction, this.personalTouch);

  Map toJson() {
    return {
      "stepName": stepName,
      "stepInstruction": stepInstruction,
      "personalTouch": personalTouch
    };
  }

  factory StepModel.fromJson(QueryDocumentSnapshot snapshot) {
    return StepModel(snapshot['stepName'], snapshot['stepInstruction'],
        snapshot['personalTouch']);
  }
}
