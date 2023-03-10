#Область СлужебныйПрограммныйИнтерфейс
	
Функция ЗначениеРеквизитаОбъекта(Объект, ИмяРеквизита) Экспорт

	// в конфигурации на БСП заменить на вызов метода "ОбщегоНазначения.ЗначениеРеквизитаОбъекта"	
	Возврат Объект[ИмяРеквизита];
	
КонецФункции	

Функция ЗначенияРеквизитовОбъекта(Объект, ИменаРеквизитов) Экспорт

	// в конфигурации на БСП заменить на вызов метода "ОбщегоНазначения.ЗначениеРеквизитаОбъекта"	
	ЗначенияРеквизитов = Новый Структура(ИменаРеквизитов);
	
	Для Каждого КлючИЗначение Из ЗначенияРеквизитов Цикл
		ЗначенияРеквизитов.Вставить(КлючИЗначение.Ключ, Объект[КлючИЗначение.Ключ]);
	КонецЦикла; 
	
	Возврат ЗначенияРеквизитов;
	
КонецФункции

Функция СсылкаСуществует(Ссылка) Экспорт
	
	ПолноеИмяМетаданных = Ссылка.Метаданные().ПолноеИмя();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	1
	|ИЗ
	|	" + ПолноеИмяМетаданных + " КАК Таблица
	|ГДЕ
	|	Таблица.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

Функция ТекущийПользователь() Экспорт
	
	Возврат ИмяПользователя();
	
КонецФункции

Процедура СообщитьПользователю(ТекстСообщения) Экспорт
	
	Сообщение = Новый СообщениеПользователю();
	Сообщение.Текст = ТекстСообщения;
	Сообщение.Сообщить();
	
КонецПроцедуры	

Функция ОбъектИсключенИзРепликации(МетаданныеОбъекта) Экспорт
	
	ОбъектИсключенИзРепликации = Метаданные.Подсистемы.рмкRMQConnector.Состав.Содержит(МетаданныеОбъекта);
	
	Возврат ОбъектИсключенИзРепликации;
	
КонецФункции	

Процедура ПриНачалеВыполненияРегламентногоЗадания(МетаданныеЗадания = Неопределено) Экспорт
	
	Если Не рмкОбщегоНазначения.РазрешенаРаботаВКопииБазы() Тогда
		// TODO заблокировать работу в копии при отсутствиии специального разрешения	
	КонецЕсли;	
	
КонецПроцедуры	

Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки)  Экспорт
	
	Зависимость = Настройки.Добавить();
	Зависимость.РегламентноеЗадание = Метаданные.РегламентныеЗадания.рмкОтправкаИсходящихСообщений;
	Зависимость.РаботаетСВнешнимиРесурсами 	= Истина;
	Зависимость.ДоступноВПодчиненномУзлеРИБ = Истина;
	
	Зависимость = Настройки.Добавить();
	Зависимость.РегламентноеЗадание = Метаданные.РегламентныеЗадания.рмкПолучениеСообщенийИзОчередей;
	Зависимость.РаботаетСВнешнимиРесурсами 	= Истина;
	Зависимость.ДоступноВПодчиненномУзлеРИБ = Истина
	
КонецПроцедуры

Функция ИдентификаторОтправителя() Экспорт
	
	Возврат СтрокаСоединенияИнформационнойБазы();
	
КонецФункции

#КонецОбласти