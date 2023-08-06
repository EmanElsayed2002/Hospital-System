const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Patient = require("../../models/Patient");
const key = "mostafa_eman_eman_menna_hasnaa";
const sendResponse = require("../../utils/sendResonse");
const checkFile = require("../../validator/Patient/Login");

const Login = async (req, res) => {
  try {
    // validate the data
    const error = await checkFile(req.body);
    if (error[0] !== "valid") {
      // we will receive a list of the message and the status code
      return sendResponse(res, error[1], error[0]);
    }

    // generate token
    var patient = await Patient.findOne({ email: req.body.email });
    const token = jwt.sign({ _id: patient._id }, key);
    const result = { token: token, patient: patient };

    // send the response
    return sendResponse(res, 200, "Login as patient", result);
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};

module.exports = { Login };
