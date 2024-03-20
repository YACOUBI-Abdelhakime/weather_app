# Weather App

This is a weather application built with Flutter. It uses the BLoC pattern for state management.

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repo

```bash
git clone ....
```

2. Navigate into the cloned directory

```bash
cd weather_app
```

3. Create file api_key.dart in `/lib`

```bash
cd lib
touch api_key.dart
```

4. Get your open weather api key from [https://home.openweathermap.org/api_keys](https://home.openweathermap.org/api_keys)

5. Add your open weather api key to `api_key.dart` file

```bash
echo  "String API_KEY = 'YOUR_API_KEY';" > api_key.dart
```

6. Install dependencies

```bash
flutter pub get
```

7. Run the app

```bash
flutter run
```

## Project Structure

- `lib/main.dart`: The entry point of the application.
- `lib/bloc/`: Contains all the BLoC classes.
- `lib/models/`: Contains the data models.
- `lib/repositories/`: Contains the repository classes.
- `lib/services/`: Contains the service classes.
- `lib/views/`: Contains the UI screens.

## Testing

This project uses unit testing with the `flutter_test` package, BLoC testing with the `bloc_test` package, and uses the `mocktail` package for mocking dependencies in tests.

Run tests with the following command:

```bash
flutter test
```
