/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Cloud Function code to send an OTP email
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendOTP = functions.https.onCall(async (data, context) => {
  const email = data.email;

  // Generate OTP code
  const otpCode = generateOTP();

  // Send OTP code via Firebase Authentication
  try {
    await admin.auth().generatePasswordResetLink(email);
    console.log(`OTP sent to ${email}`);
    return { success: true };
  } catch (error) {
    console.error(`Error sending OTP to ${email}: ${error}`);
    throw new functions.https.HttpsError('internal', 'Error sending OTP');
  }
});

function generateOTP() {
  // Implement OTP generation logic (e.g., generate a random 6-digit code)
}

