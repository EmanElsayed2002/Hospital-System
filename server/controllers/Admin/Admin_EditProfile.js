const bcrypt = require( "bcryptjs" );
const jwt = require( "jsonwebtoken" );
const Admin = require( "../../models/Admin" );
const key = "mostafa_eman_eman_menna_hasnaa"; // Replace with your actual key
const sendResponse = require( "../../utils/sendResonse" ); // Make sure you have this utility function
const checkFile = require( "../../validator/Admin/EditProfile" ); // Assuming this is your validator function

const Edit = async ( req, res ) =>
{
  try
  {
    const error = await checkFile( req.body );
    if ( error[ 0 ] !== "valid" )
    {
      return sendResponse( res, error[ 1 ], error[ 0 ] );
    }

    const {
      fullname,
      email,
      password,
      photo,
      phone,
      age,
      gender, // Make sure to include 'gender' here if needed
      token, // Include 'token' if needed
      id, // Include 'id' if needed
      auth, // Include 'auth' if needed
    } = req.body;

    let founded = await Admin.findOne( { email: email } );

    if ( founded )
    {
      founded.fullname = fullname;
      founded.email = email;
      founded.password = password; // Hash the password before saving (if needed)
      founded.photo = photo;
      founded.phone = phone;
      founded.age = age;
      founded.gender = gender;
      founded.token = token;
      founded.id = id;
      founded.auth = auth;
      // Update other properties as needed
      await founded.save();
      return sendResponse( res, 200, "Profile has been updated successfully" );
    } else
    {
      return sendResponse( res, 404, "Admin not found" );
    }
  } catch ( err )
  {
    console.log( err );
    return sendResponse( res, 500, "Internal Server Error" );
  }
};

module.exports = { Edit };
