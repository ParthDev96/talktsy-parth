import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'appName': 'Talktsy',
          'helloThere': 'Hello There',
          'loginIntoTalktsy': 'Login into Talktsy',
          'forgotPassword': 'Forgot Password?',
          'notAMember': 'Not a Member?',
          'signUpNow': 'Sign Up Now',
          'fullName': 'Full Name',
          'emailId': 'Email ID',
          'password': 'Password',
          'confirmPassword': 'Confirm Password',
          'enterMobileNumber': 'Enter mobile number',
          'selectLanguage': 'Select language',
          'alreadyAMember': 'Already a Member?',
          'login': 'Login',
          'getStarted': 'Get Started',
          'signupSubTitleText':
              'Enter the details and get started you journey with us to make Video call, Call and chat.',

          // Success messages
          'loginSuccessMessage':
              'Welcome back! You have successfully logged in.',

          // Validation messages
          'errorEmail': 'Please enter email',
          'errorValidEmail': 'Please enter valid email',
          'errorPassword': 'Please enter password',
          'error': 'Error',
          'success': 'Success',

          // Verification
          'verification': 'Verification',
          'verificationMessage1':
              'We send you verification code to your phone ',
          'verificationMessage2': ' and email address ',
          'verificationMessage3': ' which you provided.',
          'DidNotReceivedCode': 'Didn’t received code?',
          'RequestAgain': 'Request again',

          // Tabs
          'chat': 'Chat',
          'files': 'Files',
          'calls': 'Calls',
          'meetings': 'Meetings',
          'profile': 'Profile',

          'scan': 'Scan',
          'upload': 'Upload',
          'folder': 'Folder',
          'search': 'Search',
          'cancel': 'Cancel',
          'ok': 'Ok',
          'close': 'Close',
          'create': 'Create',
          'addFolder': 'Add Folder',
          'name': 'Name',
          'destination': 'Destination',

          'newChat': 'New Chat',
          'newGroupChat': 'New Group Chat',
          'joinAMeeting': 'Join a Meeting',
          'join': 'Join',
          'scheduleMeeting': 'Schedule Meeting',
          'meetingsSchedule': 'Meetings Schedule',
          'addOrEditMeeting': 'Add or Edit Meeting',
          'addTitle': 'Add Title',
          'allDay': 'All Day',
          'addPeople': 'Add People',
          'minutesBefore': 'minutes before',
          'addDescription': 'Add Description',

          'save': 'Save',
          'or': 'Or',
          'meetingID': 'Meeting ID',
          'incomingCall': 'Incoming Call',
          'reject': 'Reject',
          'confirm': 'Confirm',
          'contacts': 'Contacts',
          'contactAvailable': 'contact available',
          'translationLanguage': 'Translation Language',
          'rememberMyNameForFutureMeetings':
              'Remember my name for future meetings',

          'inviteFriends': 'Invite Friends',
          'invite': 'Invite',
          'blockUnblock': 'Block/Unblock',
          'settings': 'Settings',
          'about': 'About',
          'logout': 'Logout',
          'quickSuggestion': 'Quick Suggestion',
          'okay': 'Okay',
          "next": "Next",

          'newGroup': 'New Group',
          'notifications': 'Notifications',
          'accept': 'Accept',
          "decline": "Decline",
          "block": "Block",
          "send": "Send",
          'accountAndProfile': 'Account and Profile',
          'language': 'Language',
          'calling': 'Calling',
          'messaging': 'Messaging',
          'customerSupport': 'Customer Support',
          'privacyPolicy': 'Privacy Policy',
          'allContact': 'All Contact',
          'blocked': 'Blocked',
          'FAQ’s': 'FAQ’s',
          'questions': 'Questions',
          'change': 'Change',
          'remove': 'Remove',
          'username': 'Username',
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'personalInformation': 'Personal Information',
          'emailAddress': 'Email Address',
          'enterEmailAddress': 'Enter email address',
          'phoneNumber': 'Phone Number',
          'address': 'Address',
          'enterAddress': 'Enter Address',
          'saveInformation': 'Save Information',
          'typeAMessage': 'Type a message',
          'frequentlyAskedByUsers': 'Frequently asked by users',
          'thisInformationWeBeDisplayedPublicly':
              'This information we’ll be displayed publicly',
          'yes': 'Yes',
          'no': 'No',
          'acceptGroup': 'Accept Group',
          'rejectGroup': 'Reject Group',
          'groupRequestAccepted': 'Group request accepted.',
          'groupRequestRejected': 'Group request rejected.',
          'logoutSuccessMessage': 'You are logout successfully.',
          'takeAPhoto': 'Take a photo',
          'selectFromGallery': 'Select from gallery',

          // Confirmation messages
          'logoutConformationMessage': 'Are you sure, you want to logout?',
          'acceptGroupConfirmation':
              'Are you sure, you want accept this group request?',
          'rejectGroupConfirmation':
              'Are you sure, you want reject this group request?',

          // Permissions
          'permissionError': 'Permission error',
          'cameraPermissionErrorMessage':
              'Please allow camera permission from settings.',
          'photoPermissionErrorMessage':
              'Please allow photo permission from settings.',

          'databaseIsOptimized': 'Database is optimized',
          "databaseMigrationBody": "Please wait. This may take a moment.",
          "initAppError": "An error occurred while init the app",
          "noDatabaseEncryption":
              "Database encryption is not supported on this platform",
          "saveFile": "Save file",
          "fileHasBeenSavedAt": "File has been saved at {path}",
          "reportErrorDescription":
              "😭 Oh no. Something went wrong. If you want, you can report this bug to the developers.",
          "copy": "Copy",
          "wrongPinEntered":
              "Wrong pin entered! Try again in {seconds} seconds...",
          "invalidInput": "Invalid input!",
          "pleaseEnterYourPin": "Please enter your pin",
          "pleaseEnterYourPassword": "Please enter your password",
          "serverRequiresEmail":
              "This server needs to validate your email address for registration.",
          "weSentYouAnEmail": "We sent you an email",
          "pleaseClickOnLink":
              "Please click on the link in the email and then proceed.",
          "iHaveClickedOnLink": "I have clicked on the link",
          "pleaseFollowInstructionsOnWeb":
              "Please follow the instructions on the website and tap on next.",
          "passwordIsWrong": "Your entered password is wrong",
          "noPermission": "No permission",
          "tooManyRequestsWarning":
              "Too many requests. Please try again later!",
          "wrongRecoveryKey":
              "Sorry... this does not seem to be the correct recovery key.",
          "fileIsTooBigForServer":
              "The server reports that the file is too large to be sent.",
          "badServerVersionsException":
              "The homeserver supports the Spec versions:\n{serverVersions}\nBut this app supports only {supportedVersions}",
          "badServerLoginTypesException":
              "The homeserver supports the login types:\n{serverVersions}\nBut this app supports only:\n{supportedVersions}",
          "noConnectionToTheServer": "No connection to the server",
          "oopsSomethingWentWrong": "Oops, something went wrong…",
          "callingPermissions": "Calling permissions",
          "otherCallingPermissions":
              "Microphone, camera and other talktsy permissions",
          "callingAccount": "Calling account",
          "callingAccountDetails":
              "Allows talktsy to use the native android dialer app.",
          "appearOnTop": "Appear on top",
          "appearOnTopDetails":
              "Allows the app to appear on top (not needed if you already have talktsy setup as a calling account)",
          "loadingPleaseWait": "Loading… Please wait.",
          "oneClientLoggedOut": "One of your clients has been logged out",
          "dehydrate": "Export session and wipe device",
          "dehydrateWarning":
              "This action cannot be undone. Ensure you safely store the backup file.",

          "invitePrivateChat": "📨 Invite private chat",
          "inviteGroupChat": "📨 Invite group chat",
          "youHaveBeenBannedFromThisChat":
              "You have been banned from this chat",
          "forward": "Forward",
          "forwardMessageTo": "Forward message to {roomName}?",
          "sendFile": "Send file",
          "sendImage": "Send image",
          "sendAudio": "Send audio",
          "sendVideo": "Send video",
          "sendOriginal": "Send original",
          "countFiles": "{count} files",
          "goToSpace": "Go to space: {space}",
          "muteChat": "Mute chat",
          "unmuteChat": "Unmute chat",
          "markAsRead": "Mark as read",
          "markAsUnread": "Mark as unread",
          "unpin": "Unpin",
          "pin": "Pin",
          "leave": "Leave",
          "addToSpace": "Add to space",
          "areYouSure": "Are you sure?",
          "archiveRoomDescription":
              "The chat will be moved to the archive. Other users will be able to see that you have left the chat.",
          "space": "Space",
          "noRoomsFound": "No rooms found…",
          "copiedToClipboard": "Copied to clipboard",
          "inviteText":
              "{username} invited you to talktsy.\n1. Visit talktsy.im and install the app \n2. Sign up or sign in \n3. Open the invite link: \n {link}",
          "countParticipants": "{count} participants",
          "joinSpace": "Join space",
          "joinRoom": "Join room",
          "knock": "Knock",
          "addChatOrSubSpace": "Add chat or sub space",
          "createNewSpace": "New space",
          "createGroup": "Create group",
          "spaceName": "Space name",
          "groupName": "Group name",
          "pleaseChoose": "Please choose",
          "chatDescription": "Chat description",
          "nothingFound": "Nothing found...",
          "countChatsAndCountParticipants": "{chats} chats and {participants} participants",
          "joinedChats": "Joined chats",
          "isTyping": "is typing…",
          "userIsTyping": "{username} is typing…",
          "userAndUserAreTyping": "{username} and {username2} are typing…",
          "userAndOthersAreTyping": "{username} and {count} others are typing…",
          "emptyChat": "Empty chat",
          "dateAndTimeOfDay": "{date}, {timeOfDay}",
          "discover": "Discover",
          "noMoreChatsFound": "No more chats found...",
          "loadMore": "Load more…",
        },
      };
}
