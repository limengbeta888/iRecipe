# iRecipe

iRecipe is an iOS app built using Swift and SwiftUI, leveraging modern iOS architecture patterns (MVI).
The app allows users to browse recipes, view recipe details, search recipes.

### Features

- Browse a list of recipes
- Scrolling with automatic loading of more recipes
- Search recipes by keyword
- View detailed information for each recipe
- Share recipes with other apps using the native iOS share sheet
- Multi-language UI support (English and Chinese; recipe content remains in a single language)

### Development Environments

- Xcode: 26.2
- Swift: 5

### Third-Party Dependencies

- Nuke (12.8.0): Asynchronous image loading and caching for images fetched from the server
- Swinject (2.10.0): Dependency injection and lifecycle management

## Code Structure

```
iRecipe/
├── iRecipe
│   ├── Core
│   │   ├── Configuration
│   │   │   └── APIConfig.swift               # API base url configuration
│   │   └── Networking
│   │       ├── Endpoint.swift                # Endpoint protocol definition
│   │       ├── NetworkClient.swift           # Generic network client
│   │       ├── NetworkError.swift            # Network error definitions
│   │       └── RecipeEndpoint.swift          # Recipe-specific endpoints
│   │
│   ├── Features
│   │   └── Recipe
│   │       ├── RecipeDetail
│   │       │   ├── Components
│   │       │   │   ├── RecipeInfoCard.swift
│   │       │   │   ├── RecipeInfoView.swift
│   │       │   │   ├── RecipeIngredientsView.swift
│   │       │   │   ├── RecipeInstructionsView.swift
│   │       │   │   └── RecipeTitleCardView.swift
│   │       │   │
│   │       │   ├── RecipeDetailEffect.swift  # Side effects (e.g. share)
│   │       │   ├── RecipeDetailIntent.swift  # User intents
│   │       │   ├── RecipeDetailReducer.swift # State reducer
│   │       │   ├── RecipeDetailState.swift   # View state
│   │       │   ├── RecipeDetailStore.swift   # MVI store
│   │       │   └── RecipeDetailView.swift    # SwiftUI view
│   │       │
│   │       └── RecipeList
│   │           ├── Components
│   │           │   └── RecipeCell.swift
│   │           │
│   │           ├── RecipeListIntent.swift  # User intents
│   │           ├── RecipeListReducer.swift # State reducer
│   │           ├── RecipeListState.swift   # View state
│   │           ├── RecipeListStore.swift   # MVI store
│   │           └── RecipeListView.swift    # SwiftUI view
│   │
│   ├── Models
│   │   └── Recipe.swift                     # Recipe domain model
│   │
│   ├── Resources
│   │   └── Localizable.xcstrings             # String Catalog (localization)
│   │
│   ├── Services
│   │   ├── MockServices
│   │   │   └── MockRecipesService.swift      # Mock API for tests / previews
│   │   └── RecipeService.swift               # Recipe API service
│   │
│   ├── Shared
│   │   └── Components
│   │       └── ShareSheet.swift              # UIKit share sheet wrapper
│   │
│   ├── Assets.xcassets                       # App images & colors
│   ├── ContentView.swift                     # App root view
│   └── iRecipeApp.swift                      # App entry point
│
├── iRecipeTests
│   ├── Helpers
│   │   └── XCTAssertHelpers.swift            # Test utilities
│   │
│   ├── MockServices
│   │   └── MockRecipesService.swift
│   │
│   ├── RecipeDetail
│   │   ├── RecipeDetailReducerTests.swift
│   │   └── RecipeDetailStoreTests.swift
│   │
│   └── RecipeList
│       ├── RecipeListReducerTests.swift
│       └── RecipeListStoreTests.swift
│
└── Frameworks
```

## Architecture Decisions & Trade-offs

- MVI pattern separates state, intents, and side effects, keeping business logic testable.
- Combine framework handles reactive state updates.
- Feature-based folder structure improves maintainability.
- SwiftUI views remain stateless, relying on stores for state.

## Future Improvements

- Offline support for previously fetched and cached recipes
- Dark mode support with system theme awareness
- iPad-optimised layouts with adaptive UI design
- Accessibility enhancements (VoiceOver, Dynamic Type, and improved contrast)
- Comprehensive UI test coverage using the XCUITest framework.
- Refactor existing unit tests from XCTest to Swift Testing (iOS 17+ only)

## AI Assistance

Tools: Claude Sonnet 4.5, ChatGPT 5.2

Usage:

- Architecture brainstorming and design discussions
- Generating initial drafts of SwiftUI components
- Code refactoring suggestions and best-practice reviews
- Proposing implementation approaches for the “Share Recipe” feature

Validation:

- All generated code was carefully reviewed and refactored before integration
- Validation logic was added to handle invalid inputs, edge cases, and failure scenarios
