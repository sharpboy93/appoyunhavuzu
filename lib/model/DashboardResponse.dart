class DashboardResponse {
  Appconfiguration? appconfiguration;
  Adsconfiguration? adsconfiguration;
  OnesignalConfiguration? onesignalConfiguration;
  List<Category>? featuredModule;
  List<Category>? category;
  List<SliderResponse>? slider;

  DashboardResponse({this.appconfiguration, this.onesignalConfiguration, this.adsconfiguration, this.featuredModule, this.category,this.slider});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    appconfiguration = json['appconfiguration'] != null ? new Appconfiguration.fromJson(json['appconfiguration']) : null;
    onesignalConfiguration = json['onesignal_configuration'] != null ? new OnesignalConfiguration.fromJson(json['onesignal_configuration']) : null;
    adsconfiguration = json['adsconfiguration'] != null ? new Adsconfiguration.fromJson(json['adsconfiguration']) : null;
    if (json['featured_game'] != null) {
      featuredModule = <Category>[];
      json['featured_game'].forEach((v) {
        featuredModule!.add(new Category.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = <SliderResponse>[];
      json['slider'].forEach((v) {
        slider!.add(new SliderResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appconfiguration != null) {
      data['appconfiguration'] = this.appconfiguration!.toJson();
    }
    if (this.onesignalConfiguration != null) {
      data['onesignal_configuration'] = this.onesignalConfiguration!.toJson();
    }
    if (this.adsconfiguration != null) {
      data['adsconfiguration'] = this.adsconfiguration!.toJson();
    }
    if (this.featuredModule != null) {
      data['featured_game'] = this.featuredModule!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appconfiguration {
  String? facebook;
  String? instagram;
  String? twitter;
  String? whatsapp;
  String? privacyPolicy;
  String? termsCondition;
  String? contactUs;
  String? aboutUs;
  String? copyright;

  Appconfiguration({this.facebook, this.instagram, this.twitter, this.whatsapp, this.privacyPolicy, this.termsCondition, this.contactUs, this.aboutUs, this.copyright});

  Appconfiguration.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    privacyPolicy = json['privacy_policy'];
    termsCondition = json['terms_condition'];
    contactUs = json['contact_us'];
    aboutUs = json['about_us'];
    copyright = json['copyright'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['whatsapp'] = this.whatsapp;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_condition'] = this.termsCondition;
    data['contact_us'] = this.contactUs;
    data['about_us'] = this.aboutUs;
    data['copyright'] = this.copyright;
    return data;
  }
}

class Adsconfiguration {
  String? adsType;
  String? admobBannerId;
  String? admobInterstitialId;
  String? admobBannerIdIos;
  String? admobInterstitialIdIos;
  String? facebookBannerId;
  String? facebookInterstitialId;
  String? facebookBannerIdIos;
  String? facebookInterstitialIdIos;
  String? interstitialAdsInterval;
  String? bannerAdGameList;
  String? bannerAdCategoryList;
  String? bannerAdGameDetail;
  String? bannerAdGameSearch;
  String? interstitialAdGameList;
  String? interstitialAdCategoryList;
  String? interstitialAdGameDetail;

  Adsconfiguration(
      {this.adsType,
      this.admobBannerId,
      this.admobInterstitialId,
      this.admobBannerIdIos,
      this.admobInterstitialIdIos,
      this.facebookBannerId,
      this.facebookInterstitialId,
      this.facebookBannerIdIos,
      this.facebookInterstitialIdIos,
      this.interstitialAdsInterval,
      this.bannerAdGameList,
      this.bannerAdCategoryList,
      this.bannerAdGameDetail,
      this.bannerAdGameSearch,
      this.interstitialAdGameList,
      this.interstitialAdCategoryList,
      this.interstitialAdGameDetail});

  Adsconfiguration.fromJson(Map<String, dynamic> json) {
    adsType = json['ads_type'];
    admobBannerId = json['admob_banner_id'];
    admobInterstitialId = json['admob_interstitial_id'];
    admobBannerIdIos = json['admob_banner_id_ios'];
    admobInterstitialIdIos = json['admob_interstitial_id_ios'];
    facebookBannerId = json['facebook_banner_id'];
    facebookInterstitialId = json['facebook_interstitial_id'];
    facebookBannerIdIos = json['facebook_banner_id_ios'];
    facebookInterstitialIdIos = json['facebook_interstitial_id_ios'];
    interstitialAdsInterval = json['interstitial_ads_interval'];
    bannerAdGameList = json['banner_ad_game_list'];
    bannerAdCategoryList = json['banner_ad_category_list'];
    bannerAdGameDetail = json['banner_ad_game_detail'];
    bannerAdGameSearch = json['banner_ad_game_search'];
    interstitialAdGameList = json['interstitial_ad_game_list'];
    interstitialAdCategoryList = json['interstitial_ad_category_list'];
    interstitialAdGameDetail = json['interstitial_ad_game_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_type'] = this.adsType;
    data['admob_banner_id'] = this.admobBannerId;
    data['admob_interstitial_id'] = this.admobInterstitialId;
    data['admob_banner_id_ios'] = this.admobBannerIdIos;
    data['admob_interstitial_id_ios'] = this.admobInterstitialIdIos;
    data['facebook_banner_id'] = this.facebookBannerId;
    data['facebook_interstitial_id'] = this.facebookInterstitialId;
    data['facebook_banner_id_ios'] = this.facebookBannerIdIos;
    data['facebook_interstitial_id_ios'] = this.facebookInterstitialIdIos;
    data['interstitial_ads_interval'] = this.interstitialAdsInterval;
    data['banner_ad_game_list'] = this.bannerAdGameList;
    data['banner_ad_category_list'] = this.bannerAdCategoryList;
    data['banner_ad_game_detail'] = this.bannerAdGameDetail;
    data['banner_ad_game_search'] = this.bannerAdGameSearch;
    data['interstitial_ad_game_list'] = this.interstitialAdGameList;
    data['interstitial_ad_category_list'] = this.interstitialAdCategoryList;
    data['interstitial_ad_game_detail'] = this.interstitialAdGameDetail;
    return data;
  }
}

class OnesignalConfiguration {
  String? appId;
  String? restApiKey;

  OnesignalConfiguration({this.appId, this.restApiKey});

  OnesignalConfiguration.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    restApiKey = json['rest_api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['rest_api_key'] = this.restApiKey;
    return data;
  }
}

class FeaturedModule {
  String? id;
  String? name;
  String? categoryId;
  String? logo;
  String? url;
  String? isFeatured;
  String? categoryName;

  FeaturedModule({this.id, this.name, this.categoryId, this.logo, this.url, this.isFeatured, this.categoryName});

  FeaturedModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    logo = json['logo'];
    url = json['url'];
    isFeatured = json['is_featured'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['logo'] = this.logo;
    data['url'] = this.url;
    data['is_featured'] = this.isFeatured;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? logo;
  String? categoryId;
  String? url;
  String? isFeatured;
  String? categoryName;
  List<Category>? games;

  Category({this.id, this.name, this.logo, this.url, this.isFeatured, this.categoryId, this.categoryName, this.games});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    categoryId = json['category_id'];
    url = json['url'];
    isFeatured = json['is_featured'];
    categoryName = json['category_name'];
    if (json['game'] != null) {
      games = <Category>[];
      json['game'].forEach((v) {
        games!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['category_id'] = this.categoryId;
    data['url'] = this.url;
    data['is_featured'] = this.isFeatured;
    data['category_name'] = this.categoryName;
    if (this.games != null) {
      data['game'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class SliderResponse {
  String? id;
  String? title;
  String? url;
  String? image;
  String? status;
  String? imageUrl;

  SliderResponse(
      {this.id, this.title, this.url, this.image, this.status, this.imageUrl});

  SliderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    status = json['status'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['image'] = this.image;
    data['status'] = this.status;
    data['image_url'] = this.imageUrl;
    return data;
  }
}