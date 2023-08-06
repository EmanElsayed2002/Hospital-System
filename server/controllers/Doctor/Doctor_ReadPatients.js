const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Doctor = require("../../models/Admin");
const key = "mostafa_eman_eman_menna_hasnaa";
const sendResponse = require("../../utils/sendResonse");

const ReadPatients = async (req, res) => {
  try {
    const doctor = Doctor.findOne({ email: req.body.email });
    if (!doctor) {
      return sendResponse(res, 401, "Doctor is not exist");
    }
    doctor.appointments = req.body.appointments;
    let patients = [];
    for (var i = 0; i < doctor.appointments.length; i++) {
      if (doctor.appointments[i][1] == "booked") {
        patients.push(doctor.appointments[i][2]);
      }
    }
    return sendResponse(res, 200, "Patients", patients);    
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};

module.exports = { ReadPatients };