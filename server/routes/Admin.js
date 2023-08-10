const express = require("express");
const router = express.Router();



const AdminLogin = require("../controllers/Admin/Admin_Login");
const AdminSignUp = require("../controllers/Admin/Admin_SignUp");
// const AdminUploadingPhoto = require("../controllers/Admin/Admin_UploadingPhoto");
const AdminEditProfile = require("../controllers/Admin/Admin_EditProfile");
const AdminChangePassword = require("../controllers/Admin/Admin_ChangePassword");
const AdminCreateNewDoctor = require("../controllers/Admin/Admin_CreateNewDoctor");
const AdminDeleteDoctors = require("../controllers/Admin/Admin_DeleteDoctor");
const AdminReadDoctorsDate = require("../controllers/Admin/Admin_ReadDoctorsData");
const AdminUpdateDoctor = require("../controllers/Admin/Admin_UpdateDoctor");

// // import middleware
const adminCheck  = require("../middlewares/CheckAdmin");
const CheckAuth  = require("../middlewares/CheckAuth");

// import the validators
router.post("/signup", AdminSignUp.SignUp); // Done for backend
router.post("/login", AdminLogin.Login); // Done for backend
// router.post("/upload", AdminUploadingPhoto.Upload);
router.post("/edit",CheckAuth , adminCheck , AdminEditProfile.Edit); // Done for backend
router.post("/changepassword",CheckAuth , adminCheck , AdminChangePassword.ChangePass); // Done for backend
router.post("/createnewdoctor",CheckAuth , adminCheck , AdminCreateNewDoctor.CreateNewDoctor); // Done for backend
router.post("/deletedoctor", CheckAuth , adminCheck , AdminDeleteDoctors.DeleteDoctor); // Done for backend
router.get("/readdoctorsdata", CheckAuth , adminCheck , AdminReadDoctorsDate.ReadDoctorsData); // Done for backend
router.post("/updatedoctor", CheckAuth , adminCheck , AdminUpdateDoctor.UpdateDoctor); // Done for backend

module.exports = router;
