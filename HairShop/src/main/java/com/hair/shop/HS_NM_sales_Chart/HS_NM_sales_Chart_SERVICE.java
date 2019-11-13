package com.hair.shop.HS_NM_sales_Chart;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_SHOP.HS_NM_SHOP_DAO;
import com.hair.shop.HS_NM_TICETIGN.HS_NM_TCKETING_DAO;

@Service
public class HS_NM_sales_Chart_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_NM_sales_Chart_DAO DAO;
	@Autowired
	private HS_NM_TCKETING_DAO TCKETING_DAO;
	@Autowired
	private HS_NM_SHOP_DAO SHOP_DAO;

// 본인 하루 매출 불러오기(ajax)
	public HS_NM_BEAN_sales_Chart sales_Chart_Select1(HS_NM_BEAN_sales_Chart sales) throws ParseException {
		
		String[] dateArray = new String[5];
		int[] salesArray = new int[5];

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String disigner_pid = TCKETING_DAO.disigner_pid(sales.getId());
		sales.setId(disigner_pid);
		
		// 캘린더 함수 생성
		Calendar cal = Calendar.getInstance();

		
		for (int i = 0; i < 5; i++) {


			cal.setTime(dateFormat.parse(sales.getDate()));

			//월수 앞자리가 0인지 확인하는 변수 
			String Date_Num0=sales.getDate().substring(5, 6);
			
			//월수에 0이있으면 0삭제
			if(Date_Num0.equals("0")){
			sales.setDate(sales.getDate().substring(0, 5) 
					+ sales.getDate().substring(sales.getDate().length()-4, sales.getDate().length())); 
			}
			
			// 본인 일 매출 가져오기
			String sales_List1 = DAO.sales_List1(sales);
			if(sales_List1==null) {
				sales_List1="0";
			}
			
			dateArray[i] = sales.getDate();
			salesArray[i] = Integer.parseInt(sales_List1);
			
			// 일수 -1
			cal.add(Calendar.DATE, -1);
			sales.setDate(dateFormat.format(cal.getTime()));
			
			sales.setDateArray(dateArray);
			sales.setSalesArray(salesArray);
		}
		
		return sales;
	}
	
	
//본인 일주일 매출 
	public HS_NM_BEAN_sales_Chart sales_Chart_Select2(HS_NM_BEAN_sales_Chart sales) throws ParseException {

		String[] dateArray = new String[5];
		int[] salesArray = new int[5];

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String disigner_pid = TCKETING_DAO.disigner_pid(sales.getId());
		sales.setId(disigner_pid);
		
		// 캘린더 함수 생성
		Calendar cal = Calendar.getInstance();

		
		for (int i = 0; i < 5; i++) {
			int sales_add = 0;

			for(int i2 = 0; i2 < 7; i2++) {

			cal.setTime(dateFormat.parse(sales.getDate()));

			// 캘린더에서 -1 된값
			String strDate = dateFormat.format(cal.getTime());

			// 캘린더에서 받아온 값이 6번째 값이 0인지 확인하기위함
			String strDateNum0 = strDate.substring(5, 6);

			if (strDateNum0.equals("0")) {

				strDate = strDate.substring(0, 5) + strDate.substring(6, 10);
				sales.setDate(strDate);


			} else {
				sales.setDate(strDate);

			}

			// 하나씩 더해줄 본인 일주일 매출 가져오기
			List<String> sales_List2 = DAO.sales_List2(sales);
			for (int j = 0; j < sales_List2.size(); j++) {
				sales_add += Integer.parseInt(sales_List2.get(j));
			}
			sales.setSales(sales_add);

			dateArray[i] = i+1+"주 전\n 일주일 매출 \n(7일기준)";
			salesArray[i] += sales.getSales();
			
			sales_add =0;
			// 일수 -1
			cal.add(Calendar.DATE, -1);
			sales.setDate(dateFormat.format(cal.getTime()));
		}
			sales.setDateArray(dateArray);
			sales.setSalesArray(salesArray);
		}
		return sales;
	}

//본인 한달 매출 
	public HS_NM_BEAN_sales_Chart sales_Chart_Select3(HS_NM_BEAN_sales_Chart sales) throws ParseException {
		
		String[] dateArray = new String[5];
		int[] salesArray = new int[5];

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String disigner_pid = TCKETING_DAO.disigner_pid(sales.getId());
		sales.setId(disigner_pid);
		
		// 캘린더 함수 생성
		Calendar cal = Calendar.getInstance();

		
		for (int i = 0; i < 5; i++) {

			//date의 일수없애고 년도와 월만 사용하기 월단위로 like를 하기위함
			String YYYY_MM = sales.getDate().substring(0, 7);

			cal.setTime(dateFormat.parse(sales.getDate()));

			//월 만 나타낼변수
			String MM = YYYY_MM.substring(5, 7);
			
			//월수에 0이 있는지 확인하는 변수
			String MM_Num0 = YYYY_MM.substring(5, 6);
			//월수에 0이있으면 0삭제
			if(MM_Num0.equals("0")) {
				YYYY_MM=YYYY_MM.substring(0, 5) + YYYY_MM.substring(YYYY_MM.length()-1, YYYY_MM.length());
			}else {
				YYYY_MM=YYYY_MM.substring(0, 5) + YYYY_MM.substring(YYYY_MM.length()-2, YYYY_MM.length());
			}
			
			//DAO로 보내줄 DATE값 저장
			sales.setDate(YYYY_MM+"%");
				
			// 본인 월 매출 가져오기
			String sales_List3 = DAO.sales_List3(sales);
			if(sales_List3==null) {
				sales_List3="0";
			}
			
			dateArray[i] = MM+"월\n 한달 매출";
			salesArray[i] += Integer.parseInt(sales_List3);
			System.out.println("asdas:"+salesArray[i]);
			
			// 월수 -1
			cal.add(Calendar.MONTH, -1);
			sales.setDate(dateFormat.format(cal.getTime()));
			
			sales.setDateArray(dateArray);
			sales.setSalesArray(salesArray);
		}
		
		return sales;
	}

//매장 하루 매출 
	public HS_NM_BEAN_sales_Chart sales_Chart_Select4(HS_NM_BEAN_sales_Chart sales) throws ParseException {
			
			String[] dateArray = new String[5];
			int[] salesArray = new int[5];

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

			String shop_pid = SHOP_DAO.belong_Shop(sales.getId());
			sales.setShop_pid(shop_pid);
			
			// 캘린더 함수 생성
			Calendar cal = Calendar.getInstance();

			
			for (int i = 0; i < 5; i++) {


				cal.setTime(dateFormat.parse(sales.getDate()));

				//월수 앞자리가 0인지 확인하는 변수 
				String Date_Num0=sales.getDate().substring(5, 6);
				
				//월수에 0이있으면 0삭제
				if(Date_Num0.equals("0")){
				sales.setDate(sales.getDate().substring(0, 5) 
						+ sales.getDate().substring(sales.getDate().length()-4, sales.getDate().length())); 
				}
				
				// 매장 일 매출 가져오기
				String sales_List4 = DAO.sales_List4(sales);
				if(sales_List4==null) {
					sales_List4="0";
				}
				
				dateArray[i] = sales.getDate();
				salesArray[i] = Integer.parseInt(sales_List4);
				
				// 일수 -1
				cal.add(Calendar.DATE, -1);
				sales.setDate(dateFormat.format(cal.getTime()));
				
				sales.setDateArray(dateArray);
				sales.setSalesArray(salesArray);
			}
			
			return sales;
		}

//매장 일주일 매출 
	public HS_NM_BEAN_sales_Chart sales_Chart_Select5(HS_NM_BEAN_sales_Chart sales) throws ParseException {
		
		String[] dateArray = new String[5];
		int[] salesArray = new int[5];

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String shop_pid = SHOP_DAO.belong_Shop(sales.getId());
		sales.setShop_pid(shop_pid);
		
		// 캘린더 함수 생성
		Calendar cal = Calendar.getInstance();

		
		for (int i = 0; i < 5; i++) {
			int sales_add = 0;

			for(int i2 = 0; i2 < 7; i2++) {

			cal.setTime(dateFormat.parse(sales.getDate()));

			// 캘린더에서 -1 된값
			String strDate = dateFormat.format(cal.getTime());

			// 캘린더에서 받아온 값이 6번째 값이 0인지 확인하기위함
			String strDateNum0 = strDate.substring(5, 6);

			if (strDateNum0.equals("0")) {

				strDate = strDate.substring(0, 5) + strDate.substring(6, 10);
				sales.setDate(strDate);


			} else {
				sales.setDate(strDate);

			}

			// 하나씩 더해줄 본인 일주일 매출 가져오기
			List<String> sales_List5 = DAO.sales_List5(sales);
			for (int j = 0; j < sales_List5.size(); j++) {
				sales_add += Integer.parseInt(sales_List5.get(j));
			}
			sales.setSales(sales_add);

			dateArray[i] = i+1+"주 전\n 일주일 매출 \n(7일기준)";
			salesArray[i] += sales.getSales();
			
			sales_add =0;
			// 일수 -1
			cal.add(Calendar.DATE, -1);
			sales.setDate(dateFormat.format(cal.getTime()));
		}
			sales.setDateArray(dateArray);
			sales.setSalesArray(salesArray);
		}
		return sales;
	}

//매장 한달 매출 
	public HS_NM_BEAN_sales_Chart sales_Chart_Select6(HS_NM_BEAN_sales_Chart sales) throws ParseException {
	
		String[] dateArray = new String[5];
		int[] salesArray = new int[5];

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String shop_pid = SHOP_DAO.belong_Shop(sales.getId());
		sales.setShop_pid(shop_pid);
		
		// 캘린더 함수 생성
		Calendar cal = Calendar.getInstance();

		
		for (int i = 0; i < 5; i++) {

			//date의 일수없애고 년도와 월만 사용하기 월단위로 like를 하기위함
			String YYYY_MM = sales.getDate().substring(0, 7);

			cal.setTime(dateFormat.parse(sales.getDate()));

			//월 만 나타낼변수
			String MM = YYYY_MM.substring(5, 7);
			
			//월수에 0이 있는지 확인하는 변수
			String MM_Num0 = YYYY_MM.substring(5, 6);
			//월수에 0이있으면 0삭제
			if(MM_Num0.equals("0")) {
				YYYY_MM=YYYY_MM.substring(0, 5) + YYYY_MM.substring(YYYY_MM.length()-1, YYYY_MM.length());
			}else {
				YYYY_MM=YYYY_MM.substring(0, 5) + YYYY_MM.substring(YYYY_MM.length()-2, YYYY_MM.length());
			}
			
			//DAO로 보내줄 DATE값 저장
			sales.setDate(YYYY_MM+"%");
				
			// 본인 월 매출 가져오기
			String sales_List6 = DAO.sales_List6(sales);
			if(sales_List6==null) {
				sales_List6="0";
			}
			
			dateArray[i] = MM+"월\n 한달 매출";
			salesArray[i] += Integer.parseInt(sales_List6);
			System.out.println("asdas:"+salesArray[i]);
			
			// 월수 -1
			cal.add(Calendar.MONTH, -1);
			sales.setDate(dateFormat.format(cal.getTime()));
			
			sales.setDateArray(dateArray);
			sales.setSalesArray(salesArray);
		}
		
		return sales;
	}

}