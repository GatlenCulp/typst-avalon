/*
 * Avalon Role Cards - Example Usage
 *
 * This file demonstrates how to generate individual role cards, one per page.
 * Each card features:
 * - Custom or default gradient background
 * - Team seal in top right (Good/Evil indicator)
 * - Role name as main title
 * - Optional player name as subtitle
 *
 * Cards are designed to be printed and cut, with backs that are identical
 * so players cannot identify cards by their backs.
 */

#import "../sheet.typ": avalon-card, card-page

// Role definitions with their properties
#let roles = (
  // Good Team
  "Merlin": (
    team: "Good",
  ),
  "Percival": (
    team: "Good",
  ),
  "Loyal Servant": (
    team: "Good",
  ),
  // Evil Team
  "Assassin": (
    team: "Evil",
  ),
  "Morgana": (
    team: "Evil",
  ),
  "Mordred": (
    team: "Evil",
  ),
  "Oberon": (
    team: "Evil",
  ),
  "Minion of Mordred": (
    team: "Evil",
  ),
)

// Configuration - Update these paths and settings as needed
#let config = (
  // Seal images (optional - leave as none for no seals)
  good-seal: none, // e.g., "assets/good-seal.png"
  evil-seal: none, // e.g., "assets/evil-seal.png"
  // Background images per role (optional - leave as none for default gradient)
  backgrounds: (:), // e.g., ("Merlin": "assets/merlin-bg.png", ...)
  // Player names (optional - leave as "" for no player names)
  players: (:), // e.g., ("Merlin": "Alice", "Assassin": "Bob", ...)
)

// Generate cards - one card per page
#card-page()

// Example: Generate all roles
// Uncomment and customize the roles you want to generate:

/*
#let role = roles.at("Merlin")
#avalon-card(
  "Merlin",
  role.team,
  player-name: config.players.at("Merlin", default: ""),
  background-image: config.backgrounds.at("Merlin", default: none),
  good-seal: config.good-seal,
  evil-seal: config.evil-seal,
)

#pagebreak()

#let role = roles.at("Percival")
#avalon-card(
  "Percival",
  role.team,
  player-name: config.players.at("Percival", default: ""),
  background-image: config.backgrounds.at("Percival", default: none),
  good-seal: config.good-seal,
  evil-seal: config.evil-seal,
)

// ... and so on for other roles
*/

// Or use a loop to generate all roles automatically:
#for (role-name, role) in roles [
  #avalon-card(
    role-name,
    role.team,
    player-name: config.players.at(role-name, default: ""),
    background-image: config.backgrounds.at(role-name, default: none),
    good-seal: config.good-seal,
    evil-seal: config.evil-seal,
  )
  #pagebreak()
]

