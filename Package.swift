// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLovinSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // MARK: - AppLovin MAX SDK
        .library(
            name: "AppLovinSDK",
            targets: ["AppLovinSDKResources"]
        ),

        // MARK: - Mediation Adapters
        .library(name: "AppLovinDSPLinkedInAdapter", targets: ["AppLovinDSPLinkedInAdapter"]),
        .library(name: "AppLovinMediationAmazonAdMarketplaceAdapter", targets: ["AppLovinMediationAmazonAdMarketplaceAdapter"]),
        .library(name: "AppLovinMediationBidMachineAdapter", targets: ["AppLovinMediationBidMachineAdapter"]),
        .library(name: "AppLovinMediationBigoAdsAdapter", targets: ["AppLovinMediationBigoAdsAdapter"]),
        .library(name: "AppLovinMediationByteDanceAdapter", targets: ["AppLovinMediationByteDanceAdapter"]),
        .library(name: "AppLovinMediationChartboostAdapter", targets: ["AppLovinMediationChartboostAdapter"]),
        .library(name: "AppLovinMediationFacebookAdapter", targets: ["AppLovinMediationFacebookAdapter"]),
        .library(name: "AppLovinMediationFyberAdapter", targets: ["AppLovinMediationFyberAdapter"]),
        .library(name: "AppLovinMediationGoogleAdManagerAdapter", targets: ["AppLovinMediationGoogleAdManagerAdapter"]),
        .library(name: "AppLovinMediationGoogleAdapter", targets: ["AppLovinMediationGoogleAdapter"]),
        .library(name: "AppLovinMediationInMobiAdapter", targets: ["AppLovinMediationInMobiAdapter"]),
        .library(name: "AppLovinMediationIronSourceAdapter", targets: ["AppLovinMediationIronSourceAdapter"]),
        .library(name: "AppLovinMediationLineAdapter", targets: ["AppLovinMediationLineAdapter"]),
        .library(name: "AppLovinMediationMintegralAdapter", targets: ["AppLovinMediationMintegralAdapter"]),
        .library(name: "AppLovinMediationMobileFuseAdapter", targets: ["AppLovinMediationMobileFuseAdapter"]),
        .library(name: "AppLovinMediationMolocoAdapter", targets: ["AppLovinMediationMolocoAdapter"]),
        .library(name: "AppLovinMediationMyTargetAdapter", targets: ["AppLovinMediationMyTargetAdapter"]),
        .library(name: "AppLovinMediationOguryPresageAdapter", targets: ["AppLovinMediationOguryPresageAdapter"]),
        .library(name: "AppLovinMediationPubMaticAdapter", targets: ["AppLovinMediationPubMaticAdapter"]),
        .library(name: "AppLovinMediationSmaatoAdapter", targets: ["AppLovinMediationSmaatoAdapter"]),
        .library(name: "AppLovinMediationUnityAdsAdapter", targets: ["AppLovinMediationUnityAdsAdapter"]),
        .library(name: "AppLovinMediationVerveAdapter", targets: ["AppLovinMediationVerveAdapter"]),
        .library(name: "AppLovinMediationVungleAdapter", targets: ["AppLovinMediationVungleAdapter"]),
        .library(name: "AppLovinMediationYSONetworkAdapter", targets: ["AppLovinMediationYSONetworkAdapter"]),
        .library(name: "AppLovinMediationYandexAdapter", targets: ["AppLovinMediationYandexAdapter"]),
    ],
    dependencies: [
        // ✅ Google Mobile Ads SDK (Google / GoogleAdManager 适配器依赖)
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            from: "13.0.0"
        ),
        // ✅ Vungle/Liftoff SDK
        .package(
            url: "https://github.com/Vungle/VungleAdsSDK-SwiftPackageManager.git",
            from: "7.0.0"
        ),
        // ✅ Mintegral SDK
        .package(
            url: "https://github.com/Mintegral-official/MintegralAdSDK-Swift-Package.git",
            from: "7.0.0"
        ),
        // ✅ myTarget SDK
        .package(
            url: "https://github.com/myTargetSDK/mytarget-ios-spm.git",
            from: "5.0.0"
        ),
        // ✅ Yandex Mobile Ads SDK
        .package(
            url: "https://github.com/yandexmobile/yandex-ads-sdk-ios.git",
            from: "7.0.0"
        ),
        .package(url: "https://github.com/facebook/FBAudienceNetwork.git", from: "6.21.1")
        // ⚠️ 以下 SDK 无官方 SPM 支持，需通过 CocoaPods 或手动集成：
        // ChartboostSDK               — CocoaPods: pod 'ChartboostSDK'
        // Ads-Global (ByteDance/Pangle)— CocoaPods: pod 'Ads-Global'
        // InMobiSDK                   — CocoaPods: pod 'InMobiSDK'
        // IronSourceSDK               — CocoaPods: pod 'IronSourceSDK'
        // FiveAd (Line)               — CocoaPods: pod 'FiveAd'
        // LinkedinAudienceNetwork     — CocoaPods: pod 'LinkedinAudienceNetwork'
        // BidMachine                  — CocoaPods: pod 'BidMachine'
        // BigoADS                     — CocoaPods: pod 'BigoADS'
        // Fyber_Marketplace_SDK       — CocoaPods: pod 'Fyber_Marketplace_SDK'
        // MobileFuseSDK               — CocoaPods: pod 'MobileFuseSDK'
        // MolocoSDKiOS                — CocoaPods: pod 'MolocoSDKiOS'
        // OgurySdk                    — CocoaPods: pod 'OgurySdk'
        // OpenWrapSDK (PubMatic)      — CocoaPods: pod 'OpenWrapSDK'
        // smaato-ios-sdk              — CocoaPods: pod 'smaato-ios-sdk'
        // UnityAds                    — CocoaPods: pod 'UnityAds'
        // HyBid (Verve)              — CocoaPods: pod 'HyBid'
        // YsoNetworkSDK               — CocoaPods: pod 'YsoNetworkSDK'
        // Amazon Ad Marketplace       — See Amazon APS SDK integration guide
    ],
    targets: [

        // MARK: - AppLovin MAX SDK
        // This wrapper target configures the required linker settings for the binary target.
        // NOTE: SPM does not support unsafeFlags on binary targets directly.
        // Add `-ObjC` to "Other Linker Flags" in your Xcode project manually.
        .target(
            name: "AppLovinSDKResources",
            dependencies: [
                .target(name: "AppLovinSDK")
            ],
            path: "Sources/AppLovinSDKResources",
            linkerSettings: [
                .linkedFramework("AdSupport"),
                .linkedFramework("AppTrackingTransparency"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Foundation"),
                .linkedFramework("MessageUI"),
                .linkedFramework("SafariServices"),
                .linkedFramework("StoreKit"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("UIKit"),
                .linkedFramework("WebKit"),
                .linkedLibrary("z"),
            ]
        ),
        .binaryTarget(
            name: "AppLovinSDK",
            url: "https://artifacts.applovin.com/ios/com/applovin/applovin-sdk/AppLovinSDK-13.6.0.xcframework.zip",
            checksum: "a7f6701b24f67c55a0beabfcc06b31660590dceb410e3e6bae67b4fd4d817349"
        ),

        // MARK: - Mediation Adapters
        // Adapters with ✅ have their network SDK declared as an SPM dependency above.
        // Adapters with ⚠️ require the network SDK to be integrated separately (CocoaPods/manual).

        // ⚠️ LinkedIn DSP — LinkedinAudienceNetwork has no SPM package
        .binaryTarget(
            name: "AppLovinDSPLinkedInAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/dsp/linkedin-adapter/AppLovinDSPLinkedInAdapter-1.2.2.0.zip",
            checksum: "5dd10ee6abdd9cde69731fc734f1ce1b1ceb902b6c79b0d77412ef51748951f7"
        ),

        // ⚠️ Amazon — Amazon APS SDK requires manual/custom integration
        .binaryTarget(
            name: "AppLovinMediationAmazonAdMarketplaceAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/amazonadmarketplace-adapter/AppLovinMediationAmazonAdMarketplaceAdapter-5.4.0.0.zip",
            checksum: "416fc953023dcc023fee42b0caec9eac104fabb62ba196889ccf67c4ac4f4e52"
        ),

        // ⚠️ BidMachine — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationBidMachineAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/bidmachine-adapter/AppLovinMediationBidMachineAdapter-3.5.1.0.0.zip",
            checksum: "6aae4323800c7b81c3b247f5d87063af9e726f1a31262a18c2b8847d24bbaf8b"
        ),

        // ⚠️ BigoAds — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationBigoAdsAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/bigoads-adapter/AppLovinMediationBigoAdsAdapter-5.1.0.0.zip",
            checksum: "8db0f10fdd37425fd9c85fdfffff9a99de6e1d85c500f84ed55412aad7d32f0a"
        ),

        // ⚠️ ByteDance/Pangle — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationByteDanceAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/bytedance-adapter/AppLovinMediationByteDanceAdapter-7.9.0.6.1.zip",
            checksum: "45d2111b8ef7eb66f23b6e950ff76d6a0c7f57a7ab775a73c164837d7b0a741d"
        ),

        // ⚠️ Chartboost — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationChartboostAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/chartboost-adapter/AppLovinMediationChartboostAdapter-9.11.0.0.zip",
            checksum: "33ffd18f267a21c10e61d0183da772337f3a9d8fcef6580df5602b6caf412d64"
        ),

        // ✅ Facebook/Meta Audience Network — FBAudienceNetwork declared in dependencies
        .target(
            name: "AppLovinMediationFacebookAdapter",
            dependencies: [
                .target(name: "AppLovinMediationFacebookAdapterBinary"),
                .product(name: "FBAudienceNetwork", package: "FBAudienceNetwork"),
            ],
            path: "Sources/AppLovinMediationFacebookAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationFacebookAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/facebook-adapter/AppLovinMediationFacebookAdapter-6.21.1.0.zip",
            checksum: "69069f3c153a9387a355a2e4e9ed322bcc4fcec7b0f5bc80fa9880e9c69c1ccb"
        ),

        // ⚠️ Fyber/Digital Turbine — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationFyberAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/fyber-adapter/AppLovinMediationFyberAdapter-8.4.5.0.zip",
            checksum: "72f06575608287944a2aac74ac99d47b141747ee4e73880cdcc0190881e7b3af"
        ),

        // ✅ Google AdManager — GoogleMobileAds declared in dependencies
        .target(
            name: "AppLovinMediationGoogleAdManagerAdapter",
            dependencies: [
                .target(name: "AppLovinMediationGoogleAdManagerAdapterBinary"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/AppLovinMediationGoogleAdManagerAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationGoogleAdManagerAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/googleadmanager-adapter/AppLovinMediationGoogleAdManagerAdapter-13.1.0.1.zip",
            checksum: "7dcbf6c32641447b03cc5db2f1a09572f9d62fe51000e2bcd42348c4a5faede3"
        ),

        // ✅ Google AdMob — GoogleMobileAds declared in dependencies
        .target(
            name: "AppLovinMediationGoogleAdapter",
            dependencies: [
                .target(name: "AppLovinMediationGoogleAdapterBinary"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/AppLovinMediationGoogleAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationGoogleAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/google-adapter/AppLovinMediationGoogleAdapter-13.1.0.1.zip",
            checksum: "d30671bd7395b7b521d39751154f8cf3f883e7e6df523121a03169f415bb43a7"
        ),

        // ⚠️ InMobi — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationInMobiAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/inmobi-adapter/AppLovinMediationInMobiAdapter-11.1.1.0.zip",
            checksum: "0623531b55693e69d1c0e6e6384a8adb65feec3fb5d42f42b514b8994a1f47af"
        ),

        // ⚠️ IronSource/LevelPlay — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationIronSourceAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/ironsource-adapter/AppLovinMediationIronSourceAdapter-9.3.0.0.0.zip",
            checksum: "5a8f8b1e1ab7e23fb205cf4c52d66cba2e2f84a17e4e8d53ee53835ffa961cdb"
        ),

        // ⚠️ Line/FiveAd — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationLineAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/line-adapter/AppLovinMediationLineAdapter-3.0.1.0.zip",
            checksum: "b99a00e52778bd73ad483f6e9a36ab013c82582a6ec190aec03b39883a33fe00"
        ),

        // ✅ Mintegral — MintegralAdSDK declared in dependencies
        .target(
            name: "AppLovinMediationMintegralAdapter",
            dependencies: [
                .target(name: "AppLovinMediationMintegralAdapterBinary"),
                .product(name: "MintegralAdSDK", package: "MintegralAdSDK-Swift-Package"),
            ],
            path: "Sources/AppLovinMediationMintegralAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationMintegralAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/mintegral-adapter/AppLovinMediationMintegralAdapter-8.0.7.0.0.zip",
            checksum: "cae4259573ece2c9bfa58c82f030216d3cea70252da8376fdb18b118b144613d"
        ),

        // ⚠️ MobileFuse — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationMobileFuseAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/mobilefuse-adapter/AppLovinMediationMobileFuseAdapter-1.10.0.0.zip",
            checksum: "bad3c69ab378cced6b39249099d3fd9953277700999381de56e61cc6ec97299f"
        ),

        // ⚠️ Moloco — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationMolocoAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/moloco-adapter/AppLovinMediationMolocoAdapter-4.4.0.0.zip",
            checksum: "eb8b29f5460836c60a22afe4b59d3fb8dd3fd56c83f16161ea59f757b1f3b4c9"
        ),

        // ✅ myTarget — MyTargetSDK declared in dependencies
        .target(
            name: "AppLovinMediationMyTargetAdapter",
            dependencies: [
                .target(name: "AppLovinMediationMyTargetAdapterBinary"),
                .product(name: "MyTargetSDK", package: "mytarget-ios-spm"),
            ],
            path: "Sources/AppLovinMediationMyTargetAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationMyTargetAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/mytarget-adapter/AppLovinMediationMyTargetAdapter-5.40.0.0.zip",
            checksum: "0ba31608a222d23e50923e3f46a71b3060854b3500c9d9ab403f15b1a9b92cf6"
        ),

        // ⚠️ Ogury — no accessible SPM package
        .binaryTarget(
            name: "AppLovinMediationOguryPresageAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/ogurypresage-adapter/AppLovinMediationOguryPresageAdapter-5.2.0.0.zip",
            checksum: "13dc5ad88f83a5c84110e67796da3b682a835aecd600ca5d2976316addd54d5a"
        ),

        // ⚠️ PubMatic/OpenWrap — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationPubMaticAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/pubmatic-adapter/AppLovinMediationPubMaticAdapter-4.12.0.0.zip",
            checksum: "9bcb9c5f17cf2363c9dad37983d262ffdc86f9b75485bf9ebafb4bf9c2086ac8"
        ),

        // ⚠️ Smaato — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationSmaatoAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/smaato-adapter/AppLovinMediationSmaatoAdapter-22.9.3.1.zip",
            checksum: "27651e4751c23d70c8f1e3a16e06e19d1bd249e3809e94dc38d8f98802e76e1e"
        ),

        // ⚠️ UnityAds — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationUnityAdsAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/unityads-adapter/AppLovinMediationUnityAdsAdapter-4.16.6.0.zip",
            checksum: "23b507d047e8a254b82552bebc335e5902f8508c21a659b6e36aa5d3f3f9d775"
        ),

        // ⚠️ Verve/HyBid — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationVerveAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/verve-adapter/AppLovinMediationVerveAdapter-3.7.1.0.zip",
            checksum: "56cf5945bc531bbcfe33122f025d3ee931c8cbddfda4757024688e331bd4b18d"
        ),

        // ✅ Vungle/Liftoff — VungleAdsSDK declared in dependencies
        .target(
            name: "AppLovinMediationVungleAdapter",
            dependencies: [
                .target(name: "AppLovinMediationVungleAdapterBinary"),
                .product(name: "VungleAdsSDK", package: "VungleAdsSDK-SwiftPackageManager"),
            ],
            path: "Sources/AppLovinMediationVungleAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationVungleAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/vungle-adapter/AppLovinMediationVungleAdapter-7.7.1.0.zip",
            checksum: "b7679e24e09c68e8f86f74448bc9dbff49861c4aa0b294d754343198dc9f2b4b"
        ),

        // ⚠️ YSONetwork — no official SPM package
        .binaryTarget(
            name: "AppLovinMediationYSONetworkAdapter",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/ysonetwork-adapter/AppLovinMediationYSONetworkAdapter-1.1.31.1.zip",
            checksum: "4b37cb6c09ccdf959e0a09bb53a0cda10f06b397a7007f943bcdc4827288542e"
        ),

        // ✅ Yandex — YandexMobileAds declared in dependencies
        .target(
            name: "AppLovinMediationYandexAdapter",
            dependencies: [
                .target(name: "AppLovinMediationYandexAdapterBinary"),
                .product(name: "YandexMobileAds", package: "yandex-ads-sdk-ios"),
            ],
            path: "Sources/AppLovinMediationYandexAdapter"
        ),
        .binaryTarget(
            name: "AppLovinMediationYandexAdapterBinary",
            url: "https://artifacts.applovin.com/ios/com/applovin/mediation/yandex-adapter/AppLovinMediationYandexAdapter-7.18.4.0.zip",
            checksum: "6e3c6ad90bab524d124a779d97a824e1acaafae64bbfa8b12807bc5082367445"
        ),

    ]
)
