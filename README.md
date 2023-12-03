# Marvel iOS App

Welcome to the Marvel iOS application! This app is tailored to streamline your exploration of Marvel's cinematic universe. With a user-friendly single-screen interface, it simplifies the process of discovering and diving into the extensive collection of Marvel series.

## Table of Contents
- [Getting Started](#getting-started)
- [Key Features](#key-features)
- [Used In The APP](#used-in-the-app)
- [Screenshots](#screenshots)
- [App Structure](#app-structure)
- [Authors](#authors)

## Getting Started

To set up and run the MarvelApp app, follow these steps:

1. Clone the repository:
   ```swift
   git clone https://github.com/dalia61/MarvelApp.git
   cd MarvelApp
   ```
   
2. Install CocoaPods dependencies:
   ```swift
   pod install
   ```
   
3. Open the Xcode workspace and build the app.

## Key Features

* List of Series: Explore a curated list of Marvel Series.
* infinite scroll: loads new series as the user scrolls down without any clear page separation
* Search Functionality: Easily search for specific Series.
* Movie Details: Dive into expanded details for each series.

## Used In The APP

- SWIFT
- UIKit
- MVVM Architecture Pattern
- Observer pattern
- Coordinator Pattern For Handling Navigation
- UseCase Layer
- Network Layer (Alamofire)
- XIB Files
- Figma For Designing The UI

## Screenshots

Here are some screenshots from the app:

- **Launch Screen**
  ![Simulator Screenshot - iPhone 14 Pro - 2023-11-21 at 11 20 58](https://github.com/dalia61/MarvelApp/assets/70582993/96971baf-346e-452c-96b3-1a27dbddb345)
  
- **Marvel List**
![Simulator Screenshot - iPhone 14 Pro - 2023-11-21 at 11 22 06](https://github.com/dalia61/MarvelApp/assets/70582993/f6bb1945-19a7-4209-ad6b-9ca214beb3e1)

- **Marvel Expand Cell**
  ![Simulator Screenshot - iPhone 14 Pro - 2023-11-21 at 11 22 01](https://github.com/dalia61/MarvelApp/assets/70582993/4bc01882-0814-4e3b-accc-c8377a5550d5)

- **Marvel Search Result**
  ![Simulator Screenshot - iPhone 14 Pro - 2023-11-21 at 11 22 19](https://github.com/dalia61/MarvelApp/assets/70582993/434058ab-dcb9-4e3c-87eb-2444ae60f76c)


  
## App Structure

The app follows a modular structure, divided into different components:

- **MarvelApp**
  
* MarvelApp
   * MarvelFoundation
      * Configuration
      * Core
      * Extensions
        * UI
        * Observable
      * Externals
        * Coordinator
        * DataNetwork
      * Resources
* Modules
   * MarvelList
      * Coordinator
      * Network
      * UseCase
      * Model
      * View
      * ViewModel
      
## Authors

Created by:
- Dalia Hamada
  * [LinkedIn](https://www.linkedin.com/in/daliahamada/)

Don't hesitate to reach out if you have any questions or need further clarification about the project.
