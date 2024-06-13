import 'crc_calculaton.dart';
import 'models.dart';

class QrBuild {
  CalcCrc calcCrc=CalcCrc();
  String qr = "";

  void build(DataObject data, String pspId) {
    if (data.id == "28") {
      String nv = "$pspId${data.length}${data.value}";
      data.length = calcLength(nv);
      data.value = nv;
    }
    String dataObject = data.id! + data.length! + data.value!;

    qr += dataObject;
  }

  String calcLength(String value) {
    return value.length < 10 ? '0${value.length}' : value.length.toString();
  }

   generateQr(Map<String, String> dt,String pspId) {
    dt.forEach((id, value) {
      if (value.isNotEmpty && id != "63") {
        build(DataObject(id: id, value: value, length: calcLength(value)), pspId);
      }
    });

    String crc=calcCrc.carlculateCrc("${qr}6304");
    return "${qr}6304$crc";
  }
  
}

