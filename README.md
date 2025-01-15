# Shadow of the Demon Lord Initiative Tracker

## Overview
The **Shadow of the Demon Lord Initiative Tracker** is a web application designed to help Dungeon Masters (DMs) and players manage initiative order in their campaigns. It organizes characters, tracks their health and actions, and simplifies combat management for a smoother tabletop experience.

---

## Features

### Initiative Management
- Sorts characters into **Fast** and **Slow** turns, grouped by allies and enemies.
- Allows toggling between Fast and Slow turns for any character.
- Tracks whether a character has acted during the round.

### Health Management
- Add or remove hit points (HP) and bonus HP for each character.
- Supports applying **damage** or **healing** via positive or negative input.
- Automatically updates character status to `injured` or `incapacitated` based on damage thresholds.

### UI Enhancements
- **Color-coded character cards**:
  - Light red for `injured`.
  - Dark red with white text for `incapacitated`.
- Responsive design for easy use on various devices.

---

## Installation

### Prerequisites
Ensure the following are installed on your system:
- Ruby 3.3.5
- Rails 7.1.5
- PostgreSQL (for production environment) or SQLite3 (for development/testing)

### Setup Instructions
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd sotdl_initiative_tracker
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:setup
   ```

4. Start the Rails server:
   ```bash
   rails server
   ```

5. Open the application in your browser at `http://localhost:3000`.

---

## Usage

### Adding Characters
1. Enter the character's **Name** and **HP**.
2. Select whether they are an **Ally** or **Enemy**.
3. Choose their initial turn speed: **Fast** or **Slow**.
4. Click **Add Character**.

### Managing Characters
- Use the **Apply Damage** field to inflict or heal damage (negative values heal).
- Adjust **Bonus HP** with positive or negative values.
- Mark a character's turn as complete or undo the action with the **Mark Action Complete** button.
- Toggle between **Fast** and **Slow** turns.
- Remove characters from the tracker with the **Remove** button.

### Resetting the Round
Click the **Reset Round** button to clear all actions and start a new initiative round.

---

## Development

### File Structure
- **Models**: Handles character logic (e.g., health calculations).
- **Controllers**: Manages character creation, updates, and destruction.
- **Views**: Renders the UI with partials and Turbo Streams for dynamic updates.
- **Stylesheets**: Defines custom styles, including responsive character cards.

### Key Files
- `app/models/character.rb`: Business logic for health and initiative.
- `app/controllers/characters_controller.rb`: Core controller for character interactions.
- `app/views/characters/index.html.erb`: Main interface.
- `app/assets/stylesheets/application.scss`: Styles for the UI.

---

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature description"
   ```
4. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Acknowledgments
- Inspired by the mechanics of **Shadow of the Demon Lord** by Schwalb Entertainment.
- Thanks to contributors and the Rails community for their support.

