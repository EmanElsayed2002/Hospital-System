const Doctor = require("../../models/Doctor");
const sendResponse = require("../../utils/sendResonse");

const CreateNewDoctor = async (req, res) => {
  try {
    const doctor = new Doctor(req.body);
    await doctor.save();
    return sendResponse(res, 200, "Doctor has been created successfully", doctor);
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};

module.exports = { CreateNewDoctor };

