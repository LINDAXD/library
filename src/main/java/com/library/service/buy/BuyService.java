package com.library.service.buy;

import com.library.model.search.BookDTO;

public interface BuyService {

	public void buy(BookDTO dto);
	
	public int buy_check(String user_id,String book_isbn);
}