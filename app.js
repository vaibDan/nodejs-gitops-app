const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
    res.send('Hello, GitOps World! This Pipeline is fully automated Version 3.0.0. This version will be reverted in the next commit.');
});

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});