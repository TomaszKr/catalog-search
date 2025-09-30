# Platforma Ogłoszeniowa

## Cel Projektu

Celem projektu jest stworzenie nowoczesnej platformy ogłoszeniowej, która umożliwia użytkownikom łatwe dodawanie, przeglądanie i wyszukiwanie ogłoszeń w różnych kategoriach.

## Założenia MVP (Minimum Viable Product)

Na obecnym, początkowym etapie rozwoju, skupiamy się na dostarczeniu podstawowych funkcjonalności, które stanowią fundament dla dalszej rozbudowy platformy. MVP obejmuje:

*   Możliwość dodawania ogłoszeń.
*   Możliwość przeglądania listy dostępnych ogłoszeń.
*   Prosty system wyszukiwania.

## Wymagania

*   Docker
*   Docker Compose

## Konfiguracja Środowiska Deweloperskiego

Aplikacja jest w pełni skonteneryzowana, co znacznie upraszcza proces konfiguracji środowiska.

### 1. Uruchomienie Aplikacji

Aby uruchomić wszystkie niezbędne usługi (serwer WWW, PHP, baza danych), wykonaj poniższe polecenie w głównym katalogu projektu:

```bash
docker-compose up -d
```

### 2. Dostęp do Aplikacji

Po pomyślnym uruchomieniu kontenerów, aplikacja będzie dostępna pod następującymi adresami:

*   **Aplikacja Webowa**: [http://localhost:8080](http://localhost:8080)
*   **Mailpit (przechwytywanie e-maili)**: [http://localhost:8025](http://localhost:8025)

## Praca z Aplikacją

Większość operacji, takich jak zarządzanie zależnościami, praca z bazą danych czy uruchamianie testów, wymaga wykonywania poleceń wewnątrz kontenera `php`.

### Wejście do Kontenera

Aby uzyskać dostęp do powłoki bash kontenera `php`, użyj polecenia:

```bash
docker-compose exec php bash
```

Wszystkie poniższe komendy należy wykonywać z wnętrza tego kontenera.

### Zarządzanie Zależnościami (Composer)

Projekt wykorzystuje Composer do zarządzania zależnościami PHP.

*   **Instalacja zależności**:
    ```bash
    composer install
    ```

*   **Dodawanie nowej zależności**:
    ```bash
    composer require nazwa/pakietu
    ```

### Baza Danych (Doctrine)

Aplikacja korzysta z bazy danych PostgreSQL i Doctrine ORM.

*   **Tworzenie bazy danych** (jeśli nie została stworzona automatycznie):
    ```bash
    php bin/console doctrine:database:create
    ```

*   **Uruchamianie migracji** (aktualizacja schematu bazy danych):
    ```bash
    php bin/console doctrine:migrations:migrate
    ```

*   **Generowanie nowej migracji** (po zmianach w encjach):
    ```bash
    php bin/console make:migration
    ```

### Uruchamianie Testów

Do weryfikacji poprawności działania aplikacji służy PHPUnit.

*   **Uruchomienie wszystkich testów**:
    ```bash
    ./vendor/bin/phpunit
    ```

### Konsola Symfony

Aplikacja udostępnia narzędzie `bin/console` do wykonywania różnych zadań administracyjnych.

*   **Lista dostępnych komend**:
    ```bash
    php bin/console list
    ```

*   **Czyszczenie pamięci podręcznej (cache)**:
    ```bash
    php bin/console cache:clear
    ```