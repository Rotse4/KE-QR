class DataObject <T>{
  String? id;
  String? length;
  // T? value;
  T? value;


  DataObject({
     this.id,
     this.length,
     this.value,
  });
}


class QrCode {
  DataObject? formarIndicator; // 00  merchant QR Code version
  DataObject? initiationMethod; // 01 static or dynamic
  DataObject? paymentAddress; //02-27 visa mastercard etc accounts
  DataObject? globalAccounts;  // 28-51 account or payment address
  DataObject? merchantCategory; // 52 business category
  DataObject? transactionCurrency; // 53 transaction currency
  DataObject? transactionAmount; // 54 amount
  DataObject?coninienceIndicator; //55 whether the consumer will be prompted to enter a tip
  DataObject? convenienceFixedFee; // 56 fixed fee depends on 55
  DataObject? coviniencePercentageFee; // 57 percentage fee depends on 55
  DataObject? countryCode; // 58
  DataObject? merchantName; // 59
  DataObject? merchantCity; // 60
  DataObject? postalCode; // 61
  DataObject<List<DataObject>>? additionalData; // 62 additional Template
  DataObject? crc; // 63 checksum calculation
  DataObject? merchantLanguageInformation; // 64 alternative language
  DataObject? rfuEmvco; // 65-79 global standards
  DataObject? merchantLocation; // 80 geolocation precission
  DataObject? merchantUSSD; //reserch 81
  DataObject? timestamp; //82
  DataObject? safaricom; // 83 safaricom preserved
  DataObject? unreservedTemplates; //84-99

  QrCode({
    required this.paymentAddress,
    required this.timestamp,
    required this.transactionAmount,
    required this.formarIndicator,
    required this.initiationMethod,
    this.globalAccounts,
    this.merchantCategory,
    this.transactionCurrency,
    this.coninienceIndicator,
    this.convenienceFixedFee,
    this.coviniencePercentageFee,
    this.countryCode,
    this.merchantName,
    this.merchantCity,
    this.postalCode,
    this.additionalData,
    this.crc,
    this.merchantLanguageInformation,
    this.rfuEmvco,
    this.merchantLocation,
    this.merchantUSSD,
    this.safaricom,
    this.unreservedTemplates,
  });
}


