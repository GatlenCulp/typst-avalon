/*
* TODO: Develop medium sized role cards. There are multiple role cards (merlin, minion, percival, etc.). The back sides use all the same image so others can't tell what the others have.
- Import an image to use as the background
- At the bottom there should be two titles, the main title is the name of the role, and the subtitle is the name of the person being played.
- In the top right of the card there is a seal used to indicate the good and a seal to indicate the bad. There should be no listing of the ability itself. The card should not be colored itself either (too easy to accidentally spot)
*/

// Avalon Role Card Library

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

// Main role card function
#let role-card(
  role-name,
  player-name: "",
  background-image: none,
  width: 2.5in,
  height: 3.5in,
  radius: 0.15in,
  good-seal: none,
  evil-seal: none,
) = {
  assert(role-name in roles, message: "Unknown role: " + role-name)

  let role = roles.at(role-name)
  let is-evil = role.team == "Evil"
  let seal-path = if is-evil { evil-seal } else { good-seal }

  box(
    width: width,
    height: height,
    radius: radius,
    stroke: 1pt + black,
    clip: true,
    inset: 0pt,
  )[
    // Background - either custom image or default gradient
    #place(
      top + left,
    )[
      #if background-image != none {
        image(background-image, width: 100%, height: 100%, fit: "cover")
      } else {
        // Default background with subtle pattern
        box(
          width: 100%,
          height: 100%,
          fill: gradient.linear(
            rgb("#2c3e50"),
            rgb("#34495e"),
            angle: 45deg,
          ),
        )
      }
    ]

    // Team seal in top right (if provided)
    #if seal-path != none [
      #place(
        top + right,
        dx: -0.2in,
        dy: 0.2in,
      )[
        #box(
          width: 0.6in,
          height: 0.6in,
        )[
          #image(seal-path, width: 100%, height: 100%, fit: "contain")
        ]
      ]
    ]

    // Bottom text area with semi-transparent background
    #place(
      bottom + center,
    )[
      #block(
        width: 100%,
        fill: rgb(0, 0, 0, 180),
        inset: (x: 0.2in, y: 0.25in),
      )[
        #set align(center)
        #set text(fill: white)

        // Role name (main title)
        #block[
          #set text(size: 1.1em, weight: "bold")
          #upper(role-name)
        ]

        // Player name (subtitle)
        #if player-name != "" [
          #v(0.08in)
          #block[
            #set text(size: 0.85em, style: "italic")
            #player-name
          ]
        ]
      ]
    ]
  ]
}

// Helper function to create a sheet of multiple cards
#let card-sheet(
  roles-list,
  player-names: (),
  images: (:),
  columns: 3,
  rows: 3,
  page-margin: 0.5in,
  card-spacing: 0.2in,
  good-seal: none,
  evil-seal: none,
) = {
  set page(
    width: 8.5in,
    height: 11in,
    margin: page-margin,
  )

  let cards = roles-list
    .enumerate()
    .map(((i, role)) => {
      let player = if i < player-names.len() { player-names.at(i) } else { "" }
      let role-image = images.at(role, default: none)
      role-card(
        role,
        player-name: player,
        background-image: role-image,
        good-seal: good-seal,
        evil-seal: evil-seal,
      )
    })

  grid(
    columns: (1fr,) * columns,
    rows: (1fr,) * rows,
    gutter: card-spacing,
    ..cards
  )
}

