
import 'package:ke_qr/src/crc_calculaton.dart';

import 'models.dart';

class Process {
  var calcCrc = CalcCrc();

  List<String> reservedIds = [
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27"
  ];

  Map<String, dynamic> data = {
    "formarIndicator": DataObject(),
    "initiationMethod": DataObject(),
    "paymentAddress": DataObject(),
    "globalAccounts": DataObject(),
    "merchantCategory": DataObject(),
    "transactionCurrency": DataObject(),
    "transactionAmount": DataObject(),
    "coninienceIndicator": DataObject(),
    "convenienceFixedFee": DataObject(),
    "coviniencePercentageFee": DataObject(),
    "countryCode": DataObject(),
    "merchantName": DataObject(),
    "merchantCity": DataObject(),
    "postalCode": DataObject(),
    "additionalData": DataObject<List<DataObject>>(),
    "crc": DataObject(),
    "merchantLanguageInformation": DataObject(),
    "rfuEmvco": DataObject(),
    "merchantLocation": DataObject(),
    "merchantUSSD": DataObject(),
    "timestamp": DataObject(),
    "safaricom": DataObject(),
    "unreservedTemplates": DataObject(),
  };

  sbProcess(String subInput) {
    List<DataObject> subvalues = [];

    int subcount = 0;
    const subincrement = 2;

    while (subcount < subInput.length) {
      String subid = subInput.substring(subcount, subcount + subincrement);
      subcount += subincrement;

      String subLength = subInput.substring(subcount, subcount + subincrement);
      subcount += subincrement;

      int subvalueLength = int.parse(subLength);
      String subValue = subInput.substring(subcount, subcount + subvalueLength);
      subcount += subvalueLength;

      subvalues.add(DataObject(id: subid, length: subLength, value: subValue));
    }

    return subvalues;
  }



  // Output variables
  String amount = "";
  String merchantName = "";
  List<String> acc = [];

  // Process QR code
  QrCode processQrCode(String input) {
    String calculatedcrc =
        calcCrc.carlculateCrc(input.substring(0, input.length - 4));
    String providedCrc = input.substring(input.length - 4);

    if (providedCrc == calculatedcrc) {
      int count = 0;
      const increment = 2;



      while (count < input.length) {
        String id = input.substring(count, count + increment);
        count += increment;

        String length = input.substring(count, count + increment);
        count += increment;

        int valueLength = int.parse(length);
        String value = input.substring(count, count + valueLength);
        count += valueLength;

        if (id == "28") {
          data["paymentAddress"] = DataObject<List<DataObject>>(
              id: id, length: length, value: sbProcess(value));
        } else if (id == "54") {
          amount = value;
          data["transactionAmount"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "59") {
          merchantName = value;
          data["merchantName"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "00") {
          data["formarIndicator"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "01") {
          data["initiationMethod"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "52") {
          data["merchantCategory"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "53") {
          data["transactionCurrency"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "54") {
          data["transactionAmount"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "55") {
          data["coninienceIndicator"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "56") {
          data["convenienceFixedFee"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "57") {
          data["coviniencePercentageFee"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "58") {
          data["countryCode"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "59") {
          data["merchantName"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "60") {
          data["merchantCity"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "61") {
          data["postalCode"] = DataObject(id: id, length: length, value: value);
        } else if (id == "62") {
          //  (data["additionalData"] as DataObject<List<DataObject>>).value?.add(additionalDataItem);
          data["additionalData"] = DataObject<List<DataObject>>(
              id: id, length: length, value: sbProcess(value));
        } else if (id == "63") {
          data["crc"] = DataObject(id: id, length: length, value: value);
        } else if (id == "64") {
          data["merchantLanguageInformation"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "65" ||
            id == "66" ||
            id == "67" ||
            id == "68" ||
            id == "69" ||
            id == "70" ||
            id == "71" ||
            id == "72" ||
            id == "73" ||
            id == "74" ||
            id == "75" ||
            id == "76" ||
            id == "77" ||
            id == "78" ||
            id == "79") {
          data["rfuEmvco"] = DataObject(id: id, length: length, value: value);
        } else if (id == "80") {
          data["merchantLocation"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "81") {
          data["merchantUSSD"] =
              DataObject(id: id, length: length, value: value);
        } else if (id == "82") {
          data["timestamp"] = DataObject(id: id, length: length, value: value);
        } else if (id == "83") {
          data["safaricom"] = DataObject(id: id, length: length, value: value);
        } else if (id == "84") {
          data["unreservedTemplates"] =
              DataObject(id: id, length: length, value: value);
        } else if (reservedIds.contains(id)) {
          // amount = value;
          print("found $value");
          data["globalAccounts"] =
              DataObject(id: id, length: length, value: value);
        }
      }
    }
    return QrCode(
      paymentAddress: data["paymentAddress"],
      timestamp: data["timestamp"],
      transactionAmount: data["transactionAmount"],
      globalAccounts: data["globalAccounts"],
      formarIndicator: data["formarIndicator"],
      initiationMethod: data["initiationMethod"],
      merchantCategory: data["merchantCategory"],
      transactionCurrency: data["transactionCurrency"],
      coninienceIndicator: data["coninienceIndicator"],
      convenienceFixedFee: data["convenienceFixedFee"],
      coviniencePercentageFee: data["coviniencePercentageFee"],
      countryCode: data["countryCode"],
      merchantName: data["merchantName"],
      merchantCity: data["merchantCity"],
      postalCode: data["postalCode"],
      additionalData: data["additionalData"],
      crc: data["crc"],
      merchantLanguageInformation: data["merchantLanguageInformation"],
      rfuEmvco: data["rfuEmvco"],
      merchantLocation: data["merchantLocation"],
      merchantUSSD: data["merchantUSSD"],
      safaricom: data["safaricom"],
      unreservedTemplates: data["unreservedTemplates"],
    );
  }
}
