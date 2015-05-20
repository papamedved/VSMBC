/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * 
 *                    
 */

import lrapi.lr;
import org.apache.commons.mail.*;     			//Необходима библиотека commons-email-1.3.3.jar (находится в корне скрипта)
import javax.mail.MessagingException; 			//Необходима библиотека javamail-1.4.1.jar (находится в корне скрипта)
import java.io.*;					//
import org.w3c.dom.Document;				//
import org.w3c.dom.Element;				//
import javax.xml.parsers.DocumentBuilder;		//
import javax.xml.parsers.DocumentBuilderFactory;	// Зависимости JDK 1.6
import javax.xml.transform.OutputKeys;			//
import javax.xml.transform.Transformer;			//
import javax.xml.transform.TransformerFactory;		//
import javax.xml.transform.dom.DOMSource;		//
import javax.xml.transform.stream.StreamResult;		//
import java.util.Random;				//
import java.util.UUID;					//
import java.util.ArrayList;				//
import java.util.List;					// 

public class Actions
{
	//
	// Генерируем уникальный идентификатор рассылки
	// 
	UUID uuid = UUID.randomUUID();

	//
	// Переменные email
	// 
	String EMAIL_HOSTNAME = "mail.myserver.com"; 		  //Хост сервера
	String EMAIL_ADDTO_EMAIL = "jdoe@somewhere.org"; 	  //Адрес получателя
	String EMAIL_ADDTO_NAME = "John Doe"; 			  //Имя получателя
	String EMAIL_FROM_EMAIL = "smbc@bell-integrator.ru"; 	  //Адрес отправителя
	String EMAIL_FROM_NAME = "Bell"; 			  //Имя отправителя
	String EMAIL_BILL_THEME = "Bill_"+ uuid;		  //Тема письма
	String EMAIL_ONE_THEME = "One_"+ uuid;			  //Тема письма
	String EMAIL_PERIODIC_THEME = "Periodic_"+ uuid;	  //Тема письма
	String EMAIL_MESSAGE = "Сумма Вашего счета {AMOUNT}$,"  + //Текст сообщения
				" оплата до {INV_DUE_DATE}. "   +
				"В рублях тел 067404 & Сумма "  +
				"Вашей скидки за период {DATE1}"+
				" – {DATE2} {DISCOUNT}$";  

	String FILE_EMAIL_SAVE_PATH = "c:\\Users\\Sergey\\message.eml"; //Путь сохранения файла сообщения в формате RFC
	String FILE_PHONELIST_SAVE_PATH = "c:\\Users\\Sergey\\phonelist.txt"; //Путь сохранения файла phonelist
	//
	// Переменные xml
	// 
	String FILE_SMBC_XML_SAVE_PATH = "C:\\Users\\Sergey\\smbc.xml";

	public String SMBC_ISS_ID = "One+" + uuid;
	public String SMBC_NAME = "One_" + uuid;
	public String SMBC_ISUNICODE = "1";
	public String SMBC_ISLENGTHY = "1";
        public String SMBC_CRM_EXPORT = "1"; //????
        public String SMBC_PERSONALIZATION = "1"; //????
	public String SMBC_INITIATOR_ISS_ID = "test_001";
	public String SMBC_ASSISTANT_ISS_ID = "test_001";

	public String SMBC_DISPATCH_FROM = "2007-07-01";
	public String SMBC_DISPATCH_TO = "2007-07-26";
	public String SMBC_DISPATCH_ZONE = "0";

	String SMBC_SMS_BILL = "Сумма Вашего счета {AMOUNT}$,"  + //Текст сообщения
				" оплата до {INV_DUE_DATE}. "   +
				"В рублях тел 067404 & Сумма "  +
				"Вашей скидки за период {DATE1}"+
				" – {DATE2} {DISCOUNT}$"; 
	String SMBC_SMS_ONE_PART_WITHOUT_TEMPLATE = "Это одна часть сообщения, в которой 70 символов кириллических символов";
	String SMBC_SMS_TWO_PARTS_WITHOUT_TEMPLATE = "Это первая часть сообщения, где 67 символов кириллических символов.|" +
							"Это вторая часть сообщения, где 67 символов кириллических символов.";
	String SMBC_SMS_THREE_PARTS_WITHOUT_TEMPLATE = "Это первая часть сообщения, где 67 символов кириллических символов.|" +
							"Это вторая часть сообщения, где 67 символов кириллических символов.|" +
							"Это третья часть сообщения, где 67 символов кириллических символов.";
	String SMBC_SMS_FOUR_PARTS_WITHOUT_TEMPLATE = "Это первая часть сообщения, где 67 символов кириллических символов.|" +
							"Это вторая часть сообщения, где 67 символов кириллических символов.|" +
							"Это третья часть сообщения, где 67 символов кириллических символов.|" +
							"Это четвертая част сообщения где 67 символов кириллических символов";

	String SMBC_SMS_ONE_PART_WITH_TEMPLATE = "Это первая часть сообщения от {variable1} для {variable2} {variable3}";
	String SMBC_SMS_TWO_PARTS_WITH_TEMPLATE = "Это первая часть сообщения от {variable1} для {variable2} {variable3}|"+
							"Это вторая часть сообщения от {variable1} для {variable2} {variable3}";
	String SMBC_SMS_THREE_PARTS_WITH_TEMPLATE = "Это первая часть сообщения от {variable1} для {variable2} {variable3}|"+
							"Это вторая часть сообщения от {variable1} для {variable2} {variable3}|" +
							"Это третья часть сообщения от {variable1} для {variable2} {variable3}";
	String SMBC_SMS_FOUR_PARTS_WITH_TEMPLATE = "Это первая часть сообщения от {variable1} для {variable2} {variable3}|"+
							"Это вторая часть сообщения от {variable1} для {variable2} {variable3}|" +
							"Это третья часть сообщения от {variable1} для {variable2} {variable3}|" +
							"Это четвертая часть сообщения от {variable1} для {variable2} {variable3}";

	////////////////////////////////////////////////////
	// ОСНОВНЫЕ ПАРАМЕТРЫ РАССЫЛКИ			  //
	////////////////////////////////////////////////////
	// ONE     - 0,
	// PERIODIC -1,
	// BILL    - 2
	public int SMBC_TYPE = 0;
	////////////////////////////////////////////////////
	String SMBC_DISPATCH_RATE = "1";		  //
	////////////////////////////////////////////////////
	String SMBC_DISPATCH_PRIORITY = "3";		  //
	////////////////////////////////////////////////////
	int COUNT_PHONE_NUMBER = 4333;		  //
	////////////////////////////////////////////////////
        int    PART_COUNT = 2;                            //
        ////////////////////////////////////////////////////
        int WITH_TEMPLATE = 0;                            //
        ////////////////////////////////////////////////////

	String SMBC_WEEKDAYS_DAYS = "mon-sun";

	String SMBC_TIMESLICE_HOUR_FROM = "8";
	String SMBC_TIMESLICE_HOUR_TO = "22";

	public int init() throws Throwable {

	    return 0;
	}//end of init


	public int action() throws Throwable {

            //
	    // Создание xml файла smbc
	    // 
	    switch (SMBC_TYPE) {
	    case 0:
		createOneXML();
		break;
	    case 1:
		createPeriodicXML();
		break;
	    case 2:
		createBillXML();
		break;
	    }


	    //
            // Прикрепляем xml вложением
	    // 
	    EmailAttachment attachment = new EmailAttachment();
	    attachment.setPath(FILE_SMBC_XML_SAVE_PATH);
	    attachment.setDisposition(EmailAttachment.ATTACHMENT);
	    attachment.setDescription("Picture of John");
	    attachment.setName("John");

	    //
	    // Создание сообщения
	    // 
	    MultiPartEmail email = new MultiPartEmail();
	    email.setHostName(EMAIL_HOSTNAME);
	    try {
		email.addTo(EMAIL_ADDTO_EMAIL, EMAIL_ADDTO_NAME);
		email.setFrom(EMAIL_FROM_EMAIL, EMAIL_FROM_NAME);

		switch (WITH_TEMPLATE) {
		    case 0:
			switch (PART_COUNT) {
			    case 1:
				email.setMsg(SMBC_SMS_ONE_PART_WITHOUT_TEMPLATE);
				break;
			    case 2:
				email.setMsg(SMBC_SMS_TWO_PARTS_WITHOUT_TEMPLATE);
				break;
			    case 3:
				email.setMsg(SMBC_SMS_THREE_PARTS_WITHOUT_TEMPLATE);
				break;
			    case 4:
				email.setMsg(SMBC_SMS_FOUR_PARTS_WITHOUT_TEMPLATE);
				break;
			}
			break;
	
		    case 1:
			switch (PART_COUNT) {
			    case 1:
				email.setMsg(SMBC_SMS_ONE_PART_WITH_TEMPLATE);
				break;
			    case 2:
				email.setMsg(SMBC_SMS_TWO_PARTS_WITH_TEMPLATE);
				break;
			    case 3:
				email.setMsg(SMBC_SMS_THREE_PARTS_WITH_TEMPLATE);
				break;
			    case 4:
				email.setMsg(SMBC_SMS_FOUR_PARTS_WITH_TEMPLATE);
				break;
			}
			break;
		}


		switch (SMBC_TYPE) {
		    case 0:
			email.setSubject(EMAIL_ONE_THEME);
			break;
		    case 1:
			
			break;
		    case 2:
			email.setSubject(EMAIL_BILL_THEME);
			break;
		}
                email.attach(attachment);
		
	    } catch (EmailException e) {
		e.printStackTrace();
	    }
	    
    
	    //
	    // Сохранение сообдщения в файл
	    // 	    
	    saveToFile(FILE_EMAIL_SAVE_PATH, email);

	    //
	    //	Генерируем первый номер телефона 
	    // 

	    File file = new File(FILE_PHONELIST_SAVE_PATH);
	    OutputStream outputStream = null;
	    outputStream = new FileOutputStream(file);
	    file.createNewFile();
	    

	    Random random = new Random();
	    int partPhoneNumber = random.nextInt(99999999 - 10000000 + 1) + 10000000;

	    List<String> listPhoneList = new ArrayList<String>();
		
	    switch (WITH_TEMPLATE) {
		case 0:
		    for (int i = 1; i <= COUNT_PHONE_NUMBER; i++) {
			//lr.output_message("90"+String.valueOf(partPhoneNumber));
			listPhoneList.add("90"+String.valueOf(partPhoneNumber));
			partPhoneNumber += 1;
		    }
		    break;
    
		case 1:
		    for (int i = 1; i <= COUNT_PHONE_NUMBER; i++) {
			//lr.output_message("90"+String.valueOf(partPhoneNumber)+"|"+"26.12"+"|"+"80"+"|"+"Иван"+"|"+"Петрович");
			listPhoneList.add("90"+String.valueOf(partPhoneNumber)+"|"+"26.12"+"|"+"80"+"|"+"Иван"+"|"+"Петрович");
			partPhoneNumber += 1;
		    }
		    break;
	    }	    
	    savePhoneList(FILE_PHONELIST_SAVE_PATH, listPhoneList);


		return 0;
	}//end of action


	public int end() throws Throwable {
		return 0;
	}//end of end

	public int createBillXML(){
	    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder documentBuilder;
	    try {
		documentBuilder = documentBuilderFactory.newDocumentBuilder();
		Document document = documentBuilder.newDocument();
		document.setXmlStandalone(true);
    
		Element mainRootElement = document.createElementNS(null, "smbc");
		mainRootElement.setAttribute("type", String.valueOf(SMBC_TYPE));
		mainRootElement.setAttribute("iss_id", SMBC_ISS_ID);
		mainRootElement.setAttribute("name", SMBC_NAME);
		mainRootElement.setAttribute("isunicode", SMBC_ISUNICODE);
		mainRootElement.setAttribute("islengthy", SMBC_ISLENGTHY);
		mainRootElement.setAttribute("initiator_iss_id", SMBC_INITIATOR_ISS_ID);
		mainRootElement.setAttribute("assistant_iss_id", SMBC_ASSISTANT_ISS_ID);
		document.appendChild(mainRootElement);
    
		    Element dispatch = document.createElement("dispatch");
		    dispatch.setAttribute("from", SMBC_DISPATCH_FROM);
		    dispatch.setAttribute("to", SMBC_DISPATCH_TO);
		    dispatch.setAttribute("zone", SMBC_DISPATCH_ZONE);
		    dispatch.setAttribute("rate", SMBC_DISPATCH_RATE);
		    dispatch.setAttribute("priority", SMBC_DISPATCH_PRIORITY);
		    mainRootElement.appendChild(dispatch);
    
			Element weekdays = document.createElement("weekdays");
			weekdays.setAttribute("days", SMBC_WEEKDAYS_DAYS);
			dispatch.appendChild(weekdays);
    
			    Element timeslice = document.createElement("timeslice");
			    timeslice.setAttribute("hour_from", SMBC_TIMESLICE_HOUR_FROM);
			    timeslice.setAttribute("hour_to", SMBC_TIMESLICE_HOUR_TO);
			    weekdays.appendChild(timeslice);
    
		// output DOM XML to console
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty(OutputKeys.ENCODING, "windows-1251");
    
		DOMSource source = new DOMSource(document);
    
		File xmlSmbcFile = new File(FILE_SMBC_XML_SAVE_PATH);
		OutputStream outputStream = new FileOutputStream(xmlSmbcFile);
    
		StreamResult console = new StreamResult(outputStream);
		transformer.transform(source, console);
    
		lr.output_message("\nXML DOM Created Successfully..");
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    return 1;
	}

	public int createOneXML(){
	    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder documentBuilder;
	    try {
		documentBuilder = documentBuilderFactory.newDocumentBuilder();
		Document document = documentBuilder.newDocument();
		document.setXmlStandalone(true);
    
		Element mainRootElement = document.createElementNS(null, "smbc");
		mainRootElement.setAttribute("type", String.valueOf(SMBC_TYPE));
		mainRootElement.setAttribute("iss_id", SMBC_ISS_ID);
		mainRootElement.setAttribute("name", SMBC_NAME);
		mainRootElement.setAttribute("isunicode", SMBC_ISUNICODE);
		mainRootElement.setAttribute("islengthy", SMBC_ISLENGTHY);
                mainRootElement.setAttribute("crm_export", SMBC_CRM_EXPORT);
                mainRootElement.setAttribute("personalization", SMBC_PERSONALIZATION);
		mainRootElement.setAttribute("initiator_iss_id", SMBC_INITIATOR_ISS_ID);
		mainRootElement.setAttribute("assistant_iss_id", SMBC_ASSISTANT_ISS_ID);
		document.appendChild(mainRootElement);
    
		    Element dispatch = document.createElement("dispatch");
		    dispatch.setAttribute("from", SMBC_DISPATCH_FROM);
		    dispatch.setAttribute("to", SMBC_DISPATCH_TO);
		    dispatch.setAttribute("zone", SMBC_DISPATCH_ZONE);
		    dispatch.setAttribute("rate", SMBC_DISPATCH_RATE);
		    dispatch.setAttribute("priority", SMBC_DISPATCH_PRIORITY);
		    mainRootElement.appendChild(dispatch);
    
			Element weekdays = document.createElement("weekdays");
			weekdays.setAttribute("days", SMBC_WEEKDAYS_DAYS);
			dispatch.appendChild(weekdays);
    
			    Element timeslice = document.createElement("timeslice");
			    timeslice.setAttribute("hour_from", SMBC_TIMESLICE_HOUR_FROM);
			    timeslice.setAttribute("hour_to", SMBC_TIMESLICE_HOUR_TO);
			    weekdays.appendChild(timeslice);
    
		// output DOM XML to console
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty(OutputKeys.ENCODING, "windows-1251");
    
		DOMSource source = new DOMSource(document);
    
		File xmlSmbcFile = new File(FILE_SMBC_XML_SAVE_PATH);
		OutputStream outputStream = new FileOutputStream(xmlSmbcFile);
    
		StreamResult console = new StreamResult(outputStream);
		transformer.transform(source, console);
    
		lr.output_message("\nXML DOM Created Successfully..");
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    return 1;
	}

	public int createPeriodicXML(){
	    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder documentBuilder;
	    try {
		documentBuilder = documentBuilderFactory.newDocumentBuilder();
		Document document = documentBuilder.newDocument();
		document.setXmlStandalone(true);
    
		Element mainRootElement = document.createElementNS(null, "smbc");
		mainRootElement.setAttribute("type", String.valueOf(SMBC_TYPE));
		mainRootElement.setAttribute("iss_id", SMBC_ISS_ID);
		mainRootElement.setAttribute("name", SMBC_NAME);
		mainRootElement.setAttribute("isunicode", SMBC_ISUNICODE);
		mainRootElement.setAttribute("islengthy", SMBC_ISLENGTHY);
                mainRootElement.setAttribute("crm_export", SMBC_CRM_EXPORT);
                mainRootElement.setAttribute("personalization", SMBC_PERSONALIZATION);
		mainRootElement.setAttribute("initiator_iss_id", SMBC_INITIATOR_ISS_ID);
		mainRootElement.setAttribute("assistant_iss_id", SMBC_ASSISTANT_ISS_ID);
		document.appendChild(mainRootElement);
    
		    Element dispatch = document.createElement("dispatch");
		    dispatch.setAttribute("from", SMBC_DISPATCH_FROM);
		    dispatch.setAttribute("to", SMBC_DISPATCH_TO);
		    dispatch.setAttribute("zone", SMBC_DISPATCH_ZONE);
		    dispatch.setAttribute("rate", SMBC_DISPATCH_RATE);
		    dispatch.setAttribute("priority", SMBC_DISPATCH_PRIORITY);
		    mainRootElement.appendChild(dispatch);
    
			Element weekdays = document.createElement("weekdays");
			weekdays.setAttribute("days", SMBC_WEEKDAYS_DAYS);
			dispatch.appendChild(weekdays);
    
			    Element timeslice = document.createElement("timeslice");
			    timeslice.setAttribute("hour_from", SMBC_TIMESLICE_HOUR_FROM);
			    timeslice.setAttribute("hour_to", SMBC_TIMESLICE_HOUR_TO);
			    weekdays.appendChild(timeslice);
    
		// output DOM XML to console
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty(OutputKeys.ENCODING, "windows-1251");
    
		DOMSource source = new DOMSource(document);
    
		File xmlSmbcFile = new File(FILE_SMBC_XML_SAVE_PATH);
		OutputStream outputStream = new FileOutputStream(xmlSmbcFile);
    
		StreamResult console = new StreamResult(outputStream);
		transformer.transform(source, console);
    
		lr.output_message("\nXML DOM Created Successfully..");
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    return 1;
	}
	public int saveToFile(String PATH, MultiPartEmail email) {

	    File file = new File(PATH);
	    OutputStream outputStream = null;
	    try {
		outputStream = new FileOutputStream(file);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    if (!file.exists()) {
		try {
		    file.createNewFile();
		} catch (IOException e) {
		    e.printStackTrace();
		}
	    }
    
	    try {
		email.buildMimeMessage();
	    } catch (EmailException e) {
		e.printStackTrace();
	    }
	    try {
		email.getMimeMessage().writeTo(outputStream);
		lr.output_message("\nEmail and attachment has created..");
	    } catch (IOException e) {
		e.printStackTrace();
	    } catch (MessagingException e) {
		e.printStackTrace();
	    }

	    return 1;
	}

	public int savePhoneList(String PATH, List<String> phoneList){

	    FileOutputStream fileOutputStream = null;
	    File file;
	    String content = "This is the text content";
    
	    try {
    
		file = new File(PATH);
		fileOutputStream = new FileOutputStream(file);
    
		// if file doesnt exists, then create it
		if (!file.exists()) {
		    file.createNewFile();
		}
    
		// get the content in bytes
		byte[] contentInBytes = content.getBytes();
    
                for (String item : phoneList) {
		    fileOutputStream.write((item+"\n").getBytes());
		}

		fileOutputStream.flush();
		fileOutputStream.close();
    
		System.out.println("Done");
    
	    } catch (IOException e) {
		e.printStackTrace();
	    } finally {
		try {
		    if (fileOutputStream != null) {
			fileOutputStream.close();
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		}
	    }

	    return 1;
	}
}
