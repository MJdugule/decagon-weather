# Weather App

## Description
A weather application to display the current weather at the user's location
## Repo structure
This repository makes use of an MVVM pattern. 

# Running the Flutter app

1. Install and setup Flutter https://flutter.dev/docs/get-started/install
2. Clone the repo and run `git checkout dev`
3. Run `flutter pub get` from the root of the project to fetch all dependencies
4. Run `flutter run` to start the app

## File structure

The app is generally split up into three layers:

1. Presentation - Flutter widgets
2. Data
3. Domain

Presentation: Shows the UI to the user. Single widgets also qualify as views (for consistency in terminology) a view, in this case, is not a "Page" it's just a UI representation.

Domain: Manages the state of the View, business logic, and any other logic as required from user interaction. It does this by making use of the services

Data: A wrapper of a single functionality/feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an API, etc.

Before continuing I'd recommend reading the official docs on state management as the concepts and packages used are very similar to the ones used in this app. https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro

## Style Guide

### Color 
You can go throught the `colors.dart` file to see the kind of color you need.

### Text Style
You can go throught the `text_styles.dart` file to see the kind of text styles you need.

## Commits Guidlines
 All PRs must be according to the recommended naming convention. (https://www.conventionalcommits.org/en/v1.0.0/)

## Appetitize link
https://appetize.io/app/jtuotdpxb2daeunwpysgrktxfy?device=pixel4&osVersion=11.0&scale=75

