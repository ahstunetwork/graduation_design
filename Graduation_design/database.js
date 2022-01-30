//test javascript



// real code block
var index = 10;
var current_DB_index;

//default operate database is word_list_order
var operate_db_name = "word_list_order";

function getindex() {
    return index;
}

function setindex(idx) {
    index = idx;
}


// get date_time
function get_date_time() {
    var myDate = new Date(); //获取今天日期
    myDate.setDate(myDate.getDate() - 6);
    console.log("myDate.getDate()" + myDate.getDate())
    console.log("myDate.getDay()" + myDate.getDay())
    console.log("myDate.getFullYear()" + myDate.getFullYear())
    console.log("myDate.getMonth()" + myDate.getMonth())
    // console.log( myDate.getDate() )
    // console.log( myDate.getDate() )
    // console.log( myDate.getDate() )

    var date_arr = [];
    var date_temp;;
    for (var i = 0; i < 7; i++) {
        date_temp = (myDate.getFullYear() + "-" + myDate.getMonth() + 1) + "-" + myDate.getDate();
        date_arr.push(date_temp);
        myDate.setDate(myDate.getDate() + 1);
    }

    for (var i = 0; i < 7; i++) {
        console.log(date_arr[i])
    }

    return date_arr;

}



// get statistic_info to list
// 我是JavaScript大王
function get_all_info_from_statistics_table() {
    var date_time_arr = get_date_time();
    var db = getdatabase();
    var result_set = [];

    var is_success = false;

    for (var i = 0; i < date_time_arr.length; i++) {

            var result_temp = [];

        //    Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss.zzz ddd");
        var str = "SELECT * FROM statistics_info WHERE db_table_name='" + get_operate_db_table_name() + "' AND db_table_time='" + date_time_arr[i] + "';"
        console.log(str);
        db.transaction(function (tx) {
            var result = tx.executeSql(str);
            console.log("数据库里读统计数据:" + result.rows.length)
            if (result.rows.length != 0) {
                console.log(" exec success ");
                is_success = true;
                result_temp.push( result.rows[0].db_table_name)
                result_temp.push( result.rows[0].db_table_time)
                result_temp.push( result.rows[0].db_table_count)

                result_set.push( result_temp )

                console.log( "result_temp= "+result_temp )
            }
            else {
                console.log(" exec success ");
                is_success = true;
                result_temp.push( get_operate_db_table_name() )
                result_temp.push( date_time_arr[i] )
                result_temp.push( 0 )

                result_set.push( result_temp )
            }
        })
    }

    console.log("我是JavaScript大王")
    return result_set;

}


// check database record if exist
function is_db_table_record_exist() {
    var db = getdatabase();
    var result_set;
    var is_success = false;

    //    Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss.zzz ddd");
    var str = "SELECT * FROM statistics_info WHERE db_table_name='" + get_operate_db_table_name() + "' AND db_table_time='" + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + "';"
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log("判断记录是否存在:" + result.rows.length)
        if (result.rows.length != 0) {
            console.log(" exec success ");
            is_success = true;
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
            is_success = false;
        }
    })
    return is_success;
}

function get_statistics_info_from_db() {
    var db = getdatabase();
    var result_set;
    var is_success = false;

    //    Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss.zzz ddd");
    var str = "SELECT * FROM statistics_info WHERE db_table_name='" + get_operate_db_table_name() + "' AND db_table_time='" + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + "';"
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log("数据库里读统计数据:" + result.rows.length)
        if (result.rows.length != 0) {
            console.log(" exec success ");
            is_success = true;
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
            is_success = false;
        }
    })
    return result_set.rows[0].db_table_count;
}



function update_statistics_info() {
    var db = getdatabase();
    var result_set;
    var is_success = is_db_table_record_exist();

    if (is_success === true) {
        // 成功则更新
        var str = "UPDATE statistics_info SET db_table_count = "
            + (get_statistics_info_from_db() + 1)
            + " WHERE db_table_name='"
            + get_operate_db_table_name()
            + "' AND db_table_time='"
            + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + "';";
        console.log(str);
        db.transaction(function (tx) {
            var result = tx.executeSql(str);
            result_set = result;
            console.log("成功则更新:" + result.rows.length)
            if (result.rows.length === 0) {
                console.log(" exec success ");
                is_success = true;
            }
            else {
                result_set = "Unknown";
                console.log(" exec faliure");
                is_success = false;
            }
        })
    }
    else {
        //失败则建立
        var str_else = "INSERT INTO statistics_info VALUES('"
            + get_operate_db_table_name() + "','"
            + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + "',"
            + 0 + ");";
        console.log(str_else);
        db.transaction(function (tx) {
            var result = tx.executeSql(str_else);
            result_set = result;
            console.log("失败则建立:" + result.rows.length)
            if (result.rows.length === 0) {
                console.log(" exec success ");
                is_success = true;
            }
            else {
                result_set = "Unknown";
                console.log(" exec faliure");
                is_success = false;
            }
        })

    }

    return is_success;
}







// set & get get_operate_db_table_name()

function get_operate_db_table_name() {
    var db = getdatabase();
    var result_set;

    var str = "SELECT info_value FROM extra_info WHERE info_key = 'operate_db_table_name';"
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log("读当前数据表名字:" + result.rows.length)
        if (result.rows.length != 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
        }
    })
    return result_set.rows[0].info_value;
}



// set & get set_operate_db_table_name()

function set_operate_db_table_name(db_name) {
    var db = getdatabase();
    var result_set;

    var str = "UPDATE extra_info SET info_value='" + db_name +
        "' WHERE info_key='operate_db_table_name';";
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log(result.rows.length)
        if (result.rows.length === 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
        }
    })

}





// set & get current_db_index
function get_current_DB_index() {
    var db = getdatabase();
    var result_set;

    var str = "SELECT db_table_current_index FROM para_info WHERE db_table_name = '" + get_operate_db_table_name() + "';"
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log(result.rows.length)
        if (result.rows.length != 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
        }
    })
    console.log(result_set.rows[0].db_table_current_index);
    return result_set.rows[0].db_table_current_index;
}

// set & get current_db_index
function set_current_DB_index(idx) {
    var db = getdatabase();
    var result_set;

    var str = "UPDATE para_info SET db_table_current_index=" + idx +
        " WHERE db_table_name='" + get_operate_db_table_name() + "'" +
        ";"
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        result_set = result;
        console.log(result.rows.length)
        if (result.rows.length != 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure");
        }
    })

    console.log("set_current_DB_index scdedule update_statistics_info");
    update_statistics_info()

}




function getdatabase() {
    return LocalStorage.openDatabaseSync("word_list", "1.0", "word_list_database", 100000);
}

function readData(name) {
    var db = getdatabase();
    var res = ""
    var res_index = "";
    var res_word = "";
    var res_soundmark = "";
    var res_meaning = "";

    var result_set;

    db.transaction(function (tx) {
        var result = tx.executeSql("select * from word_list_order where word=?;", [name]);
        if (result.rows.length > 0) {
            res = result
            res_index = result.rows.item(0).word_index
            res_word = result.rows.item(0).word
            res_soundmark = result.rows.item(0).soundmark
            res_meaning = result.rows.item(0).meaning

            result_set = [res_index, res_word, res_soundmark, res_meaning];

            console.log(result_set[2])


        } else {
            result_set = "Unknown";
        }
    })
    return result_set;
}

function insertData(name, value) {
    var res = "";
    if (!db) { return; }
    db.transaction(function (tx) {
        var result = tx.executeSql("INSERT OR REPLACE INTO word_list_order VALUES (?,?);", [name, value]);
        if (result.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    })
    return res
}


function readData_by_index(idx) {
    //debug
    //    console.log("readDate_by_index, The index is : " + idx);


    var db = getdatabase();

    var res = ""
    var res_index = "";
    var res_word = "";
    var res_soundmark = "";
    var res_meaning = "";

    var result_set;

    var sql_str = "select * from " + get_operate_db_table_name() + " where word_index=" + idx + ";"

    console.log(sql_str);
    db.transaction(function (tx) {
        var result = tx.executeSql(sql_str);
        if (result.rows.length > 0) {


            res = result
            res_index = result.rows.item(0).word_index
            res_word = result.rows.item(0).word
            res_soundmark = result.rows.item(0).soundmark
            res_meaning = result.rows.item(0).meaning

            result_set = [res_index, res_word, res_soundmark, res_meaning];

            console.log(result_set[2])

        } else {
            result_set = "Unknown";
        }
    })
    return result_set;
}


// page_2 load database table as word_list
function load_db_table_as_word_list() {
    var db = getdatabase();
    var result_set = [];

    //    var str = ".tables;"
    var str = "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;";

    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        console.log(result.rows.length)
        if (result.rows.length > 0) {
            console.log("js: exec success ");
            for (var i = 0; i < result.rows.length; i++) {
                var result_temp = result.rows[i].name
                console.log(result_temp);
                //                result_set = []
                result_set[i] = result_temp
            }
            for (var ii = 0; ii < result_set.length; ii++) {
                console.log("js: " + result_set[ii])
            }

            //            return ";
        }
        else {
            result_set = "Unknown";
            console.log("js: exec faliure");
            return result_set;
        }
    })

    return result_set;

}



// page_2   create & delete database table
//////////////////////////////////////////////////////////////////////////
// create a db table at the same time the model add one new item
function create_db_table(add_table_name) {
    var db = getdatabase();
    var result_set;

    var str = "CREATE TABLE " + add_table_name +
        "( " +
        "word_index INT," +
        "word VARCHAR," +
        "soundmark VARCHAR," +
        "meaning VARCHAR," +
        "study_count INT," +
        "is_marked bool);";
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        //        console.log( result.rows.length )
        if (result.rows.length === 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure ");
        }
    })

    // write para_info to para_info_table
    var para_info_str = "INSERT INTO para_info values('" +
        add_table_name +
        "', 0, 0, 0);"
    console.log("js: " + para_info_str);
    db.transaction(function (tx) {
        var result = tx.executeSql(para_info_str);
        console.log(result.rows.length)
        if (result.rows.length === 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure ");
        }
    })

    return true;
}


// delete a db table at the same time the model delete one table
function delete_db_table(del_table_name) {
    var db = getdatabase();
    var result_set;

    var str = "DROP TABLE " + del_table_name + ";";
    console.log(str);
    db.transaction(function (tx) {
        var result = tx.executeSql(str);
        console.log(result.rows.length)
        if (result.rows.length === 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log("exec faliure");
        }
    })


    // modify para_info to para_info_table
    var para_info_str = "DELETE FROM para_info where db_table_name = '" +
        del_table_name +
        "';"
    console.log("js: " + para_info_str);
    db.transaction(function (tx) {
        var result = tx.executeSql(para_info_str);
        console.log(result.rows.length)
        if (result.rows.length === 0) {
            console.log(" exec success ");
        }
        else {
            result_set = "Unknown";
            console.log(" exec faliure ");
        }
    })

    return false;
}
