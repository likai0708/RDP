function getConfigProp(name) {
    var config={
        rdpserver:"../../"
    };
    return config[name];
}

function reqServerController(path, dataparm, callback) {
    var rdpserver = getConfigProp("rdpserver");
    $.ajax({
        url: rdpserver + path,
        type: 'post',
        data: JSON.stringify(dataparm),
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        success: function (data) {
            if (callback && typeof (callback) == "function") {
                callback.call(this, data);
            }
        },
        error: function (e) {
            if (callback && typeof (callback) == "function") {
                callback.call(this, e);
            }
        }
    });
}

function reqServerControllerParms(path, dataparm, callback) {
    var rdpserver = getConfigProp("rdpserver");
    $.ajax({
        url: rdpserver + path,
        type: 'post',
        data: dataparm,
        success: function (data) {
            if (callback && typeof (callback) == "function") {
                callback.call(this, data);
            }
        },
        error: function (e) {
            if (callback && typeof (callback) == "function") {
                callback.call(this, e);
            }
        }
    });
}

function tableValsToNodeData(tableData) {
    var zNodes = [];
    var columns = tableData.columns;
    var values = tableData.rows;
    var len = columns.length;
    $.each(values, function (i, node) {
        var temp = {};
        for (var j = 0; j < len; j++) {
            temp[columns[j].columnName] = node[j];
        }
        zNodes.push(temp);
    });
    return zNodes;
}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg); //search,查询？后面的参数，并匹配正则
    if (r != null) return unescape(r[2]);
    return null;
}