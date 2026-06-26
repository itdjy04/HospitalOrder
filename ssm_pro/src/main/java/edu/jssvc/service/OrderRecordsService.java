package edu.jssvc.service;

import java.util.List;

import edu.jssvc.entity.OrderRecords;

public interface OrderRecordsService {

	// 根据ID查询订单
	public OrderRecords findOrderById(int id);

	// 插入新预约记录
	public int insertOrderRecords(OrderRecords orderRecords);

	// 根据用户id查找预约记录
	public List<OrderRecords> findOrderRecordsByUserID(int UserId);

	// 根据预约id更改订单状态为已提交订单
	public int updateOrderSta1(int id);

	// 根据预约id更改订单的疾病信息
	public int updateOrderdiseaseInfo(String diseaseInfo,int id);

	// 取得最后插入的id
	public int findLastId();
	
	//取消订单
	public int cancelOrder(int id);

	// 管理员查询订单数量
	public int countAllOrders(String hospitalName, String officesName, String doctorName,
			Integer isSuccess, Integer isCancel, Integer orderVer);

	// 管理员分页查询订单
	public List<OrderRecords> findAllOrders(String hospitalName, String officesName, String doctorName,
			Integer isSuccess, Integer isCancel, Integer orderVer, int start, int size);

	// 审核通过
	public int approveOrder(int id);

	// 审核拒绝
	public int rejectOrder(int id);

}
