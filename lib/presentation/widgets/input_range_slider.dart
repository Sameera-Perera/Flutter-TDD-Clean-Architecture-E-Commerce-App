import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/filter/filter_cubit.dart';

class RangeSliderExample extends StatefulWidget {
  final double initMin;
  final double initMax;
  const RangeSliderExample({
    super.key,
    required this.initMin,
    required this.initMax,
  });

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  final double max = 10000;
  final double min = 0;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RangeSliderExample oldWidget) {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: max,
      divisions: 10,
      activeColor: Colors.black87,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        if (values.start < values.end) {
          setState(() {
            _currentRangeValues = values;
            context.read<FilterCubit>().updateRange(
                _currentRangeValues.start, _currentRangeValues.end);
          });
        }
      },
    );
  }
}
