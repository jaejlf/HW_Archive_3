<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String session_id = (String) session.getAttribute("user");
String log;
if (session_id == null)
	log = "<a href=login.jsp>로그인</a>";
else
	log = "<a href=logout.jsp>로그아웃</a>";
%>

<table width="75%" align="center" bgcolor="#FFFF99" border>	
	<colgroup>
		<col style="width: 20%">
		<col style="width: 20%">
		<col style="width: 20%">
		<col style="width: 20%">
		<col style="width: 20%">
	</colgroup>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a href="register.jsp">회원 가입</b></td>
		<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
		<td align="center"><b><a href="movie_list.jsp">영화 목록 조회</b></td>
		<td align="center"><b><a href="booking_list.jsp">예매 내역 조회</b></td>
	</tr>
</table>