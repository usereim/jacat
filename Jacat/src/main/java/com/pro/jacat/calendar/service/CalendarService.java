package com.pro.jacat.calendar.service;

import java.util.List;

import com.pro.jacat.calendar.vo.CalendarVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;

public interface CalendarService {
	void insertCalendarOne(CalendarVO calendar);
	List<CalendarVO> selectCalendarAll(String id);
	List<CalendarVO> selectCalendarAllByUsersId(CalendarVO calendar);
	void deleteCalendar(int dateNum);
	void updateCalendar(CalendarVO calendar);
	List<UsersFavoritesLicenseVO> selectLicenseTestDateAll(String id);

}
