const bcrypt = require( 'bcryptjs' );
const Admin = require( '../../models/Admin' );
const sendResponse = require( "../../utils/sendResonse" );

const changePassword = async ( req, res ) =>
{
  // console.log( req.body )
  try
  {
    const { currentPassword, newPassword, confirmPassword, id, token } = req.body;
    console.log( id );
    // Find the admin by ID
    const admin = await Admin.findById( id );

    if ( !admin )
    {
      console.log( `Admin with ID ${ id } not found` );
      return sendResponse( res, 404, "Admin not found" );
    }


    // Check if the current password matches
    const passwordMatch = await bcrypt.compare( currentPassword, admin.password );

    if ( !passwordMatch )
    {
      return sendResponse( res, 400, 'Current password is incorrect' );
    }
    if ( newPassword !== confirmPassword )
    {
      return sendResponse( res, 400, 'New password and confirm password do not match' );
    }
    // Hash the new password
    const hashedNewPassword = await bcrypt.hash( newPassword, 10 );

    // Update the admin's password
    admin.password = hashedNewPassword;
    await admin.save();

    return sendResponse( res, 200, 'Password changed successfully' );
  } catch ( error )
  {
    console.error( error );
    return sendResponse( res, 500, 'Internal Server Error' );
  }
};

module.exports = { changePassword };
