# mp_month_picker

[![pub package](https://img.shields.io/pub/v/mp_month_picker.svg)](https://pub.dev/packages/mp_month_picker)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Customizable Flutter month & year picker dialog. Designed for apps that need month-based selection (reports, billing cycles, calendars) with themeable UI and optional auto-select.

## Features

- Themeable colors, text styles, and icons
- Fade transition with configurable duration
- Optional auto-select (skip the done button)
- `showMpMonthPicker` helper for one-line dialogs

## Installation

```yaml
dependencies:
  mp_month_picker: ^0.0.2
```

```bash
flutter pub get
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:mp_month_picker/mp_month_picker.dart';

Future<void> pickMonth(BuildContext context) async {
  final selectedDate = await showMpMonthPicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020, 1),
    lastDate: DateTime(2030, 12),
    selectedMonthColor: Colors.blue,
    unselectedMonthColor: Colors.grey,
    headerBgColor: Colors.blueAccent,
    doneTxt: 'Select',
    cancelTxt: 'Cancel',
    transitionDuration: const Duration(milliseconds: 300),
    backIcon: Icons.chevron_left,
    forwardIcon: Icons.chevron_right,
  );

  if (selectedDate != null) {
    debugPrint('Selected: $selectedDate');
  }
}
```

## Key parameters

| Parameter | Description |
|---|---|
| `initialDate` | Initially selected month |
| `firstDate` / `lastDate` | Selectable range |
| `selectedMonthColor` / `unselectedMonthColor` | Month chip colors |
| `headerBgColor` / `backgroundColor` | Dialog chrome |
| `isAutoSelect` | Select immediately on tap |
| `transitionDuration` | Fade animation length |
| `doneTxt` / `cancelTxt` | Action labels |

See the [example app](example/) for a full interactive demo.

## Contributing

Issues and suggestions welcome on [GitHub](https://github.com/kamranibrahim/mp_month_picker/issues).

## License

[MIT](LICENSE)
