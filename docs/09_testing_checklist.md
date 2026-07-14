# Manual Testing Checklist — PlantCare App

Mark each item after testing on an Android device/emulator.

| No. | Test case                     | Expected result                                    | Status |
| --- | ----------------------------- | -------------------------------------------------- | ------ |
| 1   | Register valid user           | New user saved in SQLite and returns to Login      | ✅     |
| 2   | Register duplicate username   | Error snackbar; user is not duplicated             | ✅     |
| 3   | Register invalid fields       | Validators/snackbar prevent registration           | ✅     |
| 4   | Login registered account      | Session and username saved; Home opens             | ✅     |
| 5   | Login wrong credentials       | Error snackbar; remains on Login                   | ✅     |
| 6   | Logout                        | Session is cleared; Login opens                    | ✅     |
| 7   | Splash session check          | Routes to Home when logged in, Login otherwise     | ✅     |
| 8   | Home API list                 | Plant ListView is displayed                        | ✅     |
| 9   | Search                        | Matching API results or empty state are displayed  | ✅     |
| 10  | Detail                        | Plant information is shown                         | ✅     |
| 11  | Save to My Garden             | Selected API plant is saved locally                | ✅     |
| 12  | Add plant                     | Valid manual plant appears in My Garden            | ✅     |
| 13  | Edit plant                    | Updated values are shown after save                | ✅     |
| 14  | Delete plant                  | Confirmation works and record is removed           | ✅     |
| 15  | Take picture                  | Camera picture path is selected and saved locally  | ✅     |
| 16  | Record video                  | Camera video path is selected and saved locally    | ✅     |
| 17  | Get GPS location              | Permission/service flow obtains coordinates        | ✅     |
| 18  | Save latitude/longitude       | Coordinates persist in the garden record           | ✅     |
| 19  | Profile username              | Username matches the logged-in account             | ✅     |
| 20  | Missing API key               | Snackbar appears; app does not crash or reveal key | ✅     |
| 21  | API non-200/timeout/eTception | Snackbar appears; app remains usable               | ✅     |
| 22  | My Garden empty state         | Clear empty message is shown with no records       | ✅     |
| 23  | API/search error state        | Failure feedback is shown without crash            | ✅     |
