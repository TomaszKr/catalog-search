# Instrukcje dla Agenta AI (Jules)

## Wprowadzenie

Ten projekt to aplikacja Symfony. Poniższe instrukcje pomogą Ci zrozumieć strukturę projektu, jak go uruchomić i jak z nim pracować.

## Struktura Projektu

- `application/`: Główny katalog aplikacji Symfony.
  - `src/`: Kod źródłowy aplikacji (kontrolery, encje, serwisy, etc.).
  - `config/`: Pliki konfiguracyjne Symfony.
  - `templates/`: Szablony Twig.
  - `public/`: Publiczny katalog główny, zawiera `index.php`.
  - `tests/`: Testy aplikacji.
  - `composer.json`: Definicje zależności PHP.
- `docker-compose.yml`: Definicja usług i środowiska Docker.
- `.docker/`: Pliki konfiguracyjne dla kontenerów Docker.

## Konfiguracja Środowiska (Docker)

Aplikacja jest w pełni skonteneryzowana przy użyciu Docker.

1.  **Uruchomienie kontenerów**:
    Aby uruchomić aplikację, użyj polecenia:
    ```bash
    docker-compose up -d
    ```

2.  **Dostęp do aplikacji**:
    - Aplikacja webowa będzie dostępna pod adresem: `http://localhost:8080`
    - Mailpit (do przechwytywania emaili) będzie dostępny pod adresem: `http://localhost:8025`

3.  **Praca z kontenerem `php`**:
    Większość komend (Symfony, Composer) należy wykonywać wewnątrz kontenera `php`. Aby wejść do powłoki kontenera, użyj:
    ```bash
    docker-compose exec php bash
    ```
    Wewnątrz kontenera, katalogiem roboczym jest `/var/www/html`.

## Zarządzanie Zależnościami (Composer)

Wszystkie zależności PHP są zarządzane przez Composer.

- **Instalacja zależności**:
  Jeśli plik `composer.lock` istnieje, zainstaluj zależności za pomocą:
  ```bash
  docker-compose exec php composer install
  ```

- **Dodawanie nowej zależności**:
  ```bash
  docker-compose exec php composer require nazwa/pakietu
  ```

## Konsola Symfony

Aplikacja Symfony dostarcza potężne narzędzie konsolowe.

- **Użycie konsoli**:
  Komendy należy wykonywać w kontenerze `php`, np.:
  ```bash
  docker-compose exec php php bin/console list
  ```
  Lub po wejściu do kontenera (`docker-compose exec php bash`):
  ```bash
  php bin/console list
  ```

- **Czyszczenie cache**:
  ```bash
  docker-compose exec php php bin/console cache:clear
  ```

## Baza Danych

Aplikacja używa PostgreSQL jako bazy danych.

- **Tworzenie bazy danych**:
  Baza danych jest tworzona automatycznie przez Docker Compose. Jeśli jednak potrzebujesz ją stworzyć ręcznie:
  ```bash
  docker-compose exec php php bin/console doctrine:database:create
  ```

- **Uruchamianie migracji**:
  Aby zaktualizować schemat bazy danych do najnowszej wersji:
  ```bash
  docker-compose exec php php bin/console doctrine:migrations:migrate
  ```

- **Tworzenie nowej migracji**:
  Po dokonaniu zmian w encjach Doctrine, wygeneruj nową migrację:
  ```bash
  docker-compose exec php php bin/console make:migration
  ```

## Uruchamianie Testów

Aplikacja jest wyposażona w zestaw testów PHPUnit.

- **Uruchomienie wszystkich testów**:
  ```bash
  docker-compose exec php ./vendor/bin/phpunit
  ```
  Lub z poziomu kontenera `php`:
  ```bash
  ./vendor/bin/phpunit
  ```

Pamiętaj, aby przed każdą zmianą w kodzie upewnić się, że wszystkie testy przechodzą pomyślnie. Powodzenia!