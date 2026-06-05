# Pamoja Thrift — Flutter Web

A modern, responsive landing page for **Pamoja Thrift**, a marketplace that connects buyers and sellers of second-hand products.

## Tech Stack

- **Flutter Web** (3.35.5)
- **responsive_framework** — Breakpoint-based responsive layouts
- **google_fonts** — Playfair Display (headings) + Roboto (body)
- Clean Architecture with reusable widgets

## Project Structure

```
lib/
├── main.dart                     # Entry point
├── app.dart                      # MaterialApp + ResponsiveBreakpoints
├── core/
│   ├── theme/
│   │   ├── app_colors.dart       # Color palette constants
│   │   ├── app_text_styles.dart  # Google Fonts typography
│   │   └── app_theme.dart        # ThemeData factory
│   ├── constants/
│   │   └── app_constants.dart    # Static copy, nav items, metadata
│   └── animations/
│       └── scroll_animations.dart # Scroll-triggered fade/slide
├── presentation/
│   ├── home/
│   │   └── home_screen.dart      # Scaffold + section composition
│   ├── sections/
│   │   ├── nav_bar.dart          # Sticky responsive navbar + drawer
│   │   ├── hero_section.dart     # Hero with CTA buttons + mockup
│   │   ├── about_section.dart    # Mission, Vision, Community Impact
│   │   ├── buyer_problems_section.dart
│   │   ├── seller_problems_section.dart
│   │   ├── download_section.dart # App download CTA + metadata
│   │   ├── contact_section.dart  # Contact info + form
│   │   └── footer_section.dart   # Quick links + copyright
│   └── widgets/
│       ├── section_wrapper.dart  # Consistent padding + max-width
│       ├── cta_button.dart       # Styled action button (primary/accent/outlined)
│       ├── section_heading.dart  # Title + subtitle + accent underline
│       └── social_icon_row.dart  # Social media icon placeholders
└── data/
    └── models/                   # (extensible for future use)
```

## Color Palette

| Role        | Color   | Hex       |
|-------------|---------|-----------|
| Primary     | Green   | `#388E3C` |
| Secondary   | White   | `#FAFAFA` |
| Accent      | Amber   | `#FFC107` |
| Earth Brown | Brown   | `#5D4037` |

## Typography

- **Headings**: Playfair Display (sizes 28–48px)
- **Body**: Roboto (16px base)

## Features

- ✅ Responsive layout (mobile / tablet / desktop / XL)
- ✅ Sticky navbar with smooth scrolling & active section highlighting
- ✅ Mobile hamburger menu with full-screen drawer
- ✅ Scroll-triggered fade-in / slide-up animations
- ✅ Hover effects on nav links, buttons, cards
- ✅ Contact form with validation
- ✅ Keyboard accessible (Focus, Semantics)
- ✅ Proper color contrast throughout

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run in development
flutter run -d chrome

# Build for production
flutter build web
```

## Build Output

`build/web/` — deployable to any static host (Vercel, Netlify, Firebase, etc.)
