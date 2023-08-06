const express = require("express");
const router = express.Router();

const AdminLogin = require("../controllers/Admin/Admin_Login");
const AdminSignUp = require("../controllers/Admin/Admin_SignUp");
const AdminUploadingPhoto = require("../controllers/Admin/Admin_UploadingPhoto");
const AdminEditProfile = require("../controllers/Admin/Admin_EditProfile");
const AdminChangePassword = require("../controllers/Admin/Admin_ChangePassword");
const AdminCreateNewDoctor = require("../controllers/Admin/Admin_CreateNewDoctor");
const AdminDeleteDoctors = require("../controllers/Admin/Admin_DeleteDoctor");
const AdminReadDoctorsDate = require("../controllers/Admin/Admin_ReadDoctorsData");
const AdminUpdateDoctor = require("../controllers/Admin/Admin_UpdateDoctor");

// // import middleware
// const { CheckAdmin } = require("../middleware/CheckAdmin");
// const { CheckAuth } = require("../middleware/CheckAuth");

// import the validators
router.post("/signup", AdminSignUp.SignUp);
router.post("/login", AdminLogin.Login);
router.post("/upload", AdminUploadingPhoto.Upload);
router.post("/edit", AdminEditProfile.Edit);
router.post("/changepassword", AdminChangePassword.ChangePass);
router.post("/createnewdoctor", AdminCreateNewDoctor.CreateNewDoctor);
router.post("/deletedoctor", AdminDeleteDoctors.DeleteDoctor);
router.post("/readdoctorsdata", AdminReadDoctorsDate.ReadDoctorsData);
router.post("/updatedoctor", AdminUpdateDoctor.UpdateDoctor);

module.exports = router;
