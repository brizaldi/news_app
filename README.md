![News App](https://github.com/brizaldi/news_app/blob/master/screenshots/gallery.png)

# News App

News App build using Flutter and https://newsapi.org

## Download

Download the APK for Android [here](https://github.com/brizaldi/news_app/releases/).

## Installation

- Add [Flutter](https://flutter.dev/docs/get-started/install 'Flutter') to your machine
- Open this project folder with Terminal/CMD and run `flutter packages get`
- Run in the Terminal
  `flutter packages pub run build_runner build --delete-conflicting-outputs`

## Running the App

- Open Android Emulator or iOS Simulator
- Run `flutter run --flavor {RELEASE_TYPE}`
- Supported release type: `DEVELOPMENT`, `STAGING`, and `PRODUCTION`

## Build an APK

- Run `flutter build apk --flavor {RELEASE_TYPE}`
- The apk will be saved under this location:
  `[project]/build/app/outputs/flutter-apk/`

For more information, check out the [official documentation](https://flutter.dev/docs 'documentation')