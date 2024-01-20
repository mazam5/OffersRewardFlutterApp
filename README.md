# Rewards Offers Flutter App

### Table of Contents

- [About](#about)
- [Methodology](#methodology)
- [Getting Started](#getting_started)
  - [Prerequisites](#prerequisites)
  - [Installing](#installing)
- [Screenshots](#screenshots)
- [Built Using](#built_using)
- [Authors](#authors)

## About

A Flutter app that displays offers to get rewards by completing tasks.

i.e. Install an App and get Rs.50, Sign up an App and get Rs.100, etc.

## Methodology

The app is built using Flutter and Dart. The app uses JSON files data to display offers. i.e. dummy_tasks.json and dummy_details.json.

#### Home Screen

1. The app initially read the JSON files and parse the data into models.
2. The home screen uses AppBar with blue color and it shows wallet ballance and username.
3. Another widget is used to display Appbar in white color with Multiple Tabs. The tabs are used to display different categories of offers.
4. A Text widget is used to animate and show when some users get reward.
5. The app display the json data stored in a data1 and display it horizontally in a list.
6. When the user taps on the image of the list item, the app navigates to the details screen.
7. data1 stored data display it vertically in a list with variant card color used from the json data.
8. When the user taps on the "Get" button, the app navigates to the details screen

#### Offers Details Screen

1. The data is read from the dummy_tasks.json file and parsed into model. The models are then used to display the Title, Description, Image, and rating of the offer
2. The data is read from the dummy_details.json file and parsed into model. The models are then used to display the steps of the offer to get reward.
3. The parsed data stored in data1 and data2 List to populate on the screen.
4. The app then displays the steps to get reward in vertical lists.
5. Also the app displays the details of the offer when the user taps on the vertical list when user clicks on the "Get" button.

## Getting Started

#### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)
  or [VS Code](https://code.visualstudio.com/)
  or [Xcode](https://developer.apple.com/xcode/) - IDE
- [Git](https://git-scm.com/downloads)

#### Installing

1. Clone the repo

```
git clone
```

2. Install dependencies

```
flutter pub get
```

3. Run the app

```
flutter run
```

## Screenshots

<table align="center">
  <tr>
    <td><img src="/screenshots/1.png" width=270 height=480 alt="screenshot"></td>
    <td><img src="/screenshots/2.png" width=270 height=480 alt="screenshot"></td>
    <td><img src="/screenshots/3.png" width=270 height=480 alt="screenshot"></td>
  </tr>
  <tr>
    <th>Screenshot 1</th>
    <th>Screenshot 2</th>
    <th>Screenshot 3</th>
  </tr>
 </table>

## Built Using

- [Flutter](https://flutter.dev/) - Mobile UI framework

#### Packages

- [flutter_bloc](https://bloclibrary.dev/#/gettingstarted) - State management
- [google_fonts](https://pub.dev/packages/google_fonts) - Fonts
- [intl](https://pub.dev/packages/intl) - Internationalization and localization
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) - Rating bar
- [equatable](https://pub.dev/packages/equatable) - Equality comparison for Dart

## Authors <a name = "authors"></a>

- [Mohammed Azam](https://www.linkedin.com/in/azam5/)
