class LoanOffer {
  List<ActiveOffers>? activeOffers;
  int? amount;
  String? carCondition;
  int? clientId;
  String? createdAt;
  int? id;
  int? maturity;
  List<PassiveOffers>? passiveOffers;
  List<SponsoredOffers>? sponsoredOffers;
  String? type;

  LoanOffer(
      {this.activeOffers,
      this.amount,
      this.carCondition,
      this.clientId,
      this.createdAt,
      this.id,
      this.maturity,
      this.passiveOffers,
      this.sponsoredOffers,
      this.type});

  LoanOffer.fromJson(Map<String, dynamic> json) {
    if (json['active_offers'] != String) {
      activeOffers = <ActiveOffers>[];
      json['active_offers'].forEach((v) {
        activeOffers!.add(ActiveOffers.fromJson(v));
      });
    }
    amount = json['amount'];
    carCondition = json['carCondition'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    id = json['id'];
    maturity = json['maturity'];
    if (json['passive_offers'] != String) {
      passiveOffers = <PassiveOffers>[];
      json['passive_offers'].forEach((v) {
        passiveOffers!.add(PassiveOffers.fromJson(v));
      });
    }
    if (json['sponsored_offers'] != String) {
      sponsoredOffers = <SponsoredOffers>[];
      json['sponsored_offers'].forEach((v) {
        sponsoredOffers!.add(SponsoredOffers.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activeOffers != String) {
      data['active_offers'] = activeOffers!.map((v) => v.toJson()).toList();
    }
    data['amount'] = amount;
    data['carCondition'] = carCondition;
    data['client_id'] = clientId;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['maturity'] = maturity;
    if (passiveOffers != String) {
      data['passive_offers'] = passiveOffers!.map((v) => v.toJson()).toList();
    }
    if (sponsoredOffers != String) {
      data['sponsored_offers'] =
          sponsoredOffers!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    return data;
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

  ActiveOffers(
      {this.annualRate,
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
      this.url});

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

  PassiveOffers(
      {this.annualRate,
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
      this.url});

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
  String? adButtonText;
  String? adContent;
  String? adDetails;
  String? adDisplayType;
  String? adHeader;
  String? adImgLink;
  String? adName;
  String? adUtmLink;
  String? badgeText;
  String? bank;
  int? bankId;
  String? endDate;
  String? footnote;
  int? listType;
  String? logoUrl;
  int? productType;
  int? sponsoredRate;

  SponsoredOffers(
      {this.adButtonText,
      this.adContent,
      this.adDetails,
      this.adDisplayType,
      this.adHeader,
      this.adImgLink,
      this.adName,
      this.adUtmLink,
      this.badgeText,
      this.bank,
      this.bankId,
      this.endDate,
      this.footnote,
      this.listType,
      this.logoUrl,
      this.productType,
      this.sponsoredRate});

  SponsoredOffers.fromJson(Map<String, dynamic> json) {
    adButtonText = json['ad_button_text'];
    adContent = json['ad_content'];
    adDetails = json['ad_details'];
    adDisplayType = json['ad_display_type'];
    adHeader = json['ad_header'];
    adImgLink = json['ad_img_link'];
    adName = json['ad_name'];
    adUtmLink = json['ad_utm_link'];
    badgeText = json['badge_text'];
    bank = json['bank'];
    bankId = json['bank_id'];
    endDate = json['end_date'];
    footnote = json['footnote'];
    listType = json['list_type'];
    logoUrl = json['logo_url'];
    productType = json['product_type'];
    sponsoredRate = json['sponsored_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad_button_text'] = adButtonText;
    data['ad_content'] = adContent;
    data['ad_details'] = adDetails;
    data['ad_display_type'] = adDisplayType;
    data['ad_header'] = adHeader;
    data['ad_img_link'] = adImgLink;
    data['ad_name'] = adName;
    data['ad_utm_link'] = adUtmLink;
    data['badge_text'] = badgeText;
    data['bank'] = bank;
    data['bank_id'] = bankId;
    data['end_date'] = endDate;
    data['footnote'] = footnote;
    data['list_type'] = listType;
    data['logo_url'] = logoUrl;
    data['product_type'] = productType;
    data['sponsored_rate'] = sponsoredRate;
    return data;
  }
}
