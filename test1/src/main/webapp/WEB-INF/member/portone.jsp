<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <button @click="fnPortone">인증</button>
        </div>
    </body>

    </html>

    <script>
        IMP.init("imp16634661");
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnPortone() {
                    IMP.certification(
                        {
                            // param
                            channelKey: "channel-key-1d6f3ca6-4bae-4921-86b9-7b56ccab193d",
                            merchant_uid: "ORD20180131-0000011", // 주문 번호
                            m_redirect_url: "{리디렉션 될 URL}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                            popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
                        },
                        function (rsp) {
                            // callback
                            if (rsp.success) {
                                // 인증 성공 시 로직
                                console.log(rsp)
                            } else {
                                // 인증 실패 시 로직
                            }
                        },
                    );
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>