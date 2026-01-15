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

public class Registration_MailSender {
	public static void send(String to, String userName) throws MessagingException {

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
                        "omgeipgbhtwrxfrt"
                    );
                }
            }
        );

        // メール作成
        try {
            // --- 4. メールメッセージ作成 ---
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("t.h3733@gmail.com", "サイト運営者")); // 送信元
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));        // 宛先
            msg.setSubject("【登録完了】ご登録ありがとうございます");// 件名
            String body = userName + " 様\n\n"
                    + "この度はご登録ありがとうございます。\n"
                    + "ユーザ登録が正常に完了しました。\n\n"
                    + "今後ともよろしくお願いいたします。";

            msg.setText(body);                                                          // 本文（プレーンテキスト）

            // --- 5. メール送信 ---
            Transport.send(msg);

            System.out.println("会員登録完了メールを送信しました：" + to);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
