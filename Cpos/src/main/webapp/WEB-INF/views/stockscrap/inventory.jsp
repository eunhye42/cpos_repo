<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp"></jsp:include>

<jsp:useBean id="now" class="java.util.Date" />

<section class="pt-5 pb-2 ivory">
<div class="container">
  <h1 class="text-center">재고리스트</h1>
  <!-- <a href="/stockscrap/new" class="text-right">재고 추가하기</a><br> -->
  <div class="cate">
  <label class="ml-3">대분류:</label>
  <select class="btn btn-outline-primary ml-3" id="lcate">
  <option value="x" class="btn-light text-dark">대분류</option>
  <c:forEach items="${cate }" var="cate">
    <option class="btn-light text-dark" value="${cate.large }">${cate.large }</option>
  </c:forEach>
  </select>
  <label class="ml-3">중분류:</label>
  <select class="btn btn-outline-primary ml-3" id="mcate">
    <option value="전체">전체보기</option>
  </select>
  </div>
  
  <table class="table table-hover mt-3 text-center card-ivory">
    <thead>
    <tr class="table-primary inv_tr">
      <th id="all-chk">카테고리</th>
      <th>상품명</th>
      <th>수량</th>
      <th><button id="all_qnt" class="btn btn-outline-warning text-dark">수량 변경</button></th>
      <th>할인율</th>
      <th>유통기한</th>
      <th>상태</th>
      <th>기타</th>
    </tr>
    </thead>
    <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
    <tbody id="tbody">
    </tbody>
    </table>
    <span id="scrapListBtn"><a class="btn btn-secondary" href="/stockscrap/exscrap">폐기리스트</a></span>
    <!-- <tfoot>
      <tr>
        <td colspan="6" class="text-left"><a class="btn btn-secondary" href="/stockscrap/exscrap">폐기리스트</a></td>
      </tr>
    </tfoot> 
  </table> -->
  <div id="itemPaging" class="mb-5">
  </div>
  <div>
  <!-- 인벤토리 수정 Modal -->
    <div class="modal fade" id="invenModal">
      <div class="modal-dialog modal-lg">
         <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header" style="display: inline-block;text-align: center;">
               <h4 class="modal-title">상품 정보 수정</h4>
            </div>
            <!-- Modal body -->
            <div class="modal-body" style="text-align: center;">
               <table class="table table-bordered">
                     <tr>
                        <th class="table-primary">ino</th>
                        <td id="dt_ino"></td>
                        <th class="table-success">바코드</th>
                        <td id="dt_barcode"></td>
                     </tr>
                     <tr>
                        <th class="table-primary">상품명</th>
                        <td id="dt_pname"></td>
                        <th class="table-success">수량</th>
                        <td class="bg-ivory"><input type="number" id="dt_qnt" min="0" style="width:80px">개</td>
                     </tr>
                     <tr>
                        <th class="table-primary">카테고리</th>
                        <td id="dt_cate"></td>
                        <th class="table-success">원가</th>
                        <td id="dt_gPrice" class="pl-3 pr-3" style="text-align:right"></td>
                     </tr>
                     <tr>
                        <th class="table-primary">유통기한</th>
                        <td id="dt_exdate"></td>
                        <th class="table-success">할인률(%)</th>
                        <td class="bg-ivory"><input type="number" id="dt_dc" min="0" max="100">%</td>
                     </tr>
                     <tr>
                        <th class="table-primary">상태</th>
                        <td id="dt_state"></td>
                        <th class="table-success">상태변경</th>
                        <td class="bg-ivory" id="dt_stateBtns"><button type="button" class="mr-2" id="scBtn">처분</button><button type="button" id="dt_dellBtn">삭제</button></td>
                     </tr>
               </table>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
               <button type="button" class="btn btn-primary" name="idt_modBtn" id="idtmodBtn">수정완료</button>
               <button type="button" class="btn btn-danger" name="ccBtn" data-dismiss="modal">취소</button>
            </div>
         </div>
      </div>
   </div>
  </div>
  <div>
    <div class="modal fade" id="i_Modal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content" >
          <div class="modal-header">
            <h3 class="modal-title">처분 사유</h3>
            <button type="button" class="close xBtn" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
            <div>
              <label> 분류 : </label>
              <select class="form-select modal_sel">
                <option value="0" selected="selected" disabled>선택해주세요</option>
                <option value="1">상품 단종</option>
                <option value="2">상품 문제</option>
                <option value="3">기타 사유</option>
              </select>
            </div>
            <textarea class="subTx" placeholder="내용을 입력해 주세요" rows="5"></textarea>
            <div class="right_end">
              <button type="button" class="btn btn-primary mr-2">확인</button>
              <button type="button" class="btn btn-danger" id="close_sub" data-dismiss="modal">취소</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
  </section>
<script>
listUp("x","전체",1);
$("#lcate").on("change", function(e) {
	let large = $(this).val();
	//alert("선택한것: "+txt);
	let c1 = ["음료","채소/과일","정육"];
	let c2 = ["아이스","가공식품"];
	let c3 = ["과자류","라면","조미료"];
	let c4 = ["의류","위생용품","기타"];
	let c5 = ["주류","담배"];
	var target = document.getElementById("mcate");
	
	let data;
	if($(this).val() != "x"){
		if($(this).val() == "냉장")
			data = c1;
		else if($(this).val() == "냉동")
			data = c2;
		else if($(this).val() == "실온")
			data = c3;
		else if($(this).val() == "생필품")
			data = c4;
		else if($(this).val() == "기호품")
			data = c5;
		data.unshift("전체");
	}else{
	    data = ["전체"];
	  }
	
	target.options.length = 0;
	
	for(x in data){
		var opt = document.createElement("option");
		opt.value = data[x];
		opt.innerHTML = data[x];
		target.appendChild(opt);
	}
	listUp(large,"전체",1);
});
function listUp(large, medium, page) {
	let pageNo = page>1? page:1;
	//console.log("pageNo="+pageNo);
    $.getJSON("/stockscrap/getIlist/"+large+"/"+medium+"/"+pageNo+".json",function(idto){
    	  //console.log("cnt="+idto.itemCnt);
      printList(idto.ilist, idto.itemCnt, pageNo);
      }).fail(function(){
        alert("large주문 리스트 출력 실패");
      });
}

function  printList(list, itemTotal, page){
	 let uls="";
	  if(list.length != 0){
     for(svo of list){
    	 let exdate = displayTime(svo.expire_date);
    	 //let scrap = exScrap(exdate);
    	 let scrap = exScrap(svo.expire_date);
      uls +='<tr>';
      uls +='<td class="text-info cate"><input type="hidden" class="category" value="'+svo.category+'">'+svo.large+"/"+svo.medium+'</td>';
      uls +='<td class="pname"><input type="hidden" value="'+svo.inventory_no+'" class="ino">'+svo.pname+'</td>';
      uls +='<td class="text-success"><input type="number" value="'+svo.inv_qnt+'" class="qnt" min="0" readonly></td>';
      uls +='<td><button type="button" class="mod_qntBtn btn btn-warning">수정</button></td>';
      uls +='<td class="barcode" style="display:none;">'+svo.barcode+'</td>';
      uls +='<td class="gPrice" style="display:none;">'+svo.get_price+'</td>';
      uls +='<td><span class="dc">'+svo.discount_rate+'</span>%</td>';
      uls +='<td class="ex_date">'+exdate+'</td>'+'<td class="state "';
      //console.log(scrap);
      if(scrap < 1){ 
    	  uls += 'text-danger">폐기예정';
      }else if(scrap <= 3){
    	  uls += 'text-warning">기한임박';
      }else {
    	  uls += 'text-success">'+"여유";
      }
      uls += '</td><br><td><button class="i_detailBtn btn btn-outline-primary">변경</button></td>';
     }
	  }else{
		 uls += '<tr><td rowspan="6">해당 상품이 없습니다.</td>';
	 } 
	   uls += '</tr>';
     $("#tbody").html(uls);
     printPaging(itemTotal, page);
}

$("#mcate").on("change", function() {
	let large = $("#lcate").find(":selected").val();
	  let medium = $(this).val();
	  listUp(large, medium, 1);
	});
	
	function exScrap(date) {
	  let today = new Date();
	  //let today = displayTime(new Date());
	  //let diff = date <= today;
	  //return diff?1:0;
	  let day = (date-today)/86400000;
	  return day;
	}
	
	function displayTime(d8) {
		  let changeModd8 = new Date(d8);
		  
		  let modYear = changeModd8.getFullYear();
		  let modMonth = changeModd8.getMonth()+1;
		  let modDate = changeModd8.getDate();
		  
		  let modHour = changeModd8.getHours();
		  let modMin = changeModd8.getMinutes();
		  let modSec = changeModd8.getSeconds();
		  
		  let hour = (modHour > 9 ? "" : "0") + modHour;
		  let min = (modMin > 9 ? "" : "0")+modMin;
		  let sec = (modSec > 9 ? "" : "0")+modSec;
		  let month = (modMonth > 9 ? "" : "0")+modMonth;
		  let day = (modDate > 9 ? "" : "0")+modDate;
		  
		  let dateStr = modYear + "-" + month + "-" + day;
		  let timeStr = hour + ":"+min+":"+sec;
		  
		  return dateStr;
		}
	
	$(document).on("click",".mod_qntBtn", function() {
		$(this).closest('tr').find("td:nth-child(3) input:first-child").attr("readonly",false);
		$(this).closest('tr').find(".qnt").before('<button type="button" class="btn-outline-primary btn-sm qnt_btn">-</button>').trigger("create");
		$(this).closest('tr').find(".qnt").after('<button type="button" class="btn-outline-primary btn-sm qnt_btn">+</button>').trigger("create");
		let modbtn = '<button type="button" class="modBtn btn btn-outline-success">수정완료</button>';
		$(this).after(modbtn).trigger("create");
		$(this).remove();
	});
	
	$(document).on("click",".qnt_btn", function() {
		let qnt = $(this).closest('tr').find(".qnt").val();
		if($(this).text()=='+'){
			qnt++;
		}else if(qnt>0){
			qnt--;
			if(qnt==0){
				alert("수량을 0으로 변경하면 상품이 삭제됩니다.");
			}
		}
			$(this).closest('tr').find(".qnt").val(qnt);
	});
	
	$(document).on("click", ".i_detailBtn", function() {
		let detail = $(this).closest('tr').find(".ino").val();
		let barcode = $(this).closest('tr').find(".barcode").text();
		let pname = $(this).closest('tr').find(".pname").text();
		let cate = $(this).closest('tr').find(".cate").text();
		let gPrice = $(this).closest('tr').find(".gPrice").text();
		let qnt = $(this).closest('tr').find(".qnt").val();
		let exdate = $(this).closest('tr').find(".ex_date").text();
		let dc = $(this).closest('tr').find(".dc").text();
		let state = $(this).closest('tr').find(".state").text();
		//console.log(detail);
		//디테일 변경 하는 모달 띄우기 (수정/삭제)
		$("#dt_ino").text(detail);
		$("#dt_barcode").text(barcode);
		$("#dt_pname").text(pname);
		$("#dt_cate").text(cate);
		$("#dt_gPrice").text(gPrice+"  원");
		$("#dt_qnt").val(qnt);
		$("#dt_exdate").text(exdate);
		$("#dt_dc").val(dc);
		$("#dt_state").text(state);
		$("#invenModal").modal();
	});
	
	$("#dt_dellBtn").on("click", function() {
		let page = $("li.active a").text();
		let ino = $(this).closest('table').find("#dt_ino").text();
		//console.log(ino);
		modifyQnt(ino,0);
	});
	
	$(document).on("click", ".modBtn", function() {
		let qntVal = $(this).closest('tr').find(".qnt").val();
		let ino = $(this).closest('tr').find(".ino").val();
		
		modifyQnt(ino,qntVal);
	});
	
	function modifyQnt(ino,qnt) {
		$.ajax({
		      type: "post",
		      url: "/stockscrap/qntmodify",
		      data: {inventory_no:ino,inv_qnt:qnt}
		    }).done(function(result) {
		      if(result!=1) alert("수량변경 실패");
		    }).fail(function(e) {
		      console.log("error:"+e);
		    });
		location.replace("/stockscrap/inventory");
	}
	
	function printPaging(itemTotal, page) {
		let itemPage = '<ul class="pagination justify-content-center">';
		let endPagingNum = Math.ceil(page/10.0)*10;
		let beginPagingNum = endPagingNum-9;
		let prev = beginPagingNum != 1;
		let next = false;
		
		if(endPagingNum*10 >= itemTotal){
			endPagingNum = Math.ceil(itemTotal/10.0);
		}else{
			next = true;
		}
		
		if(prev){
			itemPage += '<li class="page-item">';
			itemPage += '<a class="page-link" href="'+(beginPagingNum-1)+'">Prev</a></li>';
		}
		for(var i=beginPagingNum; i<=endPagingNum; i++){
			let classActive = page == i? 'active' : '';
			itemPage += '<li class="page-item '+classActive+'">';
			itemPage += '<a class="page-link" href="'+i+'">'+i+'</a></li>';
		}
		if(next){
			itemPage += '<li class="page-item">';
			itemPage += '<a class="page-link" href="'+(endPagingNum+1)+'">Next</a></li>';
		}
		itemPage += '</ul>';
		$("#itemPaging").html(itemPage);
	}
	
	$(document).on("click", "#itemPaging li a", function(e) {
	    e.preventDefault();
	    let large = $("#lcate").val();
	    let medium = $("#mcate").val();
	    listUp(large, medium, $(this).attr("href"));
	  });
	
	$(document).on("click", "#all_qnt", function() {
		  //check_box 생성
		  //전체 값 리스트 전달
		  let chkbox = '<td><input type="checkbox" class="check" name="qnt_chk"></td>';
		  $(this).closest('table').find('th:first-child').before('<th><input type="checkbox" id="all_check"></th>').trigger("create");
		  $(this).closest('table').find('td:first-child').before(chkbox).trigger("create");
		  $(this).after('<button id="allqnt_submit" class="btn btn-outline-success text-dark">변경완료</button>').trigger("create");
		  $(this).attr("style","display:none");
		  $(this).closest('table').find(".qnt").attr("readonly",false);
	});
	
	$(document).on("click", "#all_check", function() {
		console.log("check!!");
		console.log($(this).is(":checked"));
		if($(this).is(":checked") == true){
			$(".check").attr("checked", true);
		}else{
			$(".check").attr("checked", false);
		}
	});
	
	$(document).on("click", "#allqnt_submit", function() {
		  console.log("allqnt_submit click!");
		  $(this).closest('th').find('button:first-child').attr("style","display:block");
	    $(this).attr("style","display:none");
		  let datas = [];
		  $("input[name=qnt_chk]:checked").each(function() {
		        let scData = {
		        		inventory_no:$(this).closest('tr').find(".ino").val(),
		            inv_qnt:$(this).closest('tr').find(".qnt").val()};
		        datas.push(scData);
		  });
		    
		    console.log(datas);
		    jQuery.ajaxSettings.traditional = true;
		    $.ajax({
		      url:"/stockscrap/allqnt_mod",
		      type:"POST",
		      dataType:"json",
		      data:JSON.stringify(datas),
		      contentType: "application/json; charset=utf-8",
		      success: function(data) {
		        alert(data>0?"처리완료!"+data:"변경된 게 없습니다."+data);
		        let page = $("li.active a").text();
		        if(page > Math.ceil(page/10.0)*10)
		          listUp($("#lcate").val(), $("#mcate").val(), page);
		        else
		          listUp($("#lcate").val(), $("#mcate").val(), page-1);
		        $("#all_check").closest('th').remove();
		      },
		      error: function(e) {
		        alert("에러메시지:관리자에게 문의하세요~");
		        console.log(e);
		      }
		    });
	});
	
	$("#idtmodBtn").on("click", function() {
		let ino = $(".modal-body").find("#dt_ino").text();
		let qnt = $(".modal-body").find("#dt_qnt").val();
		let dc = $(".modal-body").find("#dt_dc").val();
		$.ajax({
			url: "/stockscrap/idtmodify",
			type: "post",
			data: {inventory_no:ino, inv_qnt:qnt, discount_rate:dc}
				}).done(function(result) {
					console.log("완료");
					location.replace("/stockscrap/inventory");
				}).fail(function(result) {
					console.log(result);
				});
	});
	
	$("#scBtn").on("click", function() {
		console.log("처분 클릭");
		$("#invenModal").modal('hide');
		$("#i_Modal").modal('show');
	});
	
	$("#close_sub").on("click", function() {
		$("#invenModal").modal('show');
	});
	
	$(".xBtn").on("click", function() {
		$(".subTx").val("");
		$(".modal_sel").val("0");
	})
</script>
<jsp:include page="../common/footer.jsp"></jsp:include>