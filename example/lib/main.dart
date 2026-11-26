import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list_plus/scrollable_positioned_list_plus.dart';

void main() => runApp(const ExampleApp());

/// A list of 10,000 rows of varying height. Tapping a number jumps or scrolls
/// straight to that row, and the header shows which rows are visible.
class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  static const _itemCount = 10000;

  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF007AFF),
      builder:
          (context, _) => DefaultTextStyle(
            style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
            child: ColoredBox(
              color: const Color(0xFFFFFFFF),
              child: SafeArea(
                child: Column(
                  children: [
                    ValueListenableBuilder<Iterable<ItemPosition>>(
                      valueListenable: _itemPositionsListener.itemPositions,
                      builder: (context, positions, _) {
                        final visibleIndexes = positions.map((p) => p.index);
                        return Text(
                          visibleIndexes.isEmpty
                              ? ''
                              : 'Visible: ${visibleIndexes.reduce((a, b) => a < b ? a : b)}'
                                  ' to ${visibleIndexes.reduce((a, b) => a > b ? a : b)}',
                        );
                      },
                    ),
                    Wrap(
                      spacing: 16,
                      children: [
                        for (final index in [0, 250, 5000, 9999])
                          GestureDetector(
                            onTap:
                                () =>
                                    _itemScrollController.jumpTo(index: index),
                            child: Text('jump $index'),
                          ),
                        GestureDetector(
                          onTap:
                              () => _itemScrollController.scrollTo(
                                index: 777,
                                duration: const Duration(milliseconds: 600),
                              ),
                          child: const Text('scroll 777'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemCount: _itemCount,
                        itemScrollController: _itemScrollController,
                        itemPositionsListener: _itemPositionsListener,
                        itemBuilder:
                            (context, index) => Container(
                              height: 40.0 + (index % 4) * 24,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              color:
                                  index.isEven
                                      ? const Color(0xFFF2F2F7)
                                      : const Color(0xFFFFFFFF),
                              child: Text('Row $index'),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
