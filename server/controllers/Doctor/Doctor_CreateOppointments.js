const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Doctor = require("../../models/Doctor");
const key = "mostafa_eman_eman_menna_hasnaa";
const sendResponse = require("../../utils/sendResonse");
const CreateOppointments = async (req, res) => {
  try {
    const doctor = await Doctor.findOne({ email: req.body.email });
    if (!doctor) {
      return sendResponse(res, 401, "Doctor does not exist");
    }

    const update = { $push: { appointments: req.body.appointments } };
    const updatedDoctor = await Doctor.findByIdAndUpdate(doctor._id, update, {
      new: true,
    });

    if (!updatedDoctor) {
      return sendResponse(res, 500, "Internal Server Error");
    }

    return sendResponse(res, 200, "Appointment added successfully");
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};
module.exports = { CreateOppointments };
