
<cfprocessingdirective pageEncoding="utf-8"> <!--- important ! --->

<cfsavecontent variable="content">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <!--- important ! --->

  Arabic ما هي الشفرة الموحدة ;يونِكود ؟ <br />
  ইউনিকোড কী? Bangla <br />
  什么是Unicode(统一码)? Chinese (Simplified ) <br />
  什麽是Unicode(統一碼/標準萬國碼) Chinese (Traditional) <br />
  Co je Unicode? Czech <br />
  Mi povas manĝi vitron, ĝi ne damaĝas min. Esperanto <br />
  Farsi يونیکُد چيست؟ <br />
  Mikä on Unicode? Finnish <br />
  Qu'est ce qu'Unicode? French <br />
  რა არის უნიკოდი? Georgian <br />
  Τι είναι το Unicode Greek <br />
   Hebrew אני יכול לאכול זכוכית וזה לא מזיק לי. <br />
  मैं काँच खा सकता हूँ, मुझे उस से कोई पीडा नहीं होती. Hindi <br />
  Tá mé in ann gloine a ithe; Ní chuireann sé isteach nó amach orm. Irish <br />
  Cos'è Unicode? Italian <br />
  ユニコードとは何か Japanese <br />
  유니코드에 대해 Korean <br />
  Можам да јадам стакло, а не ме штета. Macedonian <br />
  O que é Unicode? Portuguese <br />
  Что такое Unicode? Russian <br />
  ¿Qué es Unicode? Spanish <br />
  யூனிக்கோடு என்றாலயூனிக்கோடு என்றால் என்ன? Tamil <br />
  యూనీకోడ్ అంటే ఏమిటి? Telugu <br />
  Unicode คืออะไร Thai <br />
  Я можу їсти шкло, й воно мені не пошкодить. Ukrainian <br />
  Tôi có thể ăn thủy tinh mà không hại gì. Vietnamese  <br />
</cfsavecontent>

<cfscript>

  wkhtmltopdf = new Wkhtmltopdf();
  pdf = wkhtmltopdf.fromString(content, { 'pageSize': 'A5' });

</cfscript>

<cfcontent type="application/pdf" variable="#pdf#">
