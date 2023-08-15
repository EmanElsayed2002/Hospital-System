const Joi = require( "joi" );
const Admin = require( "../../models/Admin" );

const Edit_Validator = Joi.object( {
  fullname: Joi.string().min( 6 ).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min( 6 ).required(),
  // confirmPassword: Joi.string().min( 6 ).required().valid( Joi.ref( "password" ) ),
  gender: Joi.string().required(),
  phone: Joi.string().min( 10 ).required(),
  photo: Joi.string().required(),
  age: Joi.number().required(),
  token: Joi.string().required(),
  id: Joi.string().required(),
  auth: Joi.string().required(),
} );

test = async function ( data )
{
  const { error } = Edit_Validator.validate( data );
  console.log( error );
  if ( error )
  {
    return [ error.details[ 0 ].message, 400 ];
  } else
  {
    return [ "valid", 200 ];
  }
};

module.exports = test;
