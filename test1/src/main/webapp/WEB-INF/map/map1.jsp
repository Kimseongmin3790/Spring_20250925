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
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=78c3fbd5be4327cf3319a04cf0a379c4&libraries=services"></script>
        <style>
            .map_wrap,
            .map_wrap * {
                margin: 0;
                padding: 0;
                font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
                font-size: 12px;
            }

            .map_wrap a,
            .map_wrap a:hover,
            .map_wrap a:active {
                color: #000;
                text-decoration: none;
            }

            .map_wrap {
                position: relative;
                width: 100%;
                height: 500px;
            }

            #menu_wrap {
                position: absolute;
                top: 0;
                left: 0;
                bottom: 0;
                width: 250px;
                margin: 10px 0 30px 10px;
                padding: 5px;
                overflow-y: auto;
                background: rgba(255, 255, 255, 0.7);
                z-index: 1;
                font-size: 12px;
                border-radius: 10px;
            }

            .bg_white {
                background: #fff;
            }

            #menu_wrap hr {
                display: block;
                height: 1px;
                border: 0;
                border-top: 2px solid #5F5F5F;
                margin: 3px 0;
            }

            #menu_wrap .option {
                text-align: center;
            }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

            #placesList li {
                list-style: none;
            }

            #placesList .item {
                position: relative;
                border-bottom: 1px solid #888;
                overflow: hidden;
                cursor: pointer;
                min-height: 65px;
            }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5,
            #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

            #placesList .info .gray {
                color: #8a8a8a;
            }

            #placesList .info .jibun {
                padding-left: 26px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
            }

            #placesList .info .tel {
                color: #009900;
            }

            #placesList .item .markerbg {
                float: left;
                position: absolute;
                width: 36px;
                height: 37px;
                margin: 10px 0 0 10px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
            }

            #placesList .item .marker_1 {
                background-position: 0 -10px;
            }

            #placesList .item .marker_2 {
                background-position: 0 -56px;
            }

            #placesList .item .marker_3 {
                background-position: 0 -102px
            }

            #placesList .item .marker_4 {
                background-position: 0 -148px;
            }

            #placesList .item .marker_5 {
                background-position: 0 -194px;
            }

            #placesList .item .marker_6 {
                background-position: 0 -240px;
            }

            #placesList .item .marker_7 {
                background-position: 0 -286px;
            }

            #placesList .item .marker_8 {
                background-position: 0 -332px;
            }

            #placesList .item .marker_9 {
                background-position: 0 -378px;
            }

            #placesList .item .marker_10 {
                background-position: 0 -423px;
            }

            #placesList .item .marker_11 {
                background-position: 0 -470px;
            }

            #placesList .item .marker_12 {
                background-position: 0 -516px;
            }

            #placesList .item .marker_13 {
                background-position: 0 -562px;
            }

            #placesList .item .marker_14 {
                background-position: 0 -608px;
            }

            #placesList .item .marker_15 {
                background-position: 0 -654px;
            }

            #pagination {
                margin: 10px auto;
                text-align: center;
            }

            #pagination a {
                display: inline-block;
                margin-right: 10px;
            }

            #pagination .on {
                font-weight: bold;
                cursor: default;
                color: #777;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="map_wrap">
                <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

                <div id="menu_wrap" class="bg_white">
                    <div class="option">
                        <div>
                            <!-- ✅ Vue 방식으로 변경 -->
                            <form @submit.prevent="searchPlaces">
                                키워드 :
                                <input type="text" v-model="keyword" placeholder="장소를 입력하세요" size="15">
                                <button type="submit">검색하기</button>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <ul id="placesList"></ul>
                    <div id="pagination"></div>
                </div>
            </div>
        </div>

    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    map: null,
                    ps: null,
                    infowindow: null,
                    markers: [],
                    keyword: '이태원 맛집' // ✅ 초기값 설정
                };
            },
            methods: {
                // 🔍 키워드 검색
                searchPlaces() {
                    const keyword = this.keyword.trim();
                    if (!keyword) {
                        alert('키워드를 입력해주세요!');
                        return;
                    }
                    this.ps.keywordSearch(keyword, this.placesSearchCB);
                },

                // 📦 검색 결과 콜백
                placesSearchCB(data, status, pagination) {
                    console.log("검색 상태:", status);
                    console.log("결과 데이터:", data);
                    if (status === kakao.maps.services.Status.OK) {
                        this.displayPlaces(data);
                        this.displayPagination(pagination);
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        alert('검색 결과가 없습니다.');
                    } else if (status === kakao.maps.services.Status.ERROR) {
                        alert('검색 중 오류가 발생했습니다.');
                    }
                },

                // 📍 장소 목록 및 마커 표시
                displayPlaces(places) {
                    const listEl = document.getElementById('placesList');
                    const menuEl = document.getElementById('menu_wrap');
                    const fragment = document.createDocumentFragment();
                    const bounds = new kakao.maps.LatLngBounds();

                    this.removeAllChildNodes(listEl);
                    this.removeMarker();

                    for (let i = 0; i < places.length; i++) {
                        const placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
                        const marker = this.addMarker(placePosition, i);
                        const itemEl = this.getListItem(i, places[i]);

                        bounds.extend(placePosition);

                        ((marker, title) => {
                            kakao.maps.event.addListener(marker, 'mouseover', () => this.displayInfowindow(marker, title));
                            kakao.maps.event.addListener(marker, 'mouseout', () => this.infowindow.close());
                            itemEl.onmouseover = () => this.displayInfowindow(marker, title);
                            itemEl.onmouseout = () => this.infowindow.close();
                        })(marker, places[i].place_name);

                        fragment.appendChild(itemEl);
                    }

                    listEl.appendChild(fragment);
                    menuEl.scrollTop = 0;
                    this.map.setBounds(bounds);
                },

                // 📋 리스트 아이템 생성
                getListItem(index, place) {
                    const el = document.createElement('li');
                    let itemStr = `
        <span class="markerbg marker_${index + 1}"></span>
        <div class="info">
          <h5>${place.place_name}</h5>
      `;
                    if (place.road_address_name) {
                        itemStr += `
          <span>${place.road_address_name}</span>
          <span class="jibun gray">${place.address_name}</span>
        `;
                    } else {
                        itemStr += `<span>${place.address_name}</span>`;
                    }
                    itemStr += `<span class="tel">${place.phone || ''}</span></div>`;
                    el.innerHTML = itemStr;
                    el.className = 'item';
                    return el;
                },

                // 📍 마커 추가
                addMarker(position, idx) {
                    const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
                    const imageSize = new kakao.maps.Size(36, 37);
                    const imgOptions = {
                        spriteSize: new kakao.maps.Size(36, 691),
                        spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
                        offset: new kakao.maps.Point(13, 37)
                    };

                    const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
                    const marker = new kakao.maps.Marker({ position, image: markerImage });

                    marker.setMap(this.map);
                    this.markers.push(marker);
                    return marker;
                },

                // ❌ 마커 제거
                removeMarker() {
                    this.markers.forEach(marker => marker.setMap(null));
                    this.markers = [];
                },

                // 🔢 페이지네이션
                displayPagination(pagination) {
                    const paginationEl = document.getElementById('pagination');
                    const fragment = document.createDocumentFragment();
                    while (paginationEl.hasChildNodes()) {
                        paginationEl.removeChild(paginationEl.lastChild);
                    }

                    for (let i = 1; i <= pagination.last; i++) {
                        const el = document.createElement('a');
                        el.href = "#";
                        el.innerHTML = i;
                        if (i === pagination.current) {
                            el.className = 'on';
                        } else {
                            el.onclick = () => pagination.gotoPage(i);
                        }
                        fragment.appendChild(el);
                    }
                    paginationEl.appendChild(fragment);
                },

                // 💬 인포윈도우
                displayInfowindow(marker, title) {
                    const content = `<div style="padding:5px;z-index:1;">${title}</div>`;
                    this.infowindow.setContent(content);
                    this.infowindow.open(this.map, marker);
                },

                // 🧹 리스트 초기화
                removeAllChildNodes(el) {
                    while (el.hasChildNodes()) el.removeChild(el.lastChild);
                }
            },

            // 🌍 초기 설정
            mounted() {
                const mapContainer = document.getElementById('map');
                const mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567),
                    level: 3
                };

                this.map = new kakao.maps.Map(mapContainer, mapOption);
                this.ps = new kakao.maps.services.Places();
                this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

                // ✅ 초기 검색 실행 (이태원 맛집)
                this.searchPlaces();
            }
        });

        app.mount('#app');

    </script>