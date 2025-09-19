package com.pro.jacat.calendar.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.jacat.calendar.vo.CalendarVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;

@Repository
public class CalendarRepository {
	private final SqlSession template;
	
	public CalendarRepository(SqlSession template) {
		this.template = template;
	}

	public void insertCalendarOne(CalendarVO calendar) {
		template.insert("calendarMapper.insertCalendarOne", calendar);
	}

	public List<CalendarVO> selectCalendarAll(String id) {
		return template.selectList("calendarMapper.selectCalendarAll", id);
	}

	public List<CalendarVO> selectCalendarAllByUsersId(CalendarVO calendar) {
		return template.selectList("calendarMapper.selectCalendarAllByUsersId", calendar);
	}

	public void deleteCalendar(int dateNum) {
		template.delete("calendarMapper.deleteCalendar", dateNum);
		
	}

	public void updateCalendar(CalendarVO calendar) {
		template.update("calendarMapper.updateCalendar", calendar);
		
	}

	public List<UsersFavoritesLicenseVO> selectLicenseTestDateAll(String id) {
		return template.selectList("calendarMapper.selectLicenseTestDateAll", id);
	}
}
