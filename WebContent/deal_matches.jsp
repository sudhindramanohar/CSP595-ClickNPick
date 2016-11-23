<%@page import="java.io.BufferedReader"%>
<%@page import="com.csp595.utilities.Constants"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<html>
<body>
<div id="mainBody">
	<div class="container">
		<div class="row">
			<div class="span9">
		<%List<Product> dealMatchedProducts = new ArrayList<Product>();
		
		try {
			Map<String,Product> selectedproducts=new HashMap<String,Product>();
			Map<String,Product> productIdAndProductMap=new HashMap<String,Product>();
			productIdAndProductMap = SaxParserProductXMLdataStore.getProductHashMap();
			String line=null; %>
			<h2>Welcome to Click N Pick</h2><br>
			<h2>We beat our competitors in all aspects. Price-Match Guaranteed</h2>

			<%
			  for(Map.Entry<String, Product> entry : productIdAndProductMap.entrySet()) {
				if(selectedproducts.size()<2 && !selectedproducts.containsKey(entry.getKey())){ 
					BufferedReader reader;
					reader = new BufferedReader(new FileReader(new File(Constants.TOMCAT_HOME+"/webapps/ClickNPick/DealMatches.txt")));
					line=reader.readLine();
					if(line==null) { 
				%>
				<h2 align='center'>No Offers Found</h2>
				<%	
				}else{ 
					  do {
							if(line.toLowerCase().contains(entry.getValue().getName().toLowerCase())) {
								dealMatchedProducts.add(entry.getValue());
				%>
				<h5><%=line.substring(0, line.indexOf("http"))%></h5>
					<a href=<%=line.substring(line.indexOf("http"),line.length())%>>
					<%=line.substring(line.indexOf("http"), line.length())%></a>
					<br>
					<%		selectedproducts.put(entry.getKey(),entry.getValue()); 
						   } 
						} while((line = reader.readLine()) != null); 
					}
				}
			}
			%>
			<%for(Product product : dealMatchedProducts) {%>
			<li class="span3">
			<div class="thumbnail">
				<a href="product_details.jsp?productId=<%=product.getId()%>"><img
					src=<%= product.getImage() %> alt="" /></a>
				<div class="caption">
					<h5><%=product.getName() %></h5>
					<h4 style="text-align: center">
						<a class="btn" href="product_summary.jsp?shoppingItemId=<%=product.getId()%>"> Add to <i class="icon-shopping-cart"></i></a> 
						<a class="btn btn-primary" href="#"><%=product.getPrice() %></a>
						<a class="btn btn-primary" href="write_product_reviews.jsp?showReviewSection=<%=product.getId()%>" style="width:130px">Write Review</a>
					<a class="btn btn-primary" href="read_product_reviews.jsp?readProductReview=<%=product.getId()%>"  style="width:130px">View Reviews</a>
					</h4>
				</div>
			</div>
		</li>
		<%
		  }
		}catch (Exception e) {
			e.printStackTrace();
		}	%>
	  </div>
	</div>
   </div>
</div>		
</body>
</html>
<%@include file="footer.jsp"%>