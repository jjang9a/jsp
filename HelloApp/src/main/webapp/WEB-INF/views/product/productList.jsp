<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                
                <c:forEach begin="0" end="${list.size() -1 }" var="i">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                             <a href="productInfo.do?code=${list.get(i).productCode }">
                            	<img class="card-img-top" src="./images/${list.get(i).image }" alt="..." />
                            </a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${list.get(i).productName }</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                    	<c:forEach begin="1" end="${list.get(i).likeIt }">
                                    		 <div class="bi-star-fill"></div>
                                    	</c:forEach>
                                    	<c:choose>
                                    		<c:when test="${list.get(i).likeIt%1 > 0.5 }">
                                    			<div class="bi-star"></div> 
                                    		</c:when>
                                    		<c:when test="${list.get(i).likeIt%1 > 0 }">
                                    			<div class="bi-star-half"></div>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:forEach begin="1" end="${5 - list.get(i).likeIt }">
                                    		<div class="bi-star"></div> 
                                    	</c:forEach>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">${list.get(i).originPrice }</span>
                                    ${list.get(i).salePrice }
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                        </div>
                    </div>
                    
                </div>
            </div>
        </section>