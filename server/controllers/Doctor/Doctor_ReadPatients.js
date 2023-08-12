const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Patient = require("../../models/Patient");
const Doctor = require("../../models/Doctor");
const key = "mostafa_eman_eman_menna_hasnaa";
const sendResponse = require("../../utils/sendResonse");


const ReadPatients = async (req, res) => {
  try {
    
    const doctor = await Doctor.findOne({ email: req.body.email });
    const patient = await Patient.find();

    let data = [];
    for(i = 0; i < patient.length; i++){
      data_list = JSON.parse(patient[i].appointments);
      patient[i].appointments = data_list;
      console.log(data_list[1]);

      if(data_list[1] == doctor._id){
        data.push([patient[i],data_list[0]]);
      }
    }
    return sendResponse(res, 200, "Patients", data);    
  } catch (err) {
    console.log(err);
    return sendResponse(res, 500, "Internal Server Error");
  }
};

module.exports = { ReadPatients };