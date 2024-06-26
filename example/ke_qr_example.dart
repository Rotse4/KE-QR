import 'package:ke_qr/ke_qr.dart';
import 'package:ke_qr/src/process.dart';
import 'package:ke_qr/src/qr_build.dart';

void main() {
  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');


  /* PROCESSING QR CODES */

  Process process = Process();
  var data=process.processQrCode("00020101021128134509123******53034045802KE5906******82262024-06-13 13:01:17.827890630469FF");
  print(data.transactionAmount?.value);

  //for ids with more than one value eg paymentadress you will access the list like shown below
  print(data.paymentAddress?.value?[0].value);

  //incase the qr code has been altered it will return null
  print(data.crc?.value);


  /* BUILDING QR CODE */

  QrBuild qrBuild = QrBuild();
    //The uncommented data is Mandatory ID 63 is added in default
    Map<String, String> buildingData = {
    "00": "01", // Don't change this
    "01": "11", // switch beween static and dynamic 11/12
    // "02": "12345678", // global PSPs visa mastercard etc 
    "28": "123******",//paymentAddress
    // "52": "4900",
    "53": "404", 
    // "54": "297.00",
    // "55": "",
    // "56": "",
    // "57": "",
    "58": "KE",
    "59": "******",
    // "60": "NAIROBI",
    // "61": "00",
    // "62": "030800112349070511002",
    // "64": "",

/*(Referenced for future use) RFU for EMVCo 

    "65": "",
    "66": "",
    "67": "",
    "68": "",
    "69": "",
    "70": "",
    "71": "",
    "72": "",
    "73": "",
    "74": "",
    "75": "",
    "76": "",
    "77": "",
    "78": "",
    "79": "",

*/

    "82": DateTime.now().toString(),
  };

  var qrData = qrBuild.generateQr(buildingData, "45");

  print(qrData);

}
