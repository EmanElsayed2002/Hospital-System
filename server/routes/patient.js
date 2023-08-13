const express = require("express");
const router = express.Router();

const PatientLogin = require("../controllers/Patient/Patient_Login");
const PatientSignUp = require("../controllers/Patient/Patient_SignUp");
const PopularDoctors = require("../controllers/Patient/Popular_Doctors");

router.post("/signup", PatientSignUp.SignUp);
router.post("/login", PatientLogin.Login);
router.get("/populardoctor", PopularDoctors.PopularDoctors);

module.exports = router;
