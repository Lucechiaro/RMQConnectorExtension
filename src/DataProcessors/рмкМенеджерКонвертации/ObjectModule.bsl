#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

Функция ПолучитьДоступныеМетоды(Направление) Экспорт
	
	ИменаМетодов = Новый Массив;
	
	Если Направление = "Входящее" Тогда
		
		ИменаМетодов.Добавить("ВходящиеСообщения_ПрочитатьНоменклатуру");
		ИменаМетодов.Добавить("ВходящиеСообщения_ПрочитатьНоменклатуру_Простая");
		
	ИначеЕсли Направление = "Исходящее" Тогда
		
		ИменаМетодов.Добавить("ИсходящиеСообщения_СформироватьСообщение_Номенклатура");
		ИменаМетодов.Добавить("ИсходящиеСообщения_СформироватьСообщениеНоменклатура_Простая");
		
	ИначеЕсли Направление = "ИдентификаторыПолучателей" Тогда
		
		ИменаМетодов.Добавить("ИдентификаторыПолучателей_НоменклатураДляСкладов");
			
	КонецЕсли;
	
	Возврат ИменаМетодов;
	
КонецФункции

Процедура ВыполнитьМетод(ИмяМетода, Параметры) Экспорт
	
	Если ИмяМетода = "ИсходящиеСообщения_СформироватьСообщение_Номенклатура" Тогда
		ИсходящиеСообщения_СформироватьСообщение_Номенклатура(Параметры);
	ИначеЕсли ИмяМетода = "ВходящиеСообщения_ПрочитатьНоменклатуру" Тогда
		ВходящиеСообщения_ПрочитатьНоменклатуру(Параметры);
	ИначеЕсли ИмяМетода = "ИсходящиеСообщения_СформироватьСообщениеНоменклатура_Простая" Тогда
		ИсходящиеСообщения_СформироватьСообщениеНоменклатура_Простая(Параметры);
	ИначеЕсли ИмяМетода = "ВходящиеСообщения_ПрочитатьНоменклатуру_Простая" Тогда
		ВходящиеСообщения_ПрочитатьНоменклатуру_Простая(Параметры);	
	ИначеЕсли ИмяМетода = "ИдентификаторыПолучателей_НоменклатураДляСкладов" Тогда
		ИдентификаторыПолучателей_НоменклатураДляСкладов(Параметры);	
	Иначе
		ВызватьИсключение СтрШаблон("Не найден метод конвертации %1", ИмяМетода);
	КонецЕсли;	
	
КонецПроцедуры	

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ИсходящиеСообщения_СформироватьСообщение_Номенклатура(Параметры)
	
	ОбъектДляСериализации	= Параметры.ОбъектДляСериализации;
	ДанныеСообщения 		= Параметры.ДанныеСообщения;
	
	// задействуем платформенную сериализацию
	ДанныеСообщения.Вставить("Type", 	"SKU");
	ДанныеСообщения.Вставить("SerializationMetod", 	"SerializationMetod_1CXDTO");
	ДанныеСообщения.Вставить("Content", ОбъектДляСериализации);
	
КонецПроцедуры	

//@skip-check module-accessibility-at-client
Процедура ВходящиеСообщения_ПрочитатьНоменклатуру(КонтейнерСообщения)
	
	ПроверитьТипВходящегоСообщения(КонтейнерСообщения, "SKU");
	
	НоменклатураОбъект = КонтейнерСообщения.Content;
	УстановитьДополнительныеПараметрыЗаписиОбъета(НоменклатураОбъект);
	НоменклатураОбъект.Записать();
	
КонецПроцедуры

Процедура ИсходящиеСообщения_СформироватьСообщениеНоменклатура_Простая(Параметры)
	
	ОбъектДляСериализации	= Параметры.ОбъектДляСериализации;
	ДанныеСообщения 		= Параметры.ДанныеСообщения;
	
	ДанныеСообщения.Вставить("Type", 	"SKU");
	ДанныеСообщения.Вставить("SerializationMetod", 	"Simple");
	
	СтруктураНоменклатуры = Новый Структура();
	СтруктураНоменклатуры.Вставить("UUID", XMLСтрока(ОбъектДляСериализации.Ссылка));
	СтруктураНоменклатуры.Вставить("Name", ОбъектДляСериализации.Наименование);
	СтруктураНоменклатуры.Вставить("PLU", 	ОбъектДляСериализации.Артикул);
	СтруктураНоменклатуры.Вставить("Description", ОбъектДляСериализации.Описание);
	
	ДанныеСообщения.Вставить("Content", СтруктураНоменклатуры);
	
КонецПроцедуры	

Процедура ВходящиеСообщения_ПрочитатьНоменклатуру_Простая(КонтейнерСообщения)
	
	ПроверитьТипВходящегоСообщения(КонтейнерСообщения, "SKU");
	
	ДанныеНоменклатуры = КонтейнерСообщения.Content;
	Ссылка = рмкОбщегоНазначения.СсылкаПоУникальномуИдентификатору("Справочники.Тест_Номенклатура1", ДанныеНоменклатуры.UUID);
	
	Если рмкОбщегоНазначенияПереопределяемый.СсылкаСуществует(Ссылка) Тогда
		НоменклатураОбъект = Ссылка.ПолучитьОбъект();
	Иначе
		НоменклатураОбъект = Справочники.Тест_Номенклатура1.СоздатьЭлемент();
		НоменклатураОбъект.УстановитьСсылкуНового(Ссылка);	
	КонецЕсли;	
	
	НоменклатураОбъект.Артикул 		= ДанныеНоменклатуры.PLU;
	НоменклатураОбъект.Наименование = ДанныеНоменклатуры.Name;
	НоменклатураОбъект.Описание 	= ДанныеНоменклатуры.Description;
	
	УстановитьДополнительныеПараметрыЗаписиОбъета(НоменклатураОбъект);
	НоменклатураОбъект.Записать();
	
КонецПроцедуры

// в параметрах ожидаем структуру в составе
// "Объект" - сериализуемый объект
// "МассивПолучателей" - пустой массив, который мы должны заполнить в этом методе
Процедура ИдентификаторыПолучателей_НоменклатураДляСкладов(Параметры)
	
	// пример
	Параметры.МассивПолучателей.Добавить("Stock1");
	Параметры.МассивПолучателей.Добавить("Stock2");
	
КонецПроцедуры	

Процедура ПроверитьТипВходящегоСообщения(КонтейнерСообщения, ИмяТипа)
	
	ТипКорректен = КонтейнерСообщения.Свойство("Type") И СтрСравнить(КонтейнерСообщения.Type, ИмяТипа) = 0;
	
	Если Не ТипКорректен Тогда
		ВызватьИсключение СтрШаблон("Сообщение не содержит ожидаемый тип ""%1""", ИмяТипа);
	КонецЕсли;	
	
КонецПроцедуры	

Процедура УстановитьДополнительныеПараметрыЗаписиОбъета(ЗаписываемыйОбъект)
	
	ЗаписываемыйОбъект.ОбменДанными.Загрузка = Истина;
		
КонецПроцедуры	

#КонецОбласти

#КонецЕсли