const mongoose = require('mongoose');

const DoctorSchema = new mongoose.Schema({
    fullname: {
        type: String,
        required: [true, "Fullname is Mandatory"],
        minlength: 6,
        trim: true
    },
    email: {
        type: String,
        required: [true, "Email is Mandatory"],
        unique: true,
        trim: true,
        match: /^\w+([-+.]\w+)*@((yahoo|gmail|outlook)\.com)$/
    },
    password: {
        type: String,
        required: [true, "Password is Required"],
        minlength: 6,
        trim: true
    },
    Specialization: {
        type: String,
        required: [true, "Specialization is Mandatory"],
        trim: true
    },
    gender: {
        type: String,
        required : [true , "gender is required"],
    },
    phone: {
        type: String,
        required: [true, "Phone is Mandatory"],
        trim: true,
        match: /^01[0125][0-9]{8}$/
    },
    photo: {
        type: String,
        required: [true, "Photo is Mandatory"],
    },
    address: {
        type: String,
        required: [true, "Address is Mandatory"],
        trim: true
    },
    aboutDoctor : {
        type: String,
        required: [true, "About Doctor is Mandatory"],
        trim: true
    },
    availableHours: {
        type: Array,
        default: []
    },

}, { timestamps: true });

const Doctor = mongoose.model('Doctor', DoctorSchema);
module.exports = Doctor;
