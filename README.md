# Clean Swift and SwiftUI Integration

This repository demonstrates the integration of Clean Swift (VIP) architecture with SwiftUI for building a UIKit-based project with SwiftUI-based views. By combining the power of Clean Swift's separation of concerns and SwiftUI's declarative UI framework, we aim to create a well-organized, scalable, and maintainable iOS application.

## Introduction

Clean Swift (VIP) is an architectural pattern that promotes separation of concerns, making the codebase easier to understand, test, and maintain. SwiftUI is Apple's modern UI framework that enables building user interfaces using a declarative syntax.

This project explores how to leverage the advantages of Clean Swift and SwiftUI together, allowing us to develop the user interface using SwiftUI while keeping the existing UIKit-based infrastructure for the rest of the application.

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository to your local machine:

```bash
git clone https://github.com/toonTheta/vip-swiftui.git
```

2. Open the Xcode project in the cloned repository.

3. Build and run the project using Xcode.

## Architecture Overview

The project follows the Clean Swift (VIP) architectural pattern for the UIKit-based components (e.g., Interactors, Presenters, and View Controllers). However, the View Controllers are designed to present SwiftUI Views instead of traditional UIKit views.

<img src="assets/VIP_diagram_dark.png#gh-dark-mode-only" width="100%" alt="VIP_SwiftUI_Diagram" />
<img src="assets/VIP_diagram_light.png#gh-light-mode-only" width="100%" alt="VIP_SwiftUI_Diagram" />

### Clean Swift (VIP)

Clean Swift architecture consists of the following components:

1. **ViewController:** Represents the UIKit-based user interface component. In this project, it will solely be responsible for displaying SwiftUI views.

2. **Interactor:** Acts as the middleman between the ViewController and the Business Logic. It contains the business logic and handles data processing and manipulation.

3. **Presenter:** Formats the data from the Interactor into a presentable format for the SwiftUI Main View. It separates the data formatting from the business logic.

4. **Router:** Handles navigation and routing logic for the scene.

### SwiftUI

SwiftUI Views are designed using SwiftUI's declarative syntax, which allows us to define the user interface and its behavior in a straightforward and efficient manner. SwiftUI views can be used within the ViewController, providing a seamless integration between UIKit and SwiftUI.

## Integration
Here's how we can seamlessly incorporate SwiftUI into the Clean Swift (VIP) architecture UIKit based:

1. Begin by setting up a standard VIP scene structure.

2. Craft the central UI component as a SwiftUI View and append "MainView" to its name.

3. Establish a `SceneViewModel` that conforms to the `ObservableObject` protocol.

4. Develop the scene's view controller to host the `SceneViewModel` and present the `SceneMainView`.

5. Utilize the `SceneViewModel` as the authoritative source of UI data, facilitating data binding with the `SceneMainView`.

6. When a scenario arises where the view controller needs to listen to the event in the `SceneMainView` – such as interactions like button taps – declare a delegate mechanism for the communication.

## Project Data Model
### HealthRecord
| Field        | Type     |
|--------------|----------|
| value        | Double   |
| type         | String   |
| createdDate  | Date     |
| id           | UUID     |

## Contributing

We welcome contributions to improve this project. If you find any issues or have suggestions for enhancements, feel free to open an issue or create a pull request.

Before contributing, please read our [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

We would like to acknowledge the creators and maintainers of Clean Swift and SwiftUI, as well as the iOS developer community for their valuable contributions.

---

Feel free to modify the above template as needed for your specific implementation. It gives a brief overview of the project, the integration approach, and the architecture. Add more sections if necessary, such as Dependencies, Features, Testing, etc., depending on your project's complexity and requirements.
