<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/baiduyun.css">
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<style type="text/css">
		.search{
			margin-top: 35px;
			margin-left: 20px;
			width: 580px;
			height: 44px;
			border: 1px solid blue;
			
		}
		
		.log{
			margin-top:10px;
			margin-left: 130px;		
		}
			.searchType{
			width: 80px;
			height: 44px;
			border: 1px solid blue;
		}
	</style>
		<script type="text/javascript">
		function yanZhenKey(){
			if($('#key').val() == null || $('#key').val() == ''){
				alert("查询关键字不能为空哦！");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<div class="container">
			<div class="row">
				<div class="col-md-11">
					<img class="log" src="<%=request.getContextPath()%>/static/images/logo2.png">
						<div class="form-group">
						 	<form method="POST" class="form-inline" action="<%=request.getContextPath()%>/search/search_key" onsubmit="return yanZhenKey();">
							   <input type="text" id="key" name="key" class="search" placeholder="请输入要查询的关键字..." >
							   <select name="searchType" id="searchType" class="searchType">
							   		<option value="1" selected>百度云盘</option>
							   		<option value="2">腾讯微云</option>
							   		<option value="3">新浪微盘</option>
							   </select>
							   <button class="btn btn-primary btn-lg active" type="submit">搜索一下</button>
					   		</form>
				   		</div>
				  </div>
  			</div>
  			
  			<div class="row">
  				<div class="col-md-11">
	  				<div class="data_list">
							<div class="data_list_title">
									<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
									共查询到【${resultCount}】条&nbsp;&nbsp;&nbsp;用时【${searchTime}】&nbsp;&nbsp;&nbsp;温馨提示：【只显示前十页数据】
							</div>
							<div class="datas">
								<c:forEach items="${searchResultList}" var="s">
										<li style="margin-bottom: 18px">
											<span class="title"><a href="${s.url}" target="_self">${s.title}</a></span>
											<span class="summary">摘要：${fn:substring(s.content, 0, 150)}...</span>
											<span class="link">${fn:substring(s.url, 0, 80)}...</span>		
											<hr style="height:5px;border:none;border-top:1px dashed gray;padding-bottom:10px;" />  	  							
										</li>
								</c:forEach>		
							</div>
					</div>
  				</div>	
  				
  			</div>
		</div>
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/baidu_prompt.js"></script>
	<script type="text/javascript">
	//回调函数，用于获取用户当前选择的文字
 	function show(str){
		txtObj.innerHTML = str;
	}

	var params = {
		"XOffset":0, //提示框位置横向偏移量,单位px
		"YOffset":0, //提示框位置纵向偏移量,单位px
		"width":582, //提示框宽度，单位px
		"fontColor":"black", //提示框文字颜色
		"fontColorHI":"#FFF",	//提示框高亮选择时文字颜色
		"fontSize":"20px",		//文字大小
		"fontFamily":"宋体",	//文字字体
		"borderColor":"gray", 	//提示框的边框颜色
		"bgcolorHI":"#03c",		//提示框高亮选择的颜色
		"sugSubmit":false		//在选择提示词条是是否提交表单
	};
 	BaiduSuggestion.bind("key",params,show);
</script>	
<c:if test="${resultCount != null}">
	<div align="center">
		<nav>
		  <ul class="pagination">
			    <li>
			      <a href="<%=request.getContextPath()%>/search/search_key?start=0" aria-label="Previous">
			        <span aria-hidden="true">首页</span>
			      </a>
			    </li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=0">1</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=10">2</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=20">3</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=30">4</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=40">5</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=50">6</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=60">7</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=70">8</a></li>
			    <li><a href="<%=request.getContextPath()%>/search/search_key?start=80">9</a></li>
			    <li>
			      <a href="<%=request.getContextPath()%>/search/search_key?start=80"" aria-label="Next">
			        <span aria-hidden="true">末页</span>
			      </a>
			    </li>
		  </ul>
		</nav>
	</div>
</c:if>
</body>
</html>