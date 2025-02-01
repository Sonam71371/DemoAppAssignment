# DemoAppAssignment

## Overview

DemoAppAssignment is a sample application built using The Composable Architecture (TCA) framework. This project showcases various elements of TCA, including state management, side-effect handling, and modular architecture. The application interacts with a public API to fetch and display data, demonstrating the integration of network requests and user actions within a SwiftUI-based interface.

## Features

- **State Management**: Utilizing TCA's state management capabilities to handle application state.
- **Network Requests**: Fetching data from a public API (e.g., **Spotify Artist API**) and displaying the results.
- **Modular Architecture**: Structuring the application into distinct, reusable modules.
- **SwiftUI Integration**: Building a responsive and interactive user interface using **SwiftUI**.
- **Error Handling**: Managing errors and providing feedback to the user.

## Requirements

- **Xcode 12.0** or later  
- **Swift 5.3** or later  
- **iOS 14.0** or later  

## Installation

### Clone the repository:
```git clone https://github.com/Sonam71371/DemoAppAssignment.git```

### Navigate to the project directory:
```cd DemoAppAssignment```

### Open the project in Xcode:
```open DemoAppAssignment.xcodeproj```

Build and run the project in Xcode.

## Usage

- Launch the application on a simulator or a physical device.
- Enter a search query in the search bar to fetch data from the Sportify API.
- View the search results displayed in a list format.
- Tap on a list item to view more details (if implemented).

## Project Structure

- Model: Defines the data structures used in the application.
- Feature: Contains the core logic and reducers following TCA principles.
- Views: Defines the SwiftUI views and UI components.
- App: The main entry point of the application.
- API Client: Manages network requests and API interactions.

