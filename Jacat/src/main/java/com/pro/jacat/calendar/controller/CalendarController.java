package com.pro.jacat.calendar.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.calendar.service.CalendarServiceImpl;
import com.pro.jacat.calendar.vo.CalendarVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	private CalendarServiceImpl calendarService;
	
	public CalendarController(CalendarServiceImpl calendarService) {
		this.calendarService = calendarService;
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String calendar() {
		
		return "calendar/calendar";
	}
	
	@PostMapping("/add-event")
	@ResponseBody
	public String addEvent(CalendarVO calendar) {
		
		logger.info(calendar.getUsersId());
		logger.info(calendar.getStartDate());
		calendarService.insertCalendarOne(calendar);
		
		return "success";
	}
	
	@PostMapping("/list")
	@ResponseBody
	public List<CalendarVO> list(@RequestParam("id") String id) {
		return calendarService.selectCalendarAll(id);
	}
	
	@PostMapping("/test-date-list")
	@ResponseBody
	public List<UsersFavoritesLicenseVO> testDateList(@RequestParam("id") String id) {
		return calendarService.selectLicenseTestDateAll(id);
	}
	
	@PostMapping("/view")
	@ResponseBody
	public List<CalendarVO> view(@RequestParam("selectedDay") String selectedDay,
			HttpSession session) {
		CalendarVO calendar = new CalendarVO();
		UserVO user = (UserVO)session.getAttribute("user");
		
		if (user == null) {
			return null;
		}
		
		calendar.setUsersId(user.getId());
		calendar.setStartDate(selectedDay);
		
		return calendarService.selectCalendarAllByUsersId(calendar);
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam("dateNum") int dateNum) {
		calendarService.deleteCalendar(dateNum);
		
		return "success";
	}
	
	@PostMapping("/modify")
	@ResponseBody
	public String modify(CalendarVO calendar) {
		calendarService.updateCalendar(calendar);
		
		return "success";
	}
	
}
