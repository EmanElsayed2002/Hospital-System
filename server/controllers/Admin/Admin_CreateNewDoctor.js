const Doctor = require("../../models/Admin");
const sendResponse = require("../../utils/sendResonse");

const CreateNewDoctor = async (req, res) => {
    try{
        // create new doctor
        const doctor = new Doctor(req.body);
        await doctor.save();
        return sendResponse(res, 200, "Doctor has been created successfully");
    }
    catch(err){
        console.log(err);
        return sendResponse(res, 500, "Internal Server Error");
    }
}

module.exports = { CreateNewDoctor };