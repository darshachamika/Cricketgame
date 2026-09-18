**Mini Cricket | Flutter Mobile Game**

Mini Cricket is a mobile game built with **Flutter and Dart**, turning a simple six-ball cricket challenge into an interactive application. The project demonstrates core mobile development concepts through a focused gameplay experience.

Players tap **Bat** to generate a random score between **0 and 6 runs** per delivery. The scoreboard updates the total runs and remaining balls immediately. After six deliveries, the game displays the final score and offers a **Restart** option.

**Key Features**

* Six-ball overs with randomized scoring.
* Dynamic scoreboard and delivery feedback.
* Automatic end-of-over detection and game reset.
* Responsive layout with Material Design components.
* Custom-drawn bat and ball illustrations that work offline.

**Technical Implementation**

The application uses `StatefulWidget` and `setState()` to manage game state and update the interface. Reusable widgets organize the scoreboard, while `CustomPainter` renders the cricket illustrations without external image assets. Game logic prevents additional deliveries once the over is complete.

**Skills Demonstrated**

Flutter UI development, Dart programming, event handling, state management, conditional rendering, reusable components, and custom graphics.

This project applies mobile development fundamentals to a small, clearly defined game, connecting user interactions, application logic, and visual feedback.
