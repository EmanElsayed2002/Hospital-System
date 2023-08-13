// عايزين نضيف اجراءات الحماية للشات ف الاخر
const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const port = process.env.PORT || 3000;

const morgan = require("morgan");
app.use(morgan("dev"));

const cors = require("cors");
app.use(cors());

require("./connection/mongoose");

const bodyParser = require("body-parser");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

const Uploadd = require("express-fileupload");
app.use(Uploadd());

const Patient = require("./routes/patient");
const Doctor = require("./routes/doctor");
const Admin = require("./routes/Admin");

app.use("/patient", Patient);
app.use("/doctor", Doctor);
app.use("/admin", Admin);

// i want the server to listen to the port 3000
server.listen(port, () => {
  console.log(`listening on *:${port}`);
});

const axios = require("axios");
// const { Upload } = require("./controllers/Admin/Admin_UploadingPhoto");

// const data4 = {
//       email: 'sasasasa2321@gmail.com',
//       password: '123456789'
//   };

//   axios.post('http://localhost:3000/admin/login', data4)
//       .then(response => {
//       console.log(response.data);
//       }
//       )
//       .catch(error => {
//       console.log(error.response);
//       }
//       );

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
//     fullname: 'Mostafa Mahmoud',
//     email: 'mostafa19500mahmoud@gmail.com',
//     password: '0123456789',
//     phone: '01225435099',
//     age: '28',
//     gender: 'male',
// };

// axios.post('http://localhost:3000/admin/signup', data)
//     .then(response => {
//     console.log(response.data);
//     })
//     .catch(error => {
//     console.log(error.response);
//     });

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
