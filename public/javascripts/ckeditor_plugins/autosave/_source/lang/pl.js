/*
 * Copyright (c) 2003-2011, CKSource - Frederico Knabben. 
 * Licensed under the terms of any of the following licenses at your
 * choice:
 * GPL V2 or later, LGPL 2.1 or later , MPL 1.1 or later.
 */

CKEDITOR.plugins.setLang( 'autosave', 'pl',
{
	autosave: {	
		defaultMessage : 'AutoSave: Dokumnet niezmieniony',
		
		//Komunikaty dla ikon
		draftSaved : 'AutoSave: Dokument zapisany o ',
		needsSaving : 'Zapisz Dokument (AutoSave aktywny)',
		inProgress : 'Zapisywanie...',	
		errorTemplate : 'Błąd: ',	
		looseChanges : 'Wszelkie zmiany jakie zostały dokonane od ostatniego zapisu zostaną utracone. Kontynuować?',
		
		//Ogólne komunikaty		
		unknownError : 'Wystąpił nieznany błąd',
		requestTimeout : 'Koniec czasu oczekiwania na żądanie',
		noUrl : 'Nie podano adresu URL. Akcja przerwana',
		noXhr : 'Nie znaleziono obiektu XHR dla tego klienta.',
				
		//Komunikaty błędów
		error400 : 'Nieprawidłowe zapytanie - błędna składnia zapytania',	
		error401 : 'Nieautoryzowany dostęp – żądany zasób wymaga uwierzytelnienia',
		error403 : 'Dostęp Zabroniony',
		error404 : 'Nie znaleziono żądanego zasobu na tym serwerze',
		error410 : 'Żądany zasób nie jest już dostępny i nie jest znany jego nowy adres URI',
		error411 : 'Wymagana długość – brak nagłówka Content-Length w zapytaniu',
		error413 : 'Całkowita długość zapytania jest zbyt długa dla serwera',
		error414 : 'Długość żądanego adresu URI jest większa niż maksymalna oczekiwana przez serwer',
		error500 : 'Wewnętrzny błąd serwera',			
		error503 : 'Usługa niedostępna. Serwer nie jest w stanie w danej chwili zrealizować zapytania',
		defaultErrorMessage : 'Został zwrócony kod ###. Skontaktuj się z administratorem'		
	}	
});
