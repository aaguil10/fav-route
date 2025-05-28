import 'package:fav_route/add_place_sheet.dart';
import 'package:fav_route/main.dart' show rootNavigatorKey;
import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<Place?> _openSheet(WidgetTester tester, {Place? initial}) async {
    Future<Place?>? sheetFuture;

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: rootNavigatorKey,
        home: Scaffold(
          body: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                child: const Text('OPEN'),
                onPressed: () {
                  // capture the Future<Place?>, but DO NOT await it here
                  sheetFuture = AddPlaceSheet.show(context, initial: initial);
                },
              ),
            );
          }),
        ),
      ),
    );

    // tap the OPEN button
    await tester.tap(find.text('OPEN'));
    // let the bottom sheet animation run
    await tester.pump(); // start the sheet
    await tester
        .pump(const Duration(milliseconds: 300)); // finish the animation

    return sheetFuture;
  }

  testWidgets('returns a new Place when all fields are valid', (tester) async {
    // Kick off the sheet opening (don’t await, we want the Future for later)
    final futurePlace = await _openSheet(tester);

    // locate each input by its semantics label
    final titleField = find.bySemanticsLabel('Title');
    final addressField = find.bySemanticsLabel('Address');
    final noteField = find.bySemanticsLabel('Note');

    expect(titleField, findsOneWidget);
    expect(addressField, findsOneWidget);
    expect(noteField, findsOneWidget);

    expect(titleField, findsOneWidget);
    expect(addressField, findsOneWidget);
    expect(noteField, findsOneWidget);

    // type into each
    await tester.enterText(titleField, 'Coffee Shop');
    await tester.enterText(addressField, '123 Java Ave');
    await tester.enterText(noteField, 'Best espresso in town');

    // tap your “save” TextButton
    await tester.tap(find.widgetWithText(TextButton, 'save'));
    await tester.pumpAndSettle();

    // only now will the sheet pop and the Future complete
    final place = await futurePlace;
    expect(place, isNotNull);
    expect(place!.name, 'Coffee Shop');
    expect(place.address, '123 Java Ave');
    expect(place.note, 'Best espresso in town');
  });

  testWidgets('shows validation errors when required fields are empty',
      (tester) async {
    // open the sheet
    final futurePlace = await _openSheet(tester);

    // tap “Add” without entering anything
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pumpAndSettle();

    // two “Required” errors: title + address
    expect(find.text('Required'), findsNWidgets(2));

    // fill only the title
    final titleField = find.byType(TextFormField).at(0);
    await tester.enterText(titleField, 'Bakery');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pumpAndSettle();

    // now only one error (address)
    expect(find.text('Required'), findsOneWidget);

    // confirm we did not pop
    expect(await futurePlace, isNull);
  });

  testWidgets('initializes fields when editing existing Place', (tester) async {
    final existing = Place(
      id: 42,
      name: 'Library',
      address: '456 Book Rd',
      note: 'Quiet spot',
    );

    final futurePlace = await _openSheet(tester, initial: existing);

    // the fields should already contain the initial data
    expect(find.widgetWithText(TextFormField, 'Library'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '456 Book Rd'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Quiet spot'), findsOneWidget);

    // tap “Save” (when initial != null the button label is “Save”)
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    // verify returned Place preserves the same id
    final place = await futurePlace;
    expect(place, isNotNull);
    expect(place!.id, equals(42));
  });
}
