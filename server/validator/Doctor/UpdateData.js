const Joi = require("joi");
const Admin = require("../../models/Doctor");

const Update_Validator = Joi.object({
  fullname: Joi.string().min(6).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required(),
  confirmPassword: Joi.string().min(6).required().valid(Joi.ref("password")),
});

test = async function (data) {
  const { error } = Update_Validator.validate(data);

  if (error) {
    return [error.details[0].message, 400];
  } else {
    return ["valid", 200];
  }
};

module.exports = test;
