require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const nodemailer = require("nodemailer");

const app = express();
app.use(cors());
app.use(bodyParser.json());

let otpStore = {};

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS,
    },
});
app.get("/", (req, res) => {
    res.send("Server is running!");
});


app.post("/send-otp", (req, res) => {
    const { email } = req.body;
    if (!email) return res.status(400).json({ success: false, message: "Email required" });

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    otpStore[email] = otp;

    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: "Your OTP Code",
        text: `Your OTP code is: ${otp}`,
    };

    transporter.sendMail(mailOptions, (error) => {
        if (error) return res.status(500).json({ success: false, message: "Error sending OTP" });
        res.json({ success: true, message: "OTP sent" });
    });
});

app.post("/verify-otp", (req, res) => {
    const { email, otp } = req.body;
    if (otpStore[email] === otp) {
        delete otpStore[email];
        return res.json({ success: true, message: "OTP verified" });
    }
    res.status(400).json({ success: false, message: "Invalid OTP" });
});

app.listen(5000, () => console.log("Server running on port 5001"));

