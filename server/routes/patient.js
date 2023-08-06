const express = require("express");
const router = express.Router();

const PatientLogin = require("../controllers/Patient/Patient_Login");
const PatientSignUp = require("../controllers/Patient/Patient_SignUp");


router.post("/signup", PatientSignUp.SignUp);
router.post("/login", PatientLogin.Login);

module.exports = router;
