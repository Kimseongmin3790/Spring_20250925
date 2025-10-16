<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
            <tr>
                <th>개수</th>
                <td><input v-model="num"></td>
            </tr>
        </table>

        <div style="margin-top: 5px;">
            <button @click="fnPayment">주문하기</button>
        </div>
    </div>
</body>
</html>

<script>
    IMP.init("imp16634661");
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                foodNo: "${foodNo}",
                info: {},
                num: "1",
                id: "${sessionId}"
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
            },
            fnPayment: function() {
                let self = this;
                IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: "merchant_" + new Date().getTime(),
				    name: self.info.foodName,
				    amount: 1, // self.info.price * self.num
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
			   	        // 결제 성공 시
						// alert("성공");
						console.log(rsp);
                        self.fnAddHistory(rsp.imp_uid, rsp.paid_amount);
			   	      } else {
			   	        // 결제 실패 시
						alert("실패");
			   	      }
		   	  	});
            },
            fnAddHistory(uid, amount) {
                let self = this;
                let param = {
                    orderId: uid,
                    userId: self.id,
                    amount: amount,
                    productNo: self.foodNo
                };
                $.ajax({
                    url: "/product/history.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if (data.result == "success") {
                            alert("결제되었습니다");
                        } else {
                            alert("오류가 발생했습니다");
                        }
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