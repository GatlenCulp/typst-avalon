// Avalon Card Library - Core Styjling and Setup

// Default card dimensions and styling
#let default-card-config = (
  width: 2.5in,
  height: 3.5in,
  radius: 0.15in,
  stroke: 1pt + black,
  seal-size: 0.6in,
  seal-offset: (x: -0.2in, y: 0.2in),
  title-size: 1.1em,
  subtitle-size: 0.85em,
  bottom-inset: (x: 0.2in, y: 0.25in),
  bottom-background: rgb(0, 0, 0, 180),
  default-background-start: rgb("#2c3e50"),
  default-background-end: rgb("#34495e"),
)

// Main avalon card function
#let avalon-card(
  role-name,
  team, // "Good" or "Evil"
  player-name: "",
  background-image: none,
  width: default-card-config.width,
  height: default-card-config.height,
  radius: default-card-config.radius,
  good-seal: none,
  evil-seal: none,
) = {
  let is-evil = team == "Evil"
  let seal-path = if is-evil { evil-seal } else { good-seal }

  // Background - either custom image or default gradient
  place(
    top + left,
  )[
    #if background-image != none {
      image(background-image, width: 100%, height: 100%, fit: "cover")
    } else {
      // Default background with subtle pattern
      rect(
        width: 100%,
        height: 100%,
        fill: gradient.linear(
          default-card-config.default-background-start,
          default-card-config.default-background-end,
          angle: 45deg,
        ),
      )
    }
  ]

  // Team seal in top right (if provided)
  if seal-path != none [
    #place(
      top + right,
      dx: default-card-config.seal-offset.x,
      dy: default-card-config.seal-offset.y,
    )[
      #box(
        width: default-card-config.seal-size,
        height: default-card-config.seal-size,
      )[
        #image(seal-path, width: 100%, height: 100%, fit: "contain")
      ]
    ]
  ]

  // Bottom text area with semi-transparent background
  place(
    bottom + center,
  )[
    #block(
      width: 100%,
      fill: default-card-config.bottom-background,
      inset: default-card-config.bottom-inset,
    )[
      #set align(center)
      #set text(fill: white)

      // Role name (main title)
      #block[
        #set text(size: default-card-config.title-size, weight: "bold")
        #upper(role-name)
      ]

      // Player name (subtitle)
      #if player-name != "" [
        #v(0.08in)
        #block[
          #set text(size: default-card-config.subtitle-size, style: "italic")
          #player-name
        ]
      ]
    ]
  ]
}

// Page setup for individual cards - page size matches card size
#let card-page(
  width: default-card-config.width,
  height: default-card-config.height,
  margin: 0pt,
) = {
  set page(
    width: width,
    height: height,
    margin: margin,
  )
}
