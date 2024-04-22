Dokumentacja Techniczna: Kursy
Opis projektu
Kursy to aplikacja webowa stworzona do zarządzania kursami, uczestnikami oraz rejestracją na kursy. 
Projekt ten jest realizowany w celach naukowych, aby zaprezentować umiejętności w zakresie programowania i tworzenia aplikacji webowych.

Technologie
Backend: PHP (framework Laravel)
Frontend: HTML, CSS, JavaScript
Baza danych: MySQL
Inne: Git, GitHub

Wymagania systemowe

Aby uruchomić aplikację Kursy na lokalnym serwerze, wymagane są następujące komponenty:

Serwer WWW (np. Apache, Nginx)
PHP w wersji 7.0 lub nowszej
Baza danych MySQL
Środowisko deweloperskie (np. XAMPP, WAMP, MAMP)

Instalacja
    Sklonuj repozytorium do swojego lokalnego środowiska:
git clone https://github.com/onnuna/kursy.git
    Przejdź do katalogu projektu:
cd kursy
    Skopiuj plik .env.example do .env:
cp .env.example .env
    Skonfiguruj plik .env, ustawiając połączenie z bazą danych oraz inne ustawienia, jeśli to konieczne.
    Zainstaluj zależności PHP przy użyciu Composera:
composer install
    Wygeneruj klucz aplikacji:
vbnet
php artisan key:generate
    Uruchom migracje, aby utworzyć strukturę bazy danych:
php artisan migrate
    Uruchom serwer lokalny:
php artisan serve
Po wykonaniu tych kroków, aplikacja będzie dostępna pod adresem http://localhost:8000.

Autorzy
Anna Shkarbun

Licencja
Ten projekt jest dostępny na licencji MIT. Szczegółowe informacje można znaleźć w pliku LICENSE.
