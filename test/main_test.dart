import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:isar/isar.dart';
import 'package:notes/features/location/data/datasource/local_location_datasource_impl.dart';
import 'package:notes/features/notes/data/datasources/note_datasource_impl.dart';
import 'package:notes/main.dart';

class MockIsar extends Mock implements Isar {}

class MockNoteDatasourceImpl extends Mock implements NoteDatasourceImpl {}

class MockLocalLocationDataSourceImpl extends Mock
    implements LocalLocationDataSourceImpl {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyApp Initialization', () {
    late MockNoteDatasourceImpl mockNoteDatasource;
    late MockLocalLocationDataSourceImpl mockLocationDatasource;

    setUp(() async {
      mockNoteDatasource = MockNoteDatasourceImpl();
      mockLocationDatasource = MockLocalLocationDataSourceImpl();
    });

    testWidgets('MyApp initializes correctly with provided datasources',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(
        notesDatasource: mockNoteDatasource,
        locationDataSource: mockLocationDatasource,
      ));

      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
