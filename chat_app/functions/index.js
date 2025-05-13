const functions = require('firebase-functions/v2'); // v2 for proper method
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore.onDocumentCreated('chat/{messageId}', (event) => {
  const snapshot = event.data;

  if (!snapshot) {
    console.log("No data found");
    return null;
  }

  const message = snapshot.data();

  return admin.messaging().send({
    notification: {
      title: message.userName || "New Message",
      body: message.text || "",
    },
    data: {
      click_action: 'FLUTTER_NOTIFICATION_CLICK',
    },
    topic: 'chat',
  });
});
