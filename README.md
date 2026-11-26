# scrollable_positioned_list_plus

[![pub package](https://img.shields.io/pub/v/scrollable_positioned_list_plus.svg)](https://pub.dev/packages/scrollable_positioned_list_plus)
[![CI](https://github.com/bada-labs/scrollable_positioned_list_plus/actions/workflows/ci.yaml/badge.svg)](https://github.com/bada-labs/scrollable_positioned_list_plus/actions/workflows/ci.yaml)

A Flutter list that can jump or scroll to a specific item, and report which items are visible.

This is a maintained successor of [`scrollable_positioned_list`](https://pub.dev/packages/scrollable_positioned_list). Google archived its repository in 2024, so 0.3.8 (2023) is its final release. Bada Labs uses this package in production apps.

## What's different from `scrollable_positioned_list` 0.3.8

- **Works with current Flutter.** 0.3.8 uses `cacheExtent` and `cacheExtentStyle`, which Flutter deprecated in 3.41 in favor of `ScrollCacheExtent` and will remove. This package uses the new API, with the same cache sizes.
- **No other deprecated APIs.** `Matrix4.translate`, pre-null-safety checks and a `dynamic` equality operator are replaced with their current equivalents.
- **Same behavior.** The original test suite (181 tests) runs in this repository and passes unchanged, apart from importing `unawaited` from `dart:async` instead of the retired `pedantic` package.
- Requires Flutter 3.41 or later, the first version with `ScrollCacheExtent`.

## Migrating from `scrollable_positioned_list`

1. In `pubspec.yaml`, replace `scrollable_positioned_list` with `scrollable_positioned_list_plus`.
2. Replace `package:scrollable_positioned_list/` with `package:scrollable_positioned_list_plus/` in your imports.

The API is unchanged.

## Usage


A `ScrollablePositionedList` works much like the builder version of `ListView`
except that the list can be scrolled or jumped to a specific item.

### Example

A `ScrollablePositionedList` can be created with:

```dart
final ItemScrollController itemScrollController = ItemScrollController();
final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

ScrollablePositionedList.builder(
  itemCount: 500,
  itemBuilder: (context, index) => Text('Item $index'),
  itemScrollController: itemScrollController,
  scrollOffsetController: scrollOffsetController,
  itemPositionsListener: itemPositionsListener,
  scrollOffsetListener: scrollOffsetListener,
);
```

One then can scroll to a particular item with:

```dart
itemScrollController.scrollTo(
  index: 150,
  duration: Duration(seconds: 2),
  curve: Curves.easeInOutCubic);
```

or jump to a particular item with:

```dart
itemScrollController.jumpTo(index: 150);
```

One can monitor what items are visible on screen with:

```dart
itemPositionsListener.itemPositions.addListener(() => ...);
```

### Experimental APIs (subject to bugs and changes)

Changes in scroll position can be monitored with:

```dart
scrollOffsetListener.changes.listen((event) => ...)
```

see `ScrollSum` in [this test](test/scroll_offset_listener_test.dart) for an example of how the current offset can be 
calculated from the stream of scroll change deltas.  This feature is new and experimental.

Changes in scroll position in pixels, relative to the current scroll position, can be made with:

```dart
scrollOffsetController.animateScroll(offset: 100, duration: Duration(seconds: 1));
```

A full example can be found in the example folder.

## Scope

This package fixes bugs and keeps up with Flutter changes. New features are considered conservatively to keep it small and dependable.

## Credits

Based on [`scrollable_positioned_list`](https://github.com/google/flutter.widgets/tree/master/packages/scrollable_positioned_list) by the Flutter widgets authors at Google, under the BSD 3-Clause license. Maintained by [Bada Labs](https://badalabs.com). This is not an officially supported Google product.
