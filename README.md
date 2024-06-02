# weather-app

## Overview

Weather-APP is an iOS application built using SwiftUI, targeting iOS 17 or later. It utilizes SWiftUI, structured concurrency, and SPM for modularization. The app is structured with a focus on separation of concerns following MVVM, making it easy to maintain and extend. 

## Project Structure

The project is divided into several main modules:
* Design: Contains reusable UI components, extensions, and view modifiers
* Domain: Handles the business logic, including models, network calls, and repositories.
* weather-app: The main app module, including assets, view models, views, and application configuration files.

## Nice to have
- Implement a way to secure the API key: currently it's impossible to secure since it's part of the openWeather URL it self!
- Implement a Splash screen and App State to control the flows: currently there is only one flow so it was not needed.
- Dependency injection: due to the size of the app, I chose to use mockdata of the Models for DEBUG mode. But it is possible to have MockRepositories to inject in the V/VM for testing different scenarios  

## Getting Started
### Prerequisites

    Xcode 15 or later
    Swift 5.7 or later
    iOS 17 or later

### Usage

After installing and running the app, you can interact with the user interface to view weather information for different locations; currently it only supports temprature data. The app supports both light and dark modes and convertions between imperial and metric units.

## Contributing

Contributions are welcome! Please follow these steps:

1. Create a new branch
2. Make your changes and commit them
3. Push to the branch:
4. Open a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any questions or suggestions, please contact jeanpaull@live.it