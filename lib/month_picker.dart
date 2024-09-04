library mp_month_picker;

import 'package:flutter/material.dart';

/// A widget that displays a dialog to pick a month and year.
class MpMonthPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime?> onMonthChanged;
  final Color? selectedMonthColor;
  final Color? headerBgColor;
  final Color? backgroundColor;
  final TextStyle? headerTxtStyle;
  final Color? unselectedMonthColor;
  final TextStyle? monthTextStyle;
  final Locale? locale;
  final bool isAutoSelect;
  final List<String>? customMonthNames;
  final Duration transitionDuration;
  final IconData? backIcon;
  final IconData? forwardIcon;
  final String? doneTxt;
  final String? cancelTxt;
  final TextStyle? cancelTxtStyle;
  final TextStyle? doneTxtStyle;
  final BorderRadiusGeometry? selectedMonthBorderRadius;

  const MpMonthPicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onMonthChanged,
    this.selectedMonthColor,
    this.headerTxtStyle,
    this.headerBgColor,
    this.unselectedMonthColor,
    this.isAutoSelect = false,
    this.monthTextStyle,
    this.locale,
    this.customMonthNames,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.backIcon,
    this.forwardIcon,
    this.doneTxt,
    this.cancelTxt,
    this.cancelTxtStyle,
    this.doneTxtStyle,
    this.selectedMonthBorderRadius,
    this.backgroundColor,
  });

  @override
  State<MpMonthPicker> createState() => _MpMonthPickerState();
}

class _MpMonthPickerState extends State<MpMonthPicker> {
  late DateTime _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);
    _firstDate = DateTime(widget.firstDate.year, widget.firstDate.month);
    _lastDate = DateTime(widget.lastDate.year, widget.lastDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildHeader(),
                AnimatedSwitcher(
                  duration: widget.transitionDuration,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final fadeTransition = FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                    return fadeTransition;
                  },
                  child: GridView.builder(
                    key: ValueKey<int>(_selectedDate.month),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final month = index + 1;
                      final isSelected = _selectedDate.month == month && _selectedDate.year == widget.initialDate.year;
                      final isEnabled = _isMonthEnabled(month);

                      return GestureDetector(
                        onTap: isEnabled ? () {
                          setState(() {
                            _selectedDate = DateTime(_selectedDate.year, month);
                            if(widget.isAutoSelect){
                              widget.onMonthChanged(_selectedDate);
                            }
                          });
                        } : null,
                        child: Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? widget.selectedMonthColor ?? Colors.deepPurple
                                : widget.unselectedMonthColor ?? Colors.transparent,
                            borderRadius: widget.selectedMonthBorderRadius ?? BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _getMonthName(month),
                            style: widget.monthTextStyle?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : (isEnabled
                                  ? widget.monthTextStyle?.color ?? Colors.black
                                  : Colors.grey),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : widget.monthTextStyle?.fontWeight ?? FontWeight.normal,
                            ) ?? TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : (isEnabled ? Colors.black : Colors.grey),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4,),
                if(!widget.isAutoSelect)
                  _buildBottom(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: Navigator.of(context).pop, child: Text(widget.cancelTxt ?? 'Cancel', style: widget.cancelTxtStyle,)),
          TextButton(onPressed: (){
            widget.onMonthChanged(_selectedDate);
          }, child: Text(widget.doneTxt ?? 'OK', style: widget.doneTxtStyle,)),
      ],),
    );
  }

  Container _buildHeader() {
    final bool canDecrementYear = DateTime(_selectedDate.year).isAfter(DateTime(_firstDate.year));
    final bool canIncrementYear = DateTime(_selectedDate.year).isBefore(DateTime(_lastDate.year));

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: widget.headerBgColor ?? Colors.deepPurple,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          if(canDecrementYear)
            Positioned(
              left: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (_selectedDate.year > _firstDate.year) {
                      _selectedDate = DateTime(_selectedDate.year - 1, _selectedDate.month);
                    }

                    if (_selectedDate.year == _firstDate.year && _selectedDate.month < _firstDate.month) {
                      _selectedDate = DateTime(_firstDate.year, _firstDate.month);
                    }
                  });
                },
                icon: Icon(widget.backIcon ?? Icons.arrow_left, color: Colors.white),
              ),
            ),
          Center(
            child: Text(
              "${_selectedDate.year}",
              style: widget.headerTxtStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          if(canIncrementYear)
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (_selectedDate.year < _lastDate.year) {
                      _selectedDate = DateTime(_selectedDate.year + 1, _selectedDate.month);
                    }

                    if (_selectedDate.year == _lastDate.year && _selectedDate.month > _lastDate.month) {
                      _selectedDate = DateTime(_lastDate.year, _lastDate.month);
                    }
                  });
                } ,
                icon: Icon(widget.forwardIcon ?? Icons.arrow_right, color: Colors.white,),
              ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    if (widget.customMonthNames != null && widget.customMonthNames!.length == 12) {
      return widget.customMonthNames![month - 1];
    }

    final locale = widget.locale?.languageCode ?? 'en';
    final monthNames = MonthPickerLocale.eng[MonthPickerLocale.monthNames] as List<String>;

    switch (locale) {
      case 'km':
        return (MonthPickerLocale.kmLocale[MonthPickerLocale.monthNames] as List<String>)[month - 1];
      case 'ja':
        return (MonthPickerLocale.jaLocale[MonthPickerLocale.monthNames] as List<String>)[month - 1];
      default:
        return monthNames[month - 1];
    }
  }

  bool _isMonthEnabled(int month) {
    final date = DateTime(_selectedDate.year, month);

    /// Check if the selected month should be enabled based on the year
    bool isMonthWithinRange = false;
    if (date.year == widget.firstDate.year) {
      isMonthWithinRange = date.month >= widget.firstDate.month;
    }
    /// Case 2: The date is within the same year as lastDate
    else if (date.year == widget.lastDate.year) {
      isMonthWithinRange = date.month <= widget.lastDate.month;
    }
    /// Case 3: The date is within the range between firstDate and lastDate spanning across years
    else if (date.year > widget.firstDate.year && date.year < widget.lastDate.year) {
      isMonthWithinRange = true;
    }

    /// Ensure the month is enabled if it matches the initialDate's month and year
    bool isInitialDateMonth = (date.year == widget.initialDate.year && date.month == widget.initialDate.month);

    return isMonthWithinRange || isInitialDateMonth;
  }

}

/// Shows the month picker dialog and returns the selected [DateTime].
Future<DateTime?> showMpMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  Color? unselectedMonthColor,
  Duration transitionDuration = const Duration(milliseconds: 200),
  Color? selectedMonthColor,
  Color? backgroundColor,
  Color? headerBgColor,
  TextStyle? headerTxtStyle,
  TextStyle? monthTextStyle,
  bool isAutoSelect = false,
  IconData? backIcon,
  IconData? forwardIcon,
  TextStyle? cancelTxtStyle,
  TextStyle? doneTxtStyle,
  String? cancelTxt,
  String? doneTxt,
  BorderRadiusGeometry? selectedMonthBorderRadius,

}) {
  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return MpMonthPicker(
        initialDate: initialDate,
        firstDate: firstDate,
        unselectedMonthColor: unselectedMonthColor,
        selectedMonthColor: selectedMonthColor,
        lastDate: lastDate,
        headerBgColor: headerBgColor,
        headerTxtStyle: headerTxtStyle,
        monthTextStyle: monthTextStyle,
        transitionDuration: transitionDuration,
        isAutoSelect: isAutoSelect,
        backIcon: backIcon,
        forwardIcon: forwardIcon,
        doneTxtStyle: doneTxtStyle,
        cancelTxtStyle: cancelTxtStyle,
        doneTxt: doneTxt,
        cancelTxt: cancelTxt,
        backgroundColor: backgroundColor,
        selectedMonthBorderRadius: selectedMonthBorderRadius,
        onMonthChanged: (date) {
          Navigator.of(context).pop(date);
        },
      );
    },
  );
}

mixin MonthPickerLocale {
  static const String monthNames = 'monthNames';

  static const Map<String, dynamic> eng = {
    monthNames: [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ],
  };

  static const Map<String, dynamic> kmLocale = {
    monthNames: [
      "មករា", "កុម្ភៈ", "មីនា", "មេសា", "ឧសភា", "មិថុនា",
      "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ"
    ],
  };

  static const Map<String, dynamic> jaLocale = {
    monthNames: [
      "1月", "2月", "3月", "4月", "5月", "6月",
      "7月", "8月", "9月", "10月", "11月", "12月"
    ],
  };
}

