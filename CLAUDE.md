# CLAUDE.md — Notes for AI Coding Agents

This is a Flutter coursework project (university, beginner–intermediate). Read `AGENTS.md` first — it is the authoritative ruleset. This file adds agent-specific reminders.

## Hard rules (from AGENTS.md)
- Simple MVC: `model/`, `controller/`, `screen/`, `dataaccess/`, `provider/`. No repository/usecase/services/bloc layers.
- State via `GetX` `Rx` + `Obx`. Public mutable fields in models (except `id`). `fromMap`/`toMap` manual — no codegen.
- No overengineering: no freezed, no streams/rxDart, no get_it, no unit tests unless asked.
- `StatelessWidget` preferred. Use `Get.to()`/`Get.back()`, `Get.snackbar()`.
- File naming `snake_case.dart`; `package:` imports only.

## Secrets / .env (security policy — user-approved)
- `flutter_dotenv` is allowed (exception to "no new libs without asking" — approved for security).
- **Never** hard-code API keys in `lib/`. They live in `.env` (gitignored).
- `.env.example` is the committed template; `.env` is NOT committed.
- Read keys via `dotenv.env["KEY"]`. See `lib/utils/constants.dart` (`apiKey` getter) and `lib/main.dart` (load before `runApp`).
- `geolocator` is used for location; if a Google Maps key is added later, keep it in `.env` too, not in `AndroidManifest`/`Info.plist` inline.

## API call hardening (mandatory — see AGENTS.md "Security API Call")
- All HTTP calls live in controllers (e.g. `lib/controller/plant_controller.dart`).
- `apiKey` stays in `constants.dart`; never move it into a controller.
- Never log/print/display the API key.
- Guard: `if (apiKey.isEmpty) { Get.snackbar(...); return; }` before every request.
- Every call wrapped in try-catch; check `response.statusCode == 200` before `jsonDecode`.
- Add a timeout via `Future.timeout(Duration(seconds: 15))` (no new package).
- On failure (timeout / non-200 / exception): `Get.snackbar(...)`.
- Keep it simple. Do NOT add a new HTTP/retry package.

## API
- Perenual API (`baseUrl` in `constants.dart`). Key passed as `?key=` query param.
- See `docs/04_api_database.md` for endpoints.

## Verification
- Run `flutter analyze` before claiming done. Keep it green.
- Don't run `flutter pub get` / build unless asked or needed to verify; if you do, report the real output.
