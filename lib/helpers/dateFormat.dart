DateTime deserializeDatestring(String datestring) {
  var day = datestring.substring(0, 2);
  var month = datestring.substring(3, 5);
  var year = datestring.substring(
    6,
  );
  String formattedDate = "$year$month$day";
  return DateTime.parse(formattedDate);
}
