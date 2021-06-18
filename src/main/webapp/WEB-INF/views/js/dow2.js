 function downloadtable3() {

        var node = document.getElementById('container2');

        domtoimage.toPng(node)
            .then(function (dataUrl) {
                var img = new Image();
                img.src = dataUrl;
                downloadURI(dataUrl, "records.png")
            })
            .catch(function (error) {
                console.error('oops, something went wrong!', error);
            });

    }

    function downloadtable4() {

        var node = document.getElementById('container4');

        domtoimage.toPng(node)
            .then(function (dataUrl) {
                var img = new Image();
                img.src = dataUrl;
                downloadURI(dataUrl, "records.png")
            })
            .catch(function (error) {
                console.error('oops, something went wrong!', error);
            });

    }
    
    function downloadtable5() {

        var node = document.getElementById('container5');

        domtoimage.toPng(node)
            .then(function (dataUrl) {
                var img = new Image();
                img.src = dataUrl;
                downloadURI(dataUrl, "records.png")
            })
            .catch(function (error) {
                console.error('oops, something went wrong!', error);
            });

    }
    



    function downloadURI(uri, name) {
        var link = document.createElement("a");
        link.download = name;
        link.href = uri;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        delete link;
    }

