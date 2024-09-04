

---

# MpMonthPicker

`MpMonthPicker` is a highly customizable Flutter widget that provides a user-friendly dialog for selecting a month and year. It supports custom styles, localization, and animation effects, making it ideal for apps that require month-based date selection.

## Features

- **Customizable UI**: Change the colors, text styles, and icons to fit your app's theme.
- **Smooth Animations**: Includes a fade transition effect that can be customized for duration.
- **Auto Selection**: Option to automatically select the month upon tapping, bypassing the need for a done button.

## Installation

Add the following line to your `pubspec.yaml`:

```yaml
dependencies:
  mp_month_picker: latest_version
```

Then, run:

```bash
flutter pub get
```

## Usage

Here's a basic example of how to use `MpMonthPicker` in your Flutter project:

```dart
import 'package:flutter/material.dart';
import 'package:mp_month_picker/mp_month_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Month Picker Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              DateTime? selectedDate = await showMpMonthPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020, 1),
                lastDate: DateTime(2030, 12),
                selectedMonthColor: Colors.blue,
                unselectedMonthColor: Colors.grey,
                headerBgColor: Colors.blueAccent,
                doneTxt: 'Select',
                cancelTxt: 'Cancel',
                transitionDuration: Duration(milliseconds: 300),
                backIcon: Icons.chevron_left,
                forwardIcon: Icons.chevron_right,
                cancelTxtStyle: TextStyle(color: Colors.red),
                doneTxtStyle: TextStyle(color: Colors.green),
                selectedMonthBorderRadius: BorderRadius.circular(16),
              );
              if (selectedDate != null) {
                print('Selected Date: $selectedDate');
              }
            },
            child: Text('Pick a Month'),
          ),
        ),
      ),
    );
  }
}
```

## Parameters

### MpMonthPicker Widget

- **`initialDate`**: The initial selected date.
- **`firstDate`**: The earliest selectable date.
- **`lastDate`**: The last selectable date.
- **`onMonthChanged`**: Callback function triggered when a month is selected.
- **`selectedMonthColor`**: Background color of the selected month.
- **`headerBgColor`**: Background color of the header.
- **`backgroundColor`**: Background color of the picker dialog.
- **`headerTxtStyle`**: Text style for the header.
- **`unselectedMonthColor`**: Background color of unselected months.
- **`monthTextStyle`**: Text style for month names.
- **`isAutoSelect`**: Automatically selects the month on tap without showing the done button.
- **`transitionDuration`**: Duration of the fade transition animation.
- **`backIcon`**: Icon for navigating to the previous year.
- **`forwardIcon`**: Icon for navigating to the next year.
- **`doneTxt`**: Text for the done button.
- **`cancelTxt`**: Text for the cancel button.
- **`cancelTxtStyle`**: Text style for the cancel button.
- **`doneTxtStyle`**: Text style for the done button.
- **`selectedMonthBorderRadius`**: Border radius for the selected month container.

### showMpMonthPicker Function

- **`context`**: Build context.
- **`initialDate`**: The initial selected date.
- **`firstDate`**: The earliest selectable date.
- **`lastDate`**: The latest selectable date.
- **Other parameters**: Similar to those in `MpMonthPicker`.

## Customization

You can customize the appearance of the picker using various parameters:

- **Colors**: Change the colors of selected/unselected months, headers, and background.
- **Text Styles**: Customize the text styles for the header, month names, and buttons.
- **Icons**: Use custom icons for navigating between years.
- **Animation**: Adjust the transition duration to control the speed of the fade effect.


## Contributing

If you encounter any issues or have suggestions for improvements, feel free to open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

 
---
