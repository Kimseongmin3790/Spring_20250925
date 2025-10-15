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
       
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div v-if="!authFlg">
             <div>
                <label>아이디 : <input v-model="id"></label>
             </div>
             <div>
                <label>이름 : <input v-model="name"></label>
             </div>
             <div>
                <label>번호 : <input v-model="phone" placeholder="-를 제외하고 입력해주세요."></label>
             </div>
             <div>
                <button @click="fnAuth">인증</button>
             </div>
         </div>

         <div v-else>
            <div>
                <label>비밀번호 : <input v-model="pwd"></label>
            </div>
            <div>
                <label>비밀번호 확인 : <input v-model="pwd2"></label>
            </div>
            <div>
                <button @click="fnPwdChange">비밀번호 수정</button>
            </div>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                authFlg : false,
                id: "",
                name: "",
                phone: "",
                pwd: "",
                pwd2: ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAuth: function () {
                let self = this;
                let param = {
                    id: self.id.trim(),
                    name: self.name,
                    phone: self.phone.trim()
                };
                $.ajax({
                    url: "/member/memberCheck.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("인증 완료");
                            self.authFlg = true;
                        } else {
                            alert("회원 정보를 확인해주세요");
                        }
                    }
                });
            },
            fnPwdChange() {
                let self = this;
                if(self.pwd != self.pwd2) {
                    alert("비밀번호가 일치하지 않습니다");
                    return;
                }
                let param = {
                    id: self.id.trim(),
                    pwd: self.pwd
                };
                $.ajax({
                    url: "/member/pwdChange.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if (data.msg) {
                            alert(data.msg);
                        } else {
                            if(data.result == "success") {
                                alert("비밀번호가 변경되었습니다");
                                location.href="/member/login.do"
                            } else {
                                alert("오류 발생");
                            }
                        }                        
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