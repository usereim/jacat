package com.pro.jacat.mail.service;

import java.util.concurrent.ThreadLocalRandom;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	private final JavaMailSender mailSender;

	@Autowired
	public MailService(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public String sendMail(String email) {
		String code = null;
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			// ���� ���� �� ǥ�õ� �̸� ����
			messageHelper.setFrom("jsun3394@naver.com", "��Ĺ");
			// ���� ����
			messageHelper.setSubject("��Ĺ ������ȣ");
			// �ڵ� ���� ����
			messageHelper.setTo(email);
			// ������ �ڵ�
			code = Integer.toString(generateAuthNo());
			
			// ���� ����
			messageHelper.setText(code);
			// ���� ����
			mailSender.send(message);

		} catch (Exception e) {
			code = null;
			e.printStackTrace();
		}
		return code;
	}

	// 6�ڸ� ���� �����ϱ�
	public int generateAuthNo() {
		int code = ThreadLocalRandom.current().nextInt(100000, 1000000);
		return code;
	}

}
