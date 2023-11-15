# PhotoPill
PhotoPill is an app that will allow users to enter basic information about a pill (such as color, imprint, shape, size, etc.) to find the name of the pill. Data is pulled from the RxNorm API to find possible matches for inputted user data.


## Release Notes

### Version 0.3.0:
#### New Features
* Revitalized user interface to allow intuitive navigation between screens.
* Added ability to manually enter patient descriptions
* Manually entered patient descriptions are stored locally.
* Added ability to individually edit or delete medication list.

#### Bug Fixes
* Empty text is no longer allowed as a valid input, even while editing.
* Medications no longer disappear upon switching screens.

#### Known Errors
* Navigation towards patient medications screen and patient description screen via the initial home page, leads to unsaved items.
* Potential overflow occurs on patient description page if entered input is too long for specific fields.


---
### Version 0.2.0:
#### New Features
* Added ability to manually enter medications by name
* Manually entered medications are stored locally.
* Manually entered medications will be displayed in a list on the screen.

#### Bug Fixes
N/A

#### Known Errors
* List of medications will disappear once user switches screens
* Empty text is allowed as valid input and will appear in lists

---
### Version 0.1.0:
#### New Features
* Added demo home screen with interactive button.
* Added compatability for both Android and iOS.

#### Bug Fixes
N/A
