 function downloadtable() {

        var node = document.getElementById('container');

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

    function downloadtable2() {

        var node = document.getElementById('container1');

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

