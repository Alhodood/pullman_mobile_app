class EmirateIdModel {
  final String name;
  final String number;
  final String? issueDate;
  final String? expiryDate;
  final String? dateOfBirth;
  final String? nationality;
  final String? sex;
  String? selectVisiterType,currentDate,keyLog,selectAttendedBy,remark,visiterType;

  EmirateIdModel({
    required this.name,
    required this.number,
    this.issueDate,
    this.expiryDate,
    this.dateOfBirth,
    this.nationality,
    this.sex,
    this. selectVisiterType,
    this.currentDate, this.keyLog,this. selectAttendedBy,this. remark, this. visiterType
  });

  @override
  String toString() {
    return '''
Holder Name = $name
Number = $number
currentDate = $currentDate
keyLog = $keyLog
visiterType = $visiterType
attendedBy = $selectAttendedBy  
remarks = $remark

currentDate = $currentDate
Expiry Date = ${expiryDate ?? ""}
Issue Date = ${issueDate ?? ""}
Date of Birth = ${dateOfBirth ?? ""}
Nationality = ${nationality ?? ""}
Sex = ${sex ?? ""}
''';
  }
}
