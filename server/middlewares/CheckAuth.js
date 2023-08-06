const jwt = require("jsonwebtoken");
const sendResponse = require("../utils/sendResponse");

const key = "mostafa_eman_eman_menna_hasnaa";
module.exports = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(token, key);
    req.user = decoded;
  } catch (err) {
    return sendResponse(res, 401, "Authentication is failed");
  }
  next();
};
