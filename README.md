# 📱 SwiftUI Student Survey Form

A clean, modern, and native iOS Student-Survey form built using SwiftUI. This project demonstrates best practices in form layout architecture, real-time inline input validation using Regular Expressions (Regex), and dynamic UI state manipulation.

---

## 🎨 UI Architecture & SwiftUI Kit

The interface leverages a clean, native setup driving the main survey view:

* **`NavigationStack`** – Establishes a solid, scalable structural navigation hierarchy.
* **`Form` & `Section`** – Groups student data and parent/guardian contact information into native, clean, and scannable layouts.
* **`ZStack` & `VStack`** – Layers elements precisely to handle text input fields alongside real-time, inline error warnings.
* **`Toolbar` Placements** – Implements clear action boundaries for the **Submit** and **Clear All** buttons.
* **`LinearGradient` Backgrounds** – Breaks away from standard gray forms to make the overall application design pop visually.

---

## 🧠 Core Logic & Validation Architecture

### 🔍 Regex-Powered Input Validation
To enforce real-world data integrity rules before submission, the app leverages regular expressions via `NSPredicate`:
* **Contact Numbers:** Matches strict 10-digit phone patterns natively starting with digits `6–9`.
* **Email Constraints:** Enforces proper corporate/academic lowercase formatting rules.

### 🎛️ State-Driven UI States
The form's submission state is completely reactive:
* Bound entirely to a single computed property (`isFormValid`).
* Automatically evaluates text criteria to conditionally enable, highlight, or fade out the interactive submit buttons in real-time.

---

## 🛠️ Requirements & Tech Stack
* **iOS** 17.0+
* **Xcode** 15.0+
* **Swift** 5.9+
* **Framework:** SwiftUI
