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
        img{
            width: 300px;
            height: 300px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <table>
            <tr>
                <th>메뉴</th>
                <td><img :src="info.filePath"></td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td>{{info.menuName}}</td>
            </tr>
            <tr>
                <th>음식명</th>
                <td>{{info.foodName}}</td>
            </tr>
            <tr>
                <th>상세 정보</th>
                <td>{{info.foodInfo}}</td>
            </tr>
            <tr>
                <th>가격</th>
                <td>{{info.price}}</td>
            </tr>
        </table>

    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                foodNo: "${foodNo}",
                info: {}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    foodNo: self.foodNo
                };
                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.info = data.info
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>