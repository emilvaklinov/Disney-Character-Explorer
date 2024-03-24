# Disney Character Explorer App
## Overview
The Disney Character Explorer App is an engaging iOS application that allows users to explore a variety of Disney characters, fetched from the Disney API(https://api.disneyapi.dev/character). It offers a clean, user-friendly interface for browsing character details and managing favorites.

## Features
- Character Listing: Browse characters with filters for movies, TV shows, video games, and park attractions. Search bar and listing of all characters.
- Character Details: Access detailed information about each character, including participation in films, shows, and games. Button for adding to favourites and for Wiki web displaying of the character.
- Favorites Management: Mark characters as favourites for quick access, viewed in a horizontal scroll on the list view.

## Design
- Architecture: Utilizes a modular MVVM pattern.
- UI Design: Developed with SwiftUI, allowing for a declarative and efficient approach to building user interfaces.
- SwiftUI & Combine: Leveraged for a modern and reactive UI with efficient handling of asynchronous operations.

## Technology Stack
- Swift: Version 5.5
- iOS Deployment Target: iOS 16+
- Networking: Native URLSession for API calls
- Data Persistence: UserDefaults for storing user preferences and favourites
- Testing: XCTest for unit testing
- Dependencies: Exclusively Apple's native frameworks

## Implementation
- SwiftUI over UIKit: For its modern approach and efficiency in UI building.
- Swift Concurrency: For handling asynchronous code cleanly.
- UserDefaults: For simplicity in storing small amounts of data.
- No Third-Party Libraries: To showcase native iOS capabilities.
- MVVM Pattern: For enhanced testability and separation of concerns.

## Completed Work
- UI for character listing and detail views.
- Networking implementation with Disney API.
- Functionalities for managing favourite characters.
- Basic ui, unit tests for view models, coordinators and networking with 90% coverage.

## Areas for Improvement
- UI/UX Design: Enhancements for a more engaging experience.
- Pagination & Lazy Loading: For efficient data handling.
- Offline Support: Implement data caching.
- Core Data: For robust data persistence.
- Advanced User Interactions: Incorporate animations and transitions.
- Extended Test Coverage: Improving the UI and adding integration tests.
- In-depth Documentation: Detailed documentation of code and architecture.

## Installation and Setup
Clone the repository and open it in Xcode. Compatible with Swift 5.5 and iOS 16. Run using an iOS Simulator or physical device.

# How do I meet the requirements:

## SOLID principles and MVVM Display Pattern:

- S: My app demonstrates the Single Responsibility Principle by segregating functionalities into distinct classes and structures (e.g., CharacterListViewModel, FavoritesManager, CharachterDetailViewModel, CharacterFiltering).
- O: Open/Closed Principle is adhered to with protocol-oriented programming, allowing for easy extension without modification.
- L: Liskov Substitution Principle can be inferred through the use of protocols like CharacterFiltering, which allows for the interchangeability of filter strategies.
- I: Interface Segregation is observable in the design, as smaller, more specific interfaces (e.g., NetworkServiceProtocol) are used.
- D: Dependency Inversion is present in the form of dependency injection in view models and services.
The app uses the MVVM pattern effectively, with a clear separation between View (CharacterListView), ViewModel (CharacterListViewModel), and Model.

## Clean Code Architecture:
The codebase demonstrates clean architecture principles with a clear separation of concerns, readable code, and a structured directory.

## Modularity:
The application's structure is modular with segregated components like networking, data persistence, view models, and views.

## SwiftUI / Combine:
- SwiftUI is used for the UI design, showcasing its declarative syntax and efficient handling of user interfaces.
- Combine is integrated for handling asynchronous operations and data binding in SwiftUI, observable in networking and view models.

## Unit Tests / UI Tests:
I have implemented unit tests for critical components like view models and filtering logic. However, the extent and depth of these tests could be expanded to cover more scenarios.
