//test javascript



// real code block
var index = 10;
var current_DB_index = 10;

function getindex()
{
    return index;
}

function setindex( idx )
{
    index = idx;
}

function get_current_DB_index()
{
    return current_DB_index
}

function set_current_DB_index( value )
{
    current_DB_index = value
}



function getdatabase() {
    return LocalStorage.openDatabaseSync("word_list", "1.0", "word_list_database", 100000);
}

function readData(name) {
    var db = getdatabase();
    var res=""
    var res_index="";
    var res_word="";
    var res_soundmark="";
    var res_meaning="";

    var result_set;

    db.transaction( function(tx) {
        var result = tx.executeSql("select * from word_list_order where word=?;", [name]);
        if (result.rows.length > 0) {
            res=result
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
    if(!db) { return; }
    db.transaction( function(tx) {
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
    console.log("readDate_by_index, The index is : " + idx);


    var db = getdatabase();

    var res=""
    var res_index="";
    var res_word="";
    var res_soundmark="";
    var res_meaning="";

    var result_set;

    db.transaction( function(tx) {
        var result = tx.executeSql("select * from word_list_order where word_index=?;", [idx]);
        if (result.rows.length > 0) {


            res=result
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
