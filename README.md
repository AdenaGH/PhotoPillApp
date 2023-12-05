# PhotoPill
PhotoPill is an app that will allow users to enter basic information about a pill (such as color, imprint, shape, size, etc.) to find the name of the pill. Data is pulled from the RxNorm API to find possible matches for inputted user data.

## Installation instructions
1. Navigate to the main page of this repository.
2. Click on "Code", and download the ZIP.
3. Open in IDE of your choice. We suggest VSCode.
4. If using VSCode, choose a simulator from the bottom right and hit run in the tab menu.
5. To install to an iOS device (MacOS required) , click on the "iOS" folder in VSCode, right click on the .workspace file to show in Finder, and double click the file to open in XCode. Connect your phone to your Mac device, then hit "run".

## Release Notes

### Version 0.5.0:
#### New Features
* Implemented cross-referencing  to display ranked drug matches on search results screen.
* Implemented error dialog for searching with empty patient medication list.
* Finalized and implemented smooth navigation between pages.

#### Bug Fixes
* Clear button works and restarting the app also clears data.
* Ability to edit and clear patient medications individually and as a group.

#### Known Errors
* N/A


---
### Version 0.4.0:
#### New Features
* Implemented API call to find drug rxcui given a medication name.
* Implemented API calling to find drug properties utilizing the rxcui as a parameter.
* Added functionality to format api response.

#### Bug Fixes
* State and data is saved across different states, even when navigating through the home page.
* Overflow on patient description page no longer occurs.

#### Known Errors
* Search can happen even with an empty patient medication list


---
### Version 0.3.0:
#### New Features
* Revitalized user interface to allow intuitive navigation between screens.
* Added ability to manually enter patient descriptions.
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
* List of medications will disappear once user switches screens.
* Empty text is allowed as valid input and will appear in lists.

---
### Version 0.1.0:
#### New Features
* Added demo home screen with interactive button.
* Added compatability for both Android and iOS.

#### Bug Fixes
N/A
