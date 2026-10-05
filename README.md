# QR Lens - Community

[![CI](https://github.com/omerdotdev/qrlens-community/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/omerdotdev/qrlens-community/actions/workflows/ci.yml)
[![Android](https://github.com/omerdotdev/qrlens-community/actions/workflows/android.yml/badge.svg?branch=main)](https://github.com/omerdotdev/qrlens-community/actions/workflows/android.yml)
[![iOS](https://github.com/omerdotdev/qrlens-community/actions/workflows/ios.yml/badge.svg?branch=main)](https://github.com/omerdotdev/qrlens-community/actions/workflows/ios.yml)
[![Web](https://github.com/omerdotdev/qrlens-community/actions/workflows/web.yml/badge.svg?branch=main)](https://github.com/omerdotdev/qrlens-community/actions/workflows/web.yml)
[![Deploy web to GitHub Pages](https://github.com/omerdotdev/qrlens-community/actions/workflows/pages.yml/badge.svg?branch=main)](https://github.com/omerdotdev/qrlens-community/actions/workflows/pages.yml)

This project is inspired by the [offline-qr-code](https://github.com/rugk/offline-qr-code) addon for firefox. Learning flutter was an extremmely rewarding experience and I used this learning experience to build something for the community. Please do write your feedback in discussion tab. 

## Try it on the web

The web version is deployed here: **[omerdotdev.github.io/qrlens-community](https://omerdotdev.github.io/qrlens-community/)**

It is built from `main` and deployed automatically to GitHub Pages. Camera access needs HTTPS, which GitHub Pages provides.

## Build status

| Workflow | What it checks |
|---|---|
| CI | formatting, static analysis and unit tests |
| Android | release APK build |
| iOS | iOS build (no code signing) |
| Web | web release build |
| Deploy web to GitHub Pages | builds and publishes the web version |

Badges above show the latest run on `main` (green = passed, red = failed). Day-to-day work happens on the `dev` branch; the iOS build runs on pull requests into `main`.

## Features

* Scan
* Copy
* Open (If it is a link)
* Type of code (qr, barcode)
* Dark Mode (Auto)

## Dependencies:

- [x] [bloc](https://pub.dev/packages/bloc)  
- [x] [flutter_bloc](https://pub.dev/packages/flutter_bloc)  
- [x] [mobile_scanner](https://pub.dev/packages/mobile_scanner)  
- [x] [url_launcher](https://pub.dev/packages/url_launcher)  
- [x] [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)  


## [Mobile Scanner](https://github.com/juliansteenbakker/mobile_scanner)
📣 Shout out to [Julian Steenbakker](https://github.com/juliansteenbakker) for `mobile_scanner`, and to [juliuscanute](https://github.com/juliuscanute) for the original [qr_code_scanner](https://github.com/juliuscanute/qr_code_scanner) this app was first built on.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [flinks](https://github.com/omerdotdev/flinks)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Support

Please write your feedback and review. I would be happy to read and respond.  

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/omerdotdev)

# Screenshots
|    -    |    -    
|---    |---
|    ![image](https://user-images.githubusercontent.com/82511895/142889264-35a15c6d-b8d4-42ae-a67b-72b37415debf.png)    |   ![image](https://user-images.githubusercontent.com/82511895/142889294-62697360-f051-4ee0-98ad-41b4042c5fbc.png)

![image](https://user-images.githubusercontent.com/82511895/142920740-02ceb409-962d-4fa4-b2f9-d88a597a6da1.png)

