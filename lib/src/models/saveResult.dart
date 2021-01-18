import 'package:ocr_mobile/src/models/form.dart';

class SaveResult {
  String name;
  String result;
  String remarks;
  //attached file
  String document;
  String documentType;
  MyForm form;

  SaveResult(
      {this.name,
      this.result,
      this.remarks,
      this.document,
      this.documentType,
      this.form});

  factory SaveResult.fromJson(Map<String, dynamic> jsonData) {
    return SaveResult(
      name: jsonData['name'],
      result: jsonData['result'],
      remarks: jsonData['remarks'],
      document: jsonData['document'],
      documentType: jsonData['documentType'],
      form: jsonData['form'],
    );
  }
}
