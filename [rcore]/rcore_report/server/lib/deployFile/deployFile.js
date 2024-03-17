const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

const path = GetResourcePath(GetCurrentResourceName());

on('rcore_report:sendDiscordFile', (filename, title, webhook) => {
    const form = new FormData();
    const fullPath = path + filename
    const file = fs.readFileSync(fullPath)
    const escapedTitle = title.replaceAll('\n', '\\n')
    form.append('payload_json', `{"content": "${escapedTitle}"}`);
    form.append('file1', file, fullPath);

    axios.post(
        webhook,
        form,
        {
            headers: {
                ...form.getHeaders()
            }
        }
    ).catch((error) => console.log(error))
});