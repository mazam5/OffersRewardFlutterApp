class Model1 {
  final String taskId;
  final String title;
  final String thumbnail;
  final String shortDesc;
  final String payout;
  final String ctaShort;
  final String ctaLong;
  final String type;
  final String totalLead;
  final bool isTrending;
  final String earned;
  final String status;
  final String isCompleted;
  final Brand brand;
  final int payoutAmt;
  final String payoutCurrency;
  final String ctaAction;
  final CustomData customData;

  Model1({
    required this.taskId,
    required this.title,
    required this.thumbnail,
    required this.shortDesc,
    required this.payout,
    required this.ctaShort,
    required this.ctaLong,
    required this.type,
    required this.totalLead,
    required this.isTrending,
    required this.earned,
    required this.status,
    required this.isCompleted,
    required this.brand,
    required this.payoutAmt,
    required this.payoutCurrency,
    required this.ctaAction,
    required this.customData,
  });

  factory Model1.fromJson(Map<String, dynamic> json) {
    return Model1(
      taskId: json['taskId'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      shortDesc: json['shortDesc'],
      payout: json['payout'],
      ctaShort: json['ctaShort'],
      ctaLong: json['ctaLong'],
      type: json['type'],
      totalLead: json['total_lead'],
      isTrending: json['isTrending'],
      earned: json['earned'],
      status: json['status'],
      isCompleted: json['isCompleted'],
      brand: Brand.fromJson(json['brand']),
      payoutAmt: json['payout_amt'],
      payoutCurrency: json['payout_currency'],
      ctaAction: json['ctaAction'],
      customData: CustomData.fromJson(json['custom_data']),
    );
  }
}

class Brand {
  final String brandId;
  final String title;
  final String logo;

  Brand({
    required this.brandId,
    required this.title,
    required this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['brandId'],
      title: json['title'],
      logo: json['logo'],
    );
  }
}

class CustomData {
  final String appRating;
  final String wallUrl;
  final String dominantColor;

  CustomData({
    required this.appRating,
    required this.wallUrl,
    required this.dominantColor,
  });

  factory CustomData.fromJson(Map<String, dynamic> json) {
    return CustomData(
      appRating: json['app_rating'],
      wallUrl: json['wall_url'],
      dominantColor: json['dominant_color'],
    );
  }
}
