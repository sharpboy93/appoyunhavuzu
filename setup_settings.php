<?php
require_once('configuration/Database.php');
require_once('model/AppSetting.php');

$db = new Database();
$appSetting = new AppSetting();

// App Configuration
$appConfig = [
    "termsCondition" => "Terms and conditions content",
    "privacyPolicy" => "Privacy policy content",
    "contactUs" => "Contact information",
    "aboutUs" => "About us content",
    "facebook" => "https://facebook.com/oyunhavuzu",
    "whatsapp" => "",
    "twitter" => "https://twitter.com/oyunhavuzu",
    "instagram" => "https://instagram.com/oyunhavuzu",
    "copyright" => "© 2024 Oyun Havuzu"
];

$appSetting->mightySave('appconfiguration', json_encode($appConfig));

// Ads Configuration
$adsConfig = [
    "adsType" => "admob",
    "facebookBannerId" => "",
    "facebookInterstitialId" => "",
    "admobBannerId" => "",
    "admobInterstitialId" => "",
    "facebookBannerIdIos" => "",
    "facebookInterstitialIdIos" => "",
    "admobBannerIdIos" => "",
    "admobInterstitialIdIos" => "",
    "interstitialAdsInterval" => "3"
];

$appSetting->mightySave('adsconfiguration', json_encode($adsConfig));

// API Configuration
$apiConfig = [
    "limit" => 10,
    "category_order" => "ASC",
    "category_orderby" => "id",
    "game_order" => "ASC",
    "game_orderby" => "id"
];

$appSetting->mightySave('apiconfiguration', json_encode($apiConfig));

echo "Settings updated successfully!";
?>
