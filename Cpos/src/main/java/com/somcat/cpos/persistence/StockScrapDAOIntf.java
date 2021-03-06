package com.somcat.cpos.persistence;

import java.sql.Date;
import java.util.List;

import com.somcat.cpos.domain.CategoryVO;
import com.somcat.cpos.domain.Criterion;
import com.somcat.cpos.domain.InventoryDTO;
import com.somcat.cpos.domain.InventoryVO;
import com.somcat.cpos.domain.ScrapVO;

public interface StockScrapDAOIntf {
	public int insertInventory(int wno);
	public List<InventoryVO> selectLargeCate(); //?
	public List<InventoryVO> selectMediumCate(); //?
	public List<InventoryVO> selectInvenList(Criterion cri);
	public int insertScrap(ScrapVO svo);
	public List<Integer> insertScrap(List<ScrapVO> svo);
	public List<ScrapVO> selectScrapList(Date date);
	public int updateQuantity(InventoryVO ivo);
	public int updateQuantity(List<InventoryVO> ilist);
	public int updateIdt(InventoryVO ivo);
	public int deleteInven(int inventory_no);
	public int deleteInventory(List<Integer> inventory_no);
	public List<CategoryVO> selectAllCate();
	public List<InventoryVO> selectInventoryList(Criterion cri);
	public int totalCount(Criterion cri);
}
