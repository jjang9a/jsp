package co.dev.vo;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage; // 첫 페이지
	private int endPage; // 마지막 페이지
	private boolean prev, next; // 이전, 다음 페이지
	private int page; // 현재 페이지
	
	public PageDTO(int page, int total) {
		// total : 235건 => 24page
		this.page = page;
		this.endPage = (int) Math.ceil(page/10.0) * 10; // 현재 페이지를 기준으로 10단위로 올림 ex) 1~10 => 10
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) Math.ceil(total * 1.0 / 10); // ceil의 매개값은 double이므로 형식 맞춰줘야함
		if(this.endPage > realEnd) {
			this.endPage = realEnd; // 22page의 end는 30page여야하지만 마지막 페이지인 24page를 end로 처리
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd; // 현재 3페이지라면 endPage는 10페이지
		
	}
}
