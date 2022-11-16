# MAGIC APP

A new Flutter project.

## Prerequisites
-  Flutter 3.3.8
- Dart `>=2.18.0 <3.0.0`

## How to run the project

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/iampato/magic.git
```

**Step 2:**

Go to backend sub folder and run `make run` this should spin a simple `dart_frog` REST API

Then navigate into `app/` and run 

```
flutter pub get 
```

**Step 3:**

Under `lib/src/core/config.dart` you can change the API URl with your IP

**Step 4:**

Generate part files if needed

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**Step 5:**

Run the project

```
flutter run
```

### Libraries & Tools Used

1. ### Network
   
   * [Dio](https://github.com/flutterchina/dio) -  a robust http client for interacting with the REST client
2. ### State management
    * [Bloc](https://bloclibrary.dev/#/) - the app uses cubit for statement hence the needs for this package
    * [Flutter bloc](https://bloclibrary.dev/#/) - since the merge of bloc and cubit I need this to provide required widget to integrate cubit example `BlocConsumer`
    * [Hydrated bloc](https://bloclibrary.dev/#/) - For caching of bloc state in some cubits

3. ### Code generation
   * [Build runner](https://pub.dev/packages/build_runner) for code generation
   * [Freezed](https://pub.dev/packages/freezed) code generator for data-classes/unions/pattern-matching/cloning.
   * [json_serializable](https://pub.dev/packages/json_serializable) code generation for json serialization

4. ### Logging
   * [Logger](https://pub.dev/packages/logger) - for safe and beautiful logs
   
5. ### Navigation
    * [Go router](https://pub.dev/packages/go_router) - for declarative routing purposes

6. ### Responsive design
    * [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) - for Adaptive font size and screen sizes
    * [responsive_framework](https://pub.dev/packages/responsive_framework) - in combination with `screenutils` to create adaptive screens

7. ### Testing
    * [bloc test](https://bloclibrary.dev/#/)

8. ### Others
   * [shared_preferences](https://pub.dev/packages/shared_preferences) - simple storage and retrieve of key value pairs
   * [sticky_headers](https://pub.dev/packages/sticky_headers) - for placing headers on scrollable content that will stick to the top of the container whilst the content is scrolled.
   * [lottie](https://pub.dev/packages/lottie) - parsing json animation downloaded for https://lottiefiles.com
   * [google_fonts](https://pub.dev/packages/google_fonts) - in order to use Google fonts
   * [intl](https://pub.dev/packages/intl) - for date/number formatting and parsing

### Folder Structure
This application uses a multi-module architecture though the packages are not in seperate packages this can easily be done. for purposes of simplicity I under them under `lib` 

Here is the core folder structure which flutter provides.

```
app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project inside of `lib`

```
lib/
|- app/
|- core/
|- features/
```

1. The **app*** module holds app related things example the material app widget, routes etc

2. The **core*** module are common things that an app needs, and various features a can depend on this module example of things found onthe core module include:

   - assets - class that wraps assets added so instead of `assets/image/bg.png` you do `Assets.bg`
   - config - Set up your config; things like `APIURL`, sentry url etc
   - constants - constants used in your application
   - theme - the app uses a custom theme to provide theming
   - styles - includes extensions on various colors, textstyles, durations, Corners
   - extensions - 
   - And many more

3. The **Feature*** module houses all the features and in this app they include

   - Landing - landing page and decision page (Where we check whether you are login or not)
   - On-boarding - Houses all signup and login flows, http calls, cubits and widgets
   - Home - this houses the list of workout screens, profile screens, create workout, workout details screens and all the accompanying logic to support this module

## Wiki

Checkout [wiki](https://github.com/zubairehman/flutter-boilerplate-project/wiki) for more info

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
