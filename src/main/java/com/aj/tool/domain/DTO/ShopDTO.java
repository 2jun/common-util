package com.aj.tool.domain.DTO;


import lombok.Data;

import java.io.Serializable;

@Data
public class ShopDTO implements Serializable {
	private Long shopId;
	private Long userId;
	private String sellerNick;
	private double saleAmount;

}
  
