# Hivemind

Hivemind is a geospatial Rails application where users—represented as bees—can register, log in, and store the location of their hive. Users can visualize their hive on a map and interact with the environment by clicking on different locations to see how far they are from home and how long it would take to fly back in bee flight time.

## Features
- **User Authentication & Authorization**: Secure sign-up, login, logout, and password reset.
- **Hive Location Tracking**: Users can set their hive's geospatial coordinates via an interactive map.
- **Distance & Flight Time Calculation**: Clicking anywhere on the map displays the distance from the hive and an estimated return time based on bee flight speed.
- **Minimalist UI**: Built with ViewComponents, Slim, and a black-and-white minimalist map theme.

---

## Getting Started

### Prerequisites
Ensure you have the following installed:
- **Ruby** (>= 3.0)
- **Rails** (>= 8.0)
- **PostgreSQL** (with PostGIS extension enabled)
- **Node.js & Yarn** (for frontend dependencies)

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/hivemind.git
   cd hivemind
   ```

2. **Install dependencies:**
   ```sh
   bundle install
   yarn install
   ```

3. **Set up the database:**
   ```sh
   rails db:create
   rails db:migrate
   rails db:seed # (optional, if you add seed data)
   ```

4. **Start the Rails server:**
   ```sh
   rails server
   ```

5. **Visit the app in your browser:**
   ```
   http://localhost:3000
   ```

### Running system tests
By default, system tests run in headless mode (without opening a browser). 

**Headless Mode (Default):**
Run tests without opening a browser:

```
bundle exec rspec
```

**Visible Browser Mode:**
To run tests with a visible browser, set the `SHOW_BROWSER` environment variable to `true`:

```
SHOW_BROWSER=true bundle exec rspec
```

This setup applies to all (and only to) system tests, especially those using `js: true` for JavaScript-enabled features.

---

## Technical Details
- **Backend**: Ruby on Rails with PostgreSQL and PostGIS for geospatial data.
- **Frontend**: ViewComponents and Slim templates for UI.
- **Styling**: SASS for custom styles.
- **Maps**: Leaflet.js for rendering maps and user interactions.
- **JavaScript**: Hotwire Stimulus for dynamic updates.

---

## Usage
1. **Register or log in** to create a bee account.
2. **Set your hive location** by clicking on the map.
3. **Explore the environment**: Click on different locations to check distance and flight time.

---

## Future Enhancements
- **Flower Patch Crowdsourcing**: Users can mark and share flower-rich locations.
- **Bee Movement Visualization**: Animating bee travel between points.
- **Leaderboard**: Displaying top foraging bees with the most discovered flower patches.

---

## License
This project is licensed under the MIT License.

---

## Contact
For questions or contributions, open an issue on GitHub.

