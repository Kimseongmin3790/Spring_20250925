<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <table>
                <tr>
                    <th>제목</th>
                    <td><input v-model="title"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea v-model="contents"></textarea></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                </tr>
            </table>
        </div>
        <div>
            <button @click="fnAdd">저장</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                userId: "${sessionId}",
                title: "",
                contents: ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    title: self.title,
                    contents: self.contents,
                    userId: self.userId
                };
                $.ajax({
                    url: "/bbs/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("추가되었습니다.");
                            var form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] );
                            form.append( "bbsNum",  data.bbsNum);
                            self.upload(form);
                        }
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/bbsFileUpload.dox", 
                    type : "POST", 
                    processData : false, 
                    contentType : false, 
                    data : form, 
                    success:function(data) { 
                        console.log(data);
                    }	           
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>