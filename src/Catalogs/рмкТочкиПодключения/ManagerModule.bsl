#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция УзелТочкиПодключения(ТочкаПодключения) Экспорт
	
	ИменаРеквизитовТочки = "ИмяПланаОбмена,УИДУзлаОбмена";
	РеквизитыТочкиПодключения = рмкОбщегоНазначенияПереопределяемый.ЗначенияРеквизитовОбъекта(ТочкаПодключения, ИменаРеквизитовТочки); 
	
	Возврат ПланыОбмена[РеквизитыТочкиПодключения.ИмяПланаОбмена].ПолучитьСсылку(РеквизитыТочкиПодключения.УИДУзлаОбмена);
	
КонецФункции	

#КонецОбласти

#КонецЕсли