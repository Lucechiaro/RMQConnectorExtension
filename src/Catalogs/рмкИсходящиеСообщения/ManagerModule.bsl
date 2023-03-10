#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СписокРеквизитов = "ТочкаПодключения,Код,ДатаСоздания";
	РеквизитыСообщения = рмкОбщегоНазначенияПереопределяемый.ЗначенияРеквизитовОбъекта(Данные.Ссылка, СписокРеквизитов);
	ИмяТочки = рмкОбщегоНазначенияПереопределяемый.ЗначениеРеквизитаОбъекта(РеквизитыСообщения.ТочкаПодключения, "ИмяТочки");
	Представление = СтрШаблон("%1 %2 %3", ИмяТочки, РеквизитыСообщения.ДатаСоздания, РеквизитыСообщения.Код);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли