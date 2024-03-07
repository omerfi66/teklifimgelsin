class LoanOffer {
  final double annualRate;
  final String bank;
  final int bankId;
  final String bankType;
  final double interestRate;
  final String productName;
  final double sponsoredRate;
  final String url;

  LoanOffer({
    required this.annualRate,
    required this.bank,
    required this.bankId,
    required this.bankType,
    required this.interestRate,
    required this.productName,
    required this.sponsoredRate,
    required this.url,
  });

  factory LoanOffer.fromJson(Map<String, dynamic> json) {
    return LoanOffer(
      annualRate: (json['annual_rate'] as num).toDouble(),
      bank: json['bank'],
      bankId: json['bank_id'],
      bankType: json['bank_type'],
      interestRate: (json['interest_rate'] as num).toDouble(),
      productName: json['product_name'],
      sponsoredRate: (json['sponsored_rate'] as num).toDouble(),
      url: json['url'],
    );
  }
}

class ActiveOffers {
  double? annualRate;
  String? bank;
  int? bankId;
  String? bankType;
  String? detailNote;
  int? expertise;
  String? footnote;
  int? hypothecFee;
  double? interestRate;
  String? logoUrl;
  String? note;
  String? productName;
  int? sponsoredRate;
  String? url;

  ActiveOffers({
    this.annualRate,
    this.bank,
    this.bankId,
    this.bankType,
    this.detailNote,
    this.expertise,
    this.footnote,
    this.hypothecFee,
    this.interestRate,
    this.logoUrl,
    this.note,
    this.productName,
    this.sponsoredRate,
    this.url,
  });

  ActiveOffers.fromJson(Map<String, dynamic> json) {
    annualRate = json['annual_rate'];
    bank = json['bank'];
    bankId = json['bank_id'];
    bankType = json['bank_type'];
    detailNote = json['detail_note'];
    expertise = json['expertise'];
    footnote = json['footnote'];
    hypothecFee = json['hypothec_fee'];
    interestRate = json['interest_rate'];
    logoUrl = json['logo_url'];
    note = json['note'];
    productName = json['product_name'];
    sponsoredRate = json['sponsored_rate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['annual_rate'] = annualRate;
    data['bank'] = bank;
    data['bank_id'] = bankId;
    data['bank_type'] = bankType;
    data['detail_note'] = detailNote;
    data['expertise'] = expertise;
    data['footnote'] = footnote;
    data['hypothec_fee'] = hypothecFee;
    data['interest_rate'] = interestRate;
    data['logo_url'] = logoUrl;
    data['note'] = note;
    data['product_name'] = productName;
    data['sponsored_rate'] = sponsoredRate;
    data['url'] = url;
    return data;
  }
}

class PassiveOffers {
  double? annualRate;
  String? bank;
  int? bankId;
  String? bankType;
  String? detailNote;
  int? expertise;
  String? footnote;
  int? hypothecFee;
  double? interestRate;
  String? logoUrl;
  String? note;
  String? productName;
  int? sponsoredRate;
  String? url;

  PassiveOffers({
    this.annualRate,
    this.bank,
    this.bankId,
    this.bankType,
    this.detailNote,
    this.expertise,
    this.footnote,
    this.hypothecFee,
    this.interestRate,
    this.logoUrl,
    this.note,
    this.productName,
    this.sponsoredRate,
    this.url,
  });

  PassiveOffers.fromJson(Map<String, dynamic> json) {
    annualRate = json['annual_rate'];
    bank = json['bank'];
    bankId = json['bank_id'];
    bankType = json['bank_type'];
    detailNote = json['detail_note'];
    expertise = json['expertise'];
    footnote = json['footnote'];
    hypothecFee = json['hypothec_fee'];
    interestRate = json['interest_rate'];
    logoUrl = json['logo_url'];
    note = json['note'];
    productName = json['product_name'];
    sponsoredRate = json['sponsored_rate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['annual_rate'] = annualRate;
    data['bank'] = bank;
    data['bank_id'] = bankId;
    data['bank_type'] = bankType;
    data['detail_note'] = detailNote;
    data['expertise'] = expertise;
    data['footnote'] = footnote;
    data['hypothec_fee'] = hypothecFee;
    data['interest_rate'] = interestRate;
    data['logo_url'] = logoUrl;
    data['note'] = note;
    data['product_name'] = productName;
    data['sponsored_rate'] = sponsoredRate;
    data['url'] = url;
    return data;
  }
}

class SponsoredOffers {
  final String adButtonText;
  final String adContent;
  final String adDetails;
  final String adDisplayType;
  final String adHeader;
  final String adImgLink;
  final String adName;
  final String adUtmLink;
  final String badgeText;
  final String bank;
  final int bankId;
  final String endDate;
  final String footnote;
  final int listType;
  final String logoUrl;
  final int productType;
  final int sponsoredRate;

  SponsoredOffers({
    required this.adButtonText,
    required this.adContent,
    required this.adDetails,
    required this.adDisplayType,
    required this.adHeader,
    required this.adImgLink,
    required this.adName,
    required this.adUtmLink,
    required this.badgeText,
    required this.bank,
    required this.bankId,
    required this.endDate,
    required this.footnote,
    required this.listType,
    required this.logoUrl,
    required this.productType,
    required this.sponsoredRate,
  });

  factory SponsoredOffers.fromJson(Map<String, dynamic> json) {
    return SponsoredOffers(
      adButtonText: json['ad_button_text'],
      adContent: json['ad_content'],
      adDetails: json['ad_details'],
      adDisplayType: json['ad_display_type'],
      adHeader: json['ad_header'],
      adImgLink: json['ad_img_link'],
      adName: json['ad_name'],
      adUtmLink: json['ad_utm_link'],
      badgeText: json['badge_text'],
      bank: json['bank'],
      bankId: json['bank_id'],
      endDate: json['end_date'],
      footnote: json['footnote'],
      listType: json['list_type'],
      logoUrl: json['logo_url'],
      productType: json['product_type'],
      sponsoredRate: json['sponsored_rate'],
    );
  }
}

// class LoanOffer {
//   final double annualRate;
//   final String bank;
//   final int bankId;
//   final String bankType;
//   final double interestRate;
//   final String productName;
//   final double sponsoredRate;
//   final String url;

//   LoanOffer({
//     required this.annualRate,
//     required this.bank,
//     required this.bankId,
//     required this.bankType,
//     required this.interestRate,
//     required this.productName,
//     required this.sponsoredRate,
//     required this.url,
//   });

//   factory LoanOffer.fromJson(Map<String, dynamic> json) {
//     return LoanOffer(
//       annualRate: (json['annual_rate'] as num).toDouble(),
//       bank: json['bank'],
//       bankId: json['bank_id'],
//       bankType: json['bank_type'],
//       interestRate: (json['interest_rate'] as num).toDouble(),
//       productName: json['product_name'],
//       sponsoredRate: (json['sponsored_rate'] as num).toDouble(),
//       url: json['url'],
//     );
//   }
// }
