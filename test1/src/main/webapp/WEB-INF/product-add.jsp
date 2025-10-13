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
                    <th>종류</th>
                    <td>
                        <span v-for="item in list">
                           <label><input type="radio" v-model="menuPart" :value="item.menuNo" @click="fnSelect(item.menuName)">{{item.menuName}}</label>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" v-model="foodName"></td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td><textarea v-model="foodInfo"></textarea></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><input type="text" v-model="price"></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                </tr>
            </table>
        </div>
        <div>
            <button @click="fnAdd">등록</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list: [],
                menuPart: "10",
                foodName: "",
                foodInfo: "",
                price: "",
                foodKind: ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/product/kind.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;
                    }
                });
            },
            fnAdd() {
                let self = this;
                let param = {
                    menuPart: self.menuPart,
                    foodName: self.foodName,
                    foodInfo: self.foodInfo,
                    price: self.price,
                    foodKind: self.foodKind
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                    }
                });
            },
            fnSelect(menuName) {
                let self = this;
                self.foodKind = menuName;
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>