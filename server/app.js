// عايزين نضيف اجراءات الحماية للشات ف الاخر
const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const port = 3000;

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
//     fullname: 'sasa2727',
//     email: 'sasa2727@gmail.com',
//     password: '1223456789',
//     phone: '01225435099',

// };

// axios.post('http://localhost:3000/admin/signup', data)
//     .then(response => {
//     console.log(response.data);
//     })
//     .catch(error => {
//     console.log(error.response);
//     });
