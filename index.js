const express = require("express");
const process = require('process');
const app = express();
const PORT = 3000;

app.get('/', (req, res)=>{
    res.status(200);
    res.setHeader("Content-Type", "application/json");
    res.send(JSON.stringify({message: "Welcome to root URL of Server"}));
});

app.get('/health', (req, res)=>{
    res.status(200);
    res.setHeader("Content-Type", "application/json");
    res.send("OK");
});

app.get('/pid', (req, res)=>{
    res.status(200);
    res.setHeader("Content-Type", "application/json");
    res.send(JSON.stringify({version: 2, pid: process.pid}));
});

app.listen(PORT, (error) => {
    if(!error)
        console.log("Server is Successfully Running, and App is listening on port " + PORT)
    else 
        console.error("Error occurred, server can't start", error);
});