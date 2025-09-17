package com.pro.jacat.calendar.controller;

import java.util.List;

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
		calendarService.insertCalendarOne(calendar);
		
		return "success";
	}
	
	@PostMapping("/list")
	@ResponseBody
	public List<CalendarVO> list(@RequestParam("id") String id) {
		return calendarService.selectCalendarAll(id);
	}
}
