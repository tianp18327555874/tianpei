<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="myapp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>
<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="modal fade" id="empUpdateModal"   
	   role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10" >
				      <p class="form-control-static" id="empName_Update_static"></p>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				    <label class="radio-inline">
				      <input type="radio" name="gender" id="gender_update_input" value="M" checked="checked">男
				    </label>
				     <label class="radio-inline">
				      <input type="radio" name="gender" id="gender_update_input" value="F">女
				    </label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				      <select class="form-control" name="dId" id="dept_update_select">
						  
					  </select>
				    </div>
				  </div>
				</form> 
			<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	</div>
	
	  Modal
	<div class="modal fade" id="empAddModal"   
	   role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10" id="empName">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				    <label class="radio-inline">
				      <input type="radio" name="gender" id="gender_add_input" value="M" checked="checked">男
				    </label>
				     <label class="radio-inline">
				      <input type="radio" name="gender" id="gender_add_input" value="F">女
				    </label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				      <select class="form-control" name="dId" id="dept_add_select">
						  
					  </select>
				    </div>
				  </div>
				</form> 
			<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_but">新增</button>
				<button class="btn btn-danger" id="emp_delete_modal_but">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
						    <th>
						     <input type="checkbox" id="check_all">
						    </th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info"></div>
			<div class="col-md-6" id="page_navigation_bar"></div>
		</div>
	</div> 
	 <script type="text/javascript">
	    var totalRecord,currentPage;
		$(function() {
			//当页面加载完去首页
			to_page(1);

		});
		
		function to_page(pn){
			$.ajax({
				url : "emps",
				data : "pn="+pn,
				type : "GET",
				success : function(result) {
					console.log(result);
                    //解析并显示员工数据
					build_emps_table(result)
					//解析并显示分页信息
					build_page_info(result)
					//解析并显示分页条信息
					build_page_navigation_bar(result)
				}

			})
		}
		
 		//解析并显示员工数据
		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkbox = $("<td><input type='checkbox' class='check_item'/></td>");
				//构建显示员工的信息
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				
				var edtiBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_but")
				                                    .append($("<span></span>"))
				                                    .addClass("glyphicon glyphicon-pencil")
				                                    .append("编辑");
				//为编辑按钮添加一个自定义的一个员工id
				edtiBtn.attr("edit-id",item.empId);
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_but")
				                                      .append($("<span></span>")
								                      .addClass("glyphicon glyphicon-trash"))
								                      .append("删除");
				deleteBtn.attr("edit-id",item.empId);
				var btnTd = $("<td></td>").append(edtiBtn).append(" ").append(
						deleteBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkbox)
				              .append(empIdTd)
				              .append(empNameTd)
				              .append(genderTd)
				              .append(emailTd)
				              .append(deptNameTd)
				              .append(btnTd)
				              .appendTo("#emps_table tbody");
			});
		}
		
		//解析并显示分页信息
		function build_page_info(result) {
			//清空显示分页信息
			$("#page_info").empty();
			$("#page_info").append("当前" + result.extend.pageInfo.pageNum + "页,总共"
							             + result.extend.pageInfo.pages + "页,一共"
							             + result.extend.pageInfo.total + "条记录");
			totalRecord=result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
		}
		
		//解析并显示分页条
		function build_page_navigation_bar(result) {
			//清空显示分页条n 
			$("#page_navigation_bar").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			var beforePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			//判断前一页是否能被的点击
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				beforePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				})
				beforePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				})	
			}
			
			var afterPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
			//判断末页和后一页是否能被点击
			if(result.extend.pageInfo.hasNextPage==false){
				afterPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				})
				afterPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				})
			}
			
			//添加和前一页首页
			ul.append(firstPageLi).append(beforePageLi);
			//遍历页码数
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item) {
						var numberLi = $("<li></li>").append($("<a></a>").append(item));
						//判断当前页是否等于正在遍历的页码
						if(result.extend.pageInfo.pageNum == item){
							//添加一个活动
							numberLi.addClass("active");
						}
						//点击去第几页
						numberLi.click(function(){
							to_page(item);
						});
						ul.append(numberLi);
					})
			ul.append(afterPageLi).append(lastPageLi);
			var navEle =$("<nav></nav>").append(ul);
			navEle.appendTo("#page_navigation_bar");
		}
		//清空表单的样式和内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单的样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".hlp-block").text("");
		}
		//点击新增弹出模态框
		$("#emp_add_modal_but").click(function(){
			//清除表单
			reset_form("#empAddModal form")
			
			//发送ajax请求查询部门信息显示在下拉列表中
			 deptName("#empAddModal select");
			//弹出模态框信息
			$("#empAddModal").modal({
				backdrop:"static"
			})
		})
		
		//显示部门信息的方法
		function deptName(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"depts",
				type:"GET",
				success:function(resuft){
			    //返回的json字符串{"flg":true,"msg":"处理成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}		
					//console.log(resuft)
				//显示部门信息在下拉列表中
				 $.each(resuft.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					})
				}
			})
		}
		//校验用户名或密码格式是否输入正确
		function validate_add_from(){
			var $empName = $("#empName_add_input").val();
			var empName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;	
			if(!empName.test($empName)){
				show_validate_mgs("#empName_add_input","error","用户名必须为6-16为数字和字母的组合或2-5个中文"); 
				return false;
			  }
			 email_add_input();
			 return true
		} 
	   function email_add_input(){
			var $email = $("#email_add_input").val();
			var email =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!email.test($email)){
			     show_validate_mgs("#email_add_input","error","email格式不部正确"); 
				return false
			}else{
				show_validate_mgs("#email_add_input","success",""); 
			}
		}
	
		 $("#email_add_input").blur(function(){
			email_add_input();
		}) 
		
		//检验用户名是否可用
		$("#empName_add_input").change(function(){
		    var empName=this.value;
			$.ajax({
				url:"checkuser",
				data:"empName="+empName,
				type:"GET",
				success:function(resuft){
				  if(resuft.msg=="处理成功"){
						show_validate_mgs("#empName_add_input","success","用户名可用")	;
						$("#emp_save_btn").attr("ajax-va","success");
						 
					}else if(resuft.msg=="处理失败"){
						show_validate_mgs("#empName_add_input","error",resuft.extend.va_msg);	
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			})
		})
		
		//校验添加数据的方法
		function show_validate_mgs(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				  $(ele).parent().addClass("has-success");
				  $(ele).next("span").text(msg);
				 
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		   //点击保存按钮发送请求
			$("#emp_save_btn").click(function(){
				 if(!validate_add_from()){
						return false;
					}
				if($(this).attr("ajax-va")=="error"){
					return false;
				}
				$.ajax({
					url:"emp",
					type:"POST",
					//$("#empAddModal form").serialize(),选取需要添加的内容
					data:$("#empAddModal form").serialize(),
					success:function(resuft){                                     
						if(resuft.msg=="处理成功"){
							    //保存员工成功关闭模态框
							   $("#empAddModal").modal('hide');
							  //跳到最后一页查看添加员工的信息
							  to_page(totalRecord);
							  $("#empName_add_input").next("span").text("");
							}else if(resuft.msg=="处理失败"){
								if(undefined!=result.extend.errorFields.email){
									show_validate_mgs("#email_add_input","error",result.extend.errorFields.email);
								}
								if(undefined!=result.extend.errorFields.empName){
									show_validate_mgs("#empName_add_input","error",result.extend.errorFields.empName);
								}
							}
					}
				})
				
			})
		
		
		 $(document).on("click",".edit_but",function(){
			//清除表单
			 reset_form("#empUpdateModal form")
			 //查询员工信息显示在模态框中
			//发送ajax请求查询部门信息显示在下拉列表中
			 deptName("#empUpdateModal select");
			//$(this).attr("edit-id")获取员工id的值
			 getEmp($(this).attr("edit-id"));
			//把员工id绑定到更新按钮上
			 $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			//弹出模态框信息
			$("#empUpdateModal").modal({
				backdrop:"static"
			})
		}) 
		
		function getEmp(id){
			
			$.ajax({
				url:"emp/"+id,
				type:"GET",
				success:function(resuft){
					var empData =resuft.extend.employee;
					$("#empName_Update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			})
		}
		   
		$("#emp_update_btn").click(function(){
			//验证邮箱输入格式是否正确
			var $email = $("#email_update_input").val();
			var email =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!email.test($email)){
				show_validate_mgs("#email_update_input","error","email格式部正确");
				return false
			}else{
				show_validate_mgs("#email_update_input","success","");
			}
			//反送ajax请求保存跟新员工的数据
			$.ajax({
				//$(this).attr("edit-id")员工id的值
				url:"emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(resuft){
					$("#empUpdateModal").modal('hide');
					 to_page(currentPage);
				}
			})
		})
		//单个删除的方法
		 $(document).on("click",".delete_but",function(){
			 var empName = $(this).parents("tr").find("td:eq(2)").text();
			 if(confirm("确认删除【"+empName+"】吗?")){
				 $.ajax({
						url:"emp/"+$(this).attr("edit-id"),
						type:"DELETE",
						success:function(resuft){
							to_page(currentPage);
				        }
				 })
			  }
		}) 
		//完全选/和选者选
		$("#check_all").click(function(){
			
			$(".check_item").prop("checked",$(this).prop("checked"));
		})
		$(document).on("click",".check_item",function(){
			//选中的元素是否等于选中的个数
			var flag = $(".check_item:checked").length == $(".check_item").length;
			   $("#check_all").prop("checked",flag);
		})
		
		$("#emp_delete_modal_but").click(function(){
			var empNames="";
			var del_empId="";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text();
				//组装员工id的字符串
				del_empId+=$(this).parents("tr").find("td:eq(1)").text()+"-";
			})
			//substring去除逗号的方法
			empNames=empNames.substring(0, empNames.length-1);
			del_empId=del_empId.substring(0,del_empId.length-1);
			if(confirm("确认删除【"+empNames+"】吗?")){
				$.ajax({
						url:"emp/"+del_empId,
						type:"DELETE",
						success:function(resuft){
							$("#check_all").prop("checked",false);
							to_page(currentPage);
				        }
				 })
			  }
		}) 
	</script> 
</body>
</html>