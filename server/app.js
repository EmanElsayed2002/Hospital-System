// عايزين نضيف اجراءات الحماية للشات ف الاخر
const express = require( "express" );
const app = express();
const verificationCodes = {}; // Create an object to store verification codes

const http = require( "http" );
const nodemailer = require( 'nodemailer' );
const server = http.createServer( app );
const { Server } = require( "socket.io" );
const io = new Server( server );
const port = process.env.PORT || 3000;

const morgan = require( "morgan" );
app.use( morgan( "dev" ) );

const cors = require( "cors" );
app.use( cors() );

require( "./connection/mongoose" );

const bodyParser = require( "body-parser" );
app.use( bodyParser.json( { limit: '10mb' } ) );


app.use( bodyParser.urlencoded( { limit: '10mb', extended: true } ) );
const Uploadd = require( "express-fileupload" );
app.use( Uploadd() );

const Patient = require( "./routes/patient" );
const Doctor = require( "./routes/doctor" );
const Admin = require( "./routes/Admin" );

app.use( "/patient", Patient );
app.use( "/doctor", Doctor );
app.use( "/admin", Admin );


const transporter = nodemailer.createTransport( {
  service: 'gmail',
  auth: {
    user: 'emy2192002@gmail.com',
    pass: 'stmtkalnfwoidyim',
  },
} );
function generateVerificationCode ()
{

  const length = 6;
  const characters = '0123456789';

  let code = '';
  for ( let i = 0; i < length; i++ )
  {
    const randomIndex = Math.floor( Math.random() * characters.length );
    code += characters[ randomIndex ];
  }

  return code;
}
app.post( '/send-verification-email', async ( req, res ) =>
{
  const { email } = req.body;

  const verificationCode = generateVerificationCode();
  verificationCodes[ email ] = verificationCode; // Store the code in-memory
  console.log( email );
  const mailOptions = {
    from: 'emy2192002@gmail.com',
    to: email,
    subject: 'Email Verification Code',
    text: `Your verification code is: ${ verificationCode }`,
  };

  try
  {
    await transporter.sendMail( mailOptions );
    res.status( 200 ).json( { message: 'Verification email sent' } );
  } catch ( error )
  {
    console.error( 'Error sending verification email:', error );
    res.status( 500 ).json( { message: 'Error sending verification email' } );
  }
} );

// Add this route after your other routes

app.post( '/verify-code', async ( req, res ) =>
{
  const { email, code } = req.body;

  try
  {
    if ( !verificationCodes[ email ] )
    {
      return res.status( 400 ).json( { message: 'Verification code not sent', success: false } );
    }

    if ( verificationCodes[ email ] === code )
    {
      // Remove the used verification code from in-memory storage
      delete verificationCodes[ email ];

      res.json( { message: 'Email verified successfully', success: true } );
    } else
    {
      res.status( 400 ).json( { message: 'Invalid verification code', success: false } );
    }
  } catch ( error )
  {
    console.error( 'Error verifying code:', error );
    res.status( 500 ).json( { message: 'Error verifying code', success: false } );
  }
} );







server.listen( port, () =>
{
  console.log( `listening on *:${ port }` );
} );

const axios = require( "axios" );
// const { Upload } = require("./controllers/Admin/Admin_UploadingPhoto");

// const data4 = {
//   email: 'sasasasa2321@gmail.com',
//   password: '123456789'
// };

// axios.post( 'http://localhost:3000/admin/login', data4 )
//   .then( response =>
//   {
//     console.log( response.data );
//   }
//   )
//   .catch( error =>
//   {
//     console.log( error.response );
//   }
//   );

// const formData = new FormData();
// photoFile = 'C:/Users/ahmed zain/Desktop/k.png'
// formData.append('photo', photoFile); // photoFile is a File object representing the photo

// axios.post('http://localhost:3000/admin/upload', formData, {
//   headers: {
//     'Content-Type': 'multipart/form-data'
//   }
// })
// .then(res => {
//   console.log(res);
// })
// .catch(err => {
//   console.log(err);
// });

// app.get("/", (req, res) => {
//   res.sendFile(__dirname + "/index.html");
// });

// io.on("connection", (socket) => {
//   socket.on("chat message", (msg) => {
//     io.emit("chat message", msg);
//   });
// });

// // 1- Create a new admin
// const data = {
//   fullname: 'Eman Elsayed',
//   email: 'emoelsayed2192002@gmail.com',
//   password: '0123456789',
//   phone: '01006205467',
//   age: '21',
//   gender: 'female',
// };

// axios.post( 'http://192.168.1.7:3000/admin/signup', data )
//   .then( response =>
//   {
//     console.log( response.data );
//   } )
//   .catch( error =>
//   {
//     console.log( error.response );
//   } );

// login as an admin
// const data = {
//   email: "mostafa19500mahmoud@gmail.com",
//   password: "0123456789",
// };

// axios
//   .post("http://localhost:3000/admin/login", data)
//   .then((response) => {
//     console.log(response.data);
//   })
//   .catch((error) => {
//     console.log(error.response);
//   });

/*
listening on *:3000
Connected with mongoDB
0123456789
POST /admin/login 200 135.006 ms - 537
{
  statusCode: 200,
  message: 'Login as admin',
  result: {
    token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQzZTM0YTQ4ZTE2M2QxOThmMjQ4ZmUiLCJpYXQiOjE2OTE2NjYzMTB9.KQBmWLcP767Z0KYPmvcF9FAnM-b1h6hVxQ9VX90D5u0',
    admin: {
      _id: '64d3e34a48e163d198f248fe',
      fullname: 'Mostafa Mahmoud',
      email: 'mostafa19500mahmoud@gmail.com',
      password: '$2a$10$F0DqfwenofKdHpuDpeG6PelVefqzkArYL1Ow9MJi9DsjVZPZiVM3G',
      phone: '01225435099',
      age: '28',
      gender: 'male',
      createdAt: '2023-08-09T19:04:42.888Z',
      updatedAt: '2023-08-09T19:04:42.888Z',
      __v: 0
    }
  }
}
*/



// const data = {
//   email: "sasa19500mahmoud@gmail.com",
//   password: "0123456789",
//   appointments: ['03/08/2002 T00:04' , 'free']
// };

// axios
//   .post("http://localhost:3000/doctor/createoppointment", data)
//   .then((response) => {
//     console.log(response.data);
//   })
//   .catch((error) => {
//     console.log(error.response);
//   });

// // get all patients

//  const data = {
//     email: "sasa19500mahmoud@gmail.com",
//  };

//   axios
//   .post("http://localhost:3000/doctor/readpatients", data)
//   .then((response) => {
//     console.log(response.data);
//   }
//   )
//   .catch((error) => {
//     console.log(error.response);
//   }
//   );
