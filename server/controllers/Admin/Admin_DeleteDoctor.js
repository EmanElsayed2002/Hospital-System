const Doctor = require("../../models/Admin");
const sendResponse = require("../../utils/sendResonse");

const DeleteDoctor = async (req, res) => {
  try {
    const founded = Doctor.findOne({ email: req.body.email });
    if (!founded) {
      return sendResponse(res, 404, "Doctor not found");
    }
    await founded.remove();
    return sendResponse(res, 200, "Doctor has been deleted successfully");
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};

module.exports = {DeleteDoctor};