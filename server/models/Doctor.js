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
    // we will receive a list that any element is a pair the hour and still available or not
    // example: [["10:00", free ], ["11:00", booked], ["12:00" , free]]
    availableHours: {
        type: Array,
        default: []
    },

}, { timestamps: true });

const Doctor = mongoose.model('Doctor', DoctorSchema);
module.exports = Doctor;
