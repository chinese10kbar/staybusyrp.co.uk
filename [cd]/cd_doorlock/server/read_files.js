// using the superior language
//^^^ lies - lua > js :D
const fs = require('fs');
let resourceName = GetCurrentResourceName();

fs.readdir(GetResourcePath(resourceName)+'/sounds/', {withFileTypes: true}, (err, files) => {
    if(err) throw err;

    let fileNames = [];

    files.forEach(file => {

        if(!file.name.startsWith("_"))
            fileNames.push(file.name);
    });
    emit("cd_doorlock:GetSoundFiles", fileNames);

    return;
});

