# App-Challenge

## 🧱 Architecture

This project follows the **Model-View-ViewModel (MVVM)** architecture:

- **Model** → Represents the data and business logic of the application.  
- **View** → Handles the UI, focusing only on presentation and user interaction.  
- **ViewModel** → Acts as the bridge between the Model and the View.  
  It exposes the data in a way the View can easily consume, and it manages the interaction logic without being tied to UI components.  

> 💡 This separation promotes better **testability**, **scalability**, and **maintainability** by reducing the responsibilities of the View and keeping business logic out of UI code.

