package service;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import dao.MenuDao;
import model.Menu;
import model.Reservation;

public class ReserveRegistration_MailSender {
	public static void send(String to, Reservation r) throws MessagingException {

		// SMTP 設定（例：Gmail）
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// 認証情報
		Session session = Session.getInstance(props,
				new Authenticator() {
					@Override
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(
								"t.h3733@gmail.com",
								"omgeipgbhtwrxfrt");
					}
				});

		// メール作成
		try {
			// --- 4. メールメッセージ作成 ---
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("t.h3733@gmail.com", "サイト運営者")); // 送信元
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 宛先
			msg.setSubject("【予約完了】ご予約ありがとうございます");// 件名
			String rt=r.getReservationType();
			String body = r.getCustomerName() + " 様\n\n"
			        + "この度はご予約ありがとうございます。\n"
			        + "以下の内容で予約を受け付けました。\n\n"
			        + "予約日：" + r.getReservationDate()
			        + "  予約時間：" + r.getStartTime() + "\n"
			        + "人数　大人：" + r.getAdultCount() + "名　子供：" + r.getChildCount() + "名 \n"
			        + "予約タイプ：" + rt + "\n";

			if ("COURSE".equals(rt)) {
			    int menuId = r.getCourseId();
			    MenuDao md = new MenuDao();
			    Menu m = md.findById1(menuId);

			    if (m != null) {
			        body += "コース名：" + m.getMenuName() + "\n";
			    }
			}

			body += "\n今後ともよろしくお願いいたします。";

			msg.setText(body); // 本文（プレーンテキスト）

			// --- 5. メール送信 ---
			Transport.send(msg);

			System.out.println("予約完了メールを送信しました：" + to);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
