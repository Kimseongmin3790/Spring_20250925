<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        #red a{
            color: red;
        }
        .active{
            color: red;
            font-weight: bold;
            font-size: 23px;
        }
        div a{
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <select v-model="pageSize" @change="fnList(1)">
                <option value="3">3개씩</option>
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
            </select>
            <div>
                <select v-model="kind">
                    <option value="">:: ::</option>
                    <option value="title">제목</option>
                    <option value="userId">작성자</option>
                </select>
                <input type="text" v-model="keyword" @keyup.enter="fnList(1)">
                <button @click="fnList(1)">검색</button>
            </div>
             <table>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="radio" :value="item.bbsNum" v-model="selectItem"></td>
                    <td>{{item.bbsNum}}</td>
                    <td v-if="item.hit >= 25" id="red"><a href="javascript:;" @click="fnView(item.bbsNum)">{{item.title}}</a></td>
                    <td v-else><a href="javascript:;" @click="fnView(item.bbsNum)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td>{{item.hit}}</td>
                    <td>{{item.cdatetime}}</td>
                </tr>
             </table>
         </div>
         <div>
            <button @click="fnRemove">삭제</button>
            <a href="/bbs/add.do"><button>글 쓰기</button></a>

            <a href="javascript:;" v-for="num in index" style="margin-left: 30px;" @click="fnPage(num)">
                <span :class="{active : page == num}">{{num}}</span>
            </a>
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
                userId: "${sessionId}",
                selectItem: "",
                pageSize: 3, // 화면에 보여줄 페이지
                page: 1, // 현재 페이지
                index: 0, // 최대 페이지
                kind: "",
                keyword: ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function (num) {
                let self = this;
                if (num == 1) {
                    self.page = num;
                }
                let param = {
                    pageSize: self.pageSize,
                    page: (self.page - 1) * self.pageSize,
                    kind: self.kind,
                    keyword: self.keyword
                };
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data)
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                    }
                });
            },
            fnRemove: function () {
                let self = this;
                var param = {
                    selectItem : self.selectItem
                };
                $.ajax({
                    url: "/bbs/deleteList.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.selectItem = "";
                        self.page = 1;
                        self.fnList();
                    }
                });
            },
            fnView(bbsNum) {
                let self = this;
                pageChange("/bbs/view.do", {bbsNum : bbsNum});
            },
            fnPage(num) {
                let self = this;
                self.page = num;
                self.fnList();
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