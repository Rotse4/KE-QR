import 'dart:convert';
import 'dart:typed_data';

class CalcCrc{
  int crc16Ccitt(Uint8List data, {int poly = 0x1021, int init = 0xFFFF}) {
  int crc = init;
  for (var byte in data) {
    crc ^= (byte << 8);
    for (int i = 0; i < 8; i++) {
      if ((crc & 0x8000) != 0) {
        crc = ((crc << 1) ^ poly) & 0xFFFF;
      } else {
        crc = (crc << 1) & 0xFFFF;
      }
    }
  }
  return crc;
}

String convertToAlphanumericSpecial(int crc) {
  String hexStr = crc.toRadixString(16).toUpperCase().padLeft(4, '0');
  StringBuffer alphanumericSpecial = StringBuffer();
  for (var char in hexStr.runes) {
    if (char >= '0'.codeUnitAt(0) && char <= '9'.codeUnitAt(0)) {
      alphanumericSpecial.writeCharCode(char);
    } else {
      alphanumericSpecial.writeCharCode(char - 'A'.codeUnitAt(0) + 65);
    }
  }
  return alphanumericSpecial.toString();
}

String carlculateCrc(String dataStr) {

  Uint8List dataBytes = utf8.encode(dataStr);

  // Calculate the CRC
  int crcValue = crc16Ccitt(dataBytes);

  // Convert CRC to Alphanumeric Special
  String checksumEncoded = convertToAlphanumericSpecial(crcValue);



  return checksumEncoded;
}

}
