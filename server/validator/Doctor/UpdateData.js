const Joi = require( "joi" );
const Doctor = require( "../../models/Doctor" );

const Update_Validator = Joi.object( {
  fullname: Joi.string().min( 6 ).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min( 6 ).required(),
  Specialization: Joi.string().required(),
  gender: Joi.string().required(),
  phone: Joi.string().required(),
  photo: Joi.string().required(),
  address: Joi.string().required(),
  aboutDoctor: Joi.string().required(),
  Price: Joi.number().required(),
  token: Joi.string().required(),
  age: Joi.number().required(),
  id: Joi.string().required(),
  auth: Joi.string().required(),
} );

test = async function ( data )
{
  const { error } = Update_Validator.validate( data );

  if ( error )
  {
    console.log( error.details[ 0 ].message );
    return [ error.details[ 0 ].message, 400 ];
  } else
  {
    return [ "valid", 200 ];
  }
};

module.exports = test;
