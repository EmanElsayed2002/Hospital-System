const sendResponse = (res, statusCode, message, result = null) => {
  console.log("sendResponse");
  return res.status(statusCode).json({
    statusCode: statusCode,
    message: message,
    result: result,
  });
};
module.exports = sendResponse;
