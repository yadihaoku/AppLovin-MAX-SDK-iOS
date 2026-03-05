// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppLovinSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "AppLovinSDK",                              targets: ["AppLovinSDKResources"]),
        .library(name: "AppLovinMediationGoogleAdapter",           targets: ["AppLovinMediationGoogleAdapter"]),
        .library(name: "AppLovinMediationGoogleAdManagerAdapter",  targets: ["AppLovinMediationGoogleAdManagerAdapter"]),
        .library(name: "AppLovinMediationFacebookAdapter",         targets: ["AppLovinMediationFacebookAdapter"]),
        .library(name: "AppLovinMediationVungleAdapter",           targets: ["AppLovinMediationVungleAdapter"]),
        .library(name: "AppLovinMediationMintegralAdapter",        targets: ["AppLovinMediationMintegralAdapter"]),
        .library(name: "AppLovinMediationInMobiAdapter",           targets: ["AppLovinMediationInMobiAdapter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", from: "13.0.0"),
        .package(url: "https://github.com/facebook/FBAudienceNetwork.git",                        from: "6.21.1"),
        .package(url: "https://github.com/Vungle/VungleAdsSDK-SwiftPackageManager.git",           from: "7.7.1"),
        .package(url: "https://github.com/Mintegral-official/MintegralAdSDK-Swift-Package.git",   from: "7.0.0"),
    ],
    targets: [

        // MARK: - AppLovin MAX SDK
        .target(
            name: "AppLovinSDKResources",
            dependencies: [.target(name: "AppLovinSDK")],
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

        // MARK: - Source-based Adapters (Sources/<Network>/)

        .target(
            name: "AppLovinMediationGoogleAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/Google/GoogleAdapter",
            publicHeadersPath: "."
        ),

        .target(
            name: "AppLovinMediationGoogleAdManagerAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/GoogleAdManager/GoogleAdManagerAdapter",
            publicHeadersPath: "."
        ),

        .target(
            name: "AppLovinMediationFacebookAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .product(name: "FBAudienceNetwork", package: "FBAudienceNetwork"),
            ],
            path: "Sources/Facebook/FacebookAdapter",
            publicHeadersPath: "."
        ),

        .target(
            name: "AppLovinMediationVungleAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .product(name: "VungleAdsSDK", package: "VungleAdsSDK-SwiftPackageManager"),
            ],
            path: "Sources/Vungle/VungleAdapter",
            publicHeadersPath: "."
        ),

        .target(
            name: "AppLovinMediationMintegralAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .product(name: "MintegralAdSDK", package: "MintegralAdSDK-Swift-Package"),
            ],
            path: "Sources/Mintegral/MintegralAdapter",
            publicHeadersPath: "."
        ),

        .target(
            name: "AppLovinMediationInMobiAdapter",
            dependencies: [
                .target(name: "AppLovinSDK"),
                .target(name: "InMobiSDK"),
            ],
            path: "Sources/InMobi/InMobiAdapter",
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("WebKit"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        .binaryTarget(
            name: "InMobiSDK",
            url: "https://dl.inmobi.com/inmobi-sdk/IM/InMobi-iOS-SDK-11.1.1.zip",
            checksum: "578dd32285cc8cea05e04ef3ffd03ccf0c93bc010d1e3abbed28690fe0dfffb2"
        ),

    ]
)
