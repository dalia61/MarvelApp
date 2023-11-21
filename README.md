# Marvel iOS App

Welcome to the Marvel iOS application! This app is tailored to streamline your exploration of Marvel's cinematic universe. With a user-friendly single-screen interface, it simplifies the process of discovering and diving into the extensive collection of Marvel movies.

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
* Search Functionality: Easily search for specific Series.
* Movie Details: Dive into expanded details for each series.

## Used In The APP

- SWIFT
- MVVM Architecture Pattern
- Observable
- Coordinator Pattern For Handling Navigation
- UseCase Layer
- Network Layer (Alamofire)
- XIB Files
- Figma For Designing The UI

## Screenshots

Here are some screenshots from the app:

- **Launch Screen**
  
- **Marvel List**


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
