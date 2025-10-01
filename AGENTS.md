# Instrukcje dla Agenta AI (Jules)

## Wprowadzenie

Ten projekt to aplikacja Symfony. Poniższe instrukcje pomogą Ci zrozumieć strukturę projektu i uruchomić go w środowisku lokalnym, bez użycia Dockera.

## Struktura Projektu

Główny kod aplikacji Symfony znajduje się w podkatalogu `application/`.

- `application/`: Główny katalog aplikacji Symfony.
  - `src/`: Kod źródłowy aplikacji (kontrolery, encje, serwisy, etc.).
  - `config/`: Pliki konfiguracyjne Symfony.
  - `public/`: Publiczny katalog główny, zawiera `index.php`.
  - `tests/`: Testy aplikacji.
  - `composer.json`: Definicje zależności PHP.
- `AGENTS.md`: Ten plik.

## Konfiguracja Środowiska Lokalnego (PHP + SQLite)

Aplikację należy uruchomić, używając lokalnie zainstalowanego PHP. Wszystkie polecenia należy wykonywać z głównego katalogu repozytorium, chyba że zaznaczono inaczej.

### Krok 1: Instalacja Zależności (Composer)

Wszystkie zależności PHP są zarządzane przez Composer i znajdują się w katalogu `application/`.

- **Instalacja zależności**:
  Przejdź do katalogu aplikacji i wykonaj polecenie instalacji:
  ```bash
  cd application && composer install
  ```
  Jeśli `composer.json` był modyfikowany, może być konieczne użycie `cd application && composer update`.

- **Problem z wtyczkami (Plugins)**:
  Jeśli Composer zgłosi błąd dotyczący blokowania wtyczek (np. `phpstan/extension-installer`), zezwól na ich użycie (będąc w katalogu `application`):
  ```bash
  composer config --no-plugins allow-plugins.NAZWA/WTYCZKI true
  ```
  A następnie ponów próbę instalacji.

### Krok 2: Konfiguracja Połączenia z Bazą Danych

Aby uniknąć zależności od zewnętrznych usług, użyjemy bazy danych SQLite.

- **Utwórz plik `.env.local`**:
  W katalogu aplikacji utwórz plik o nazwie `.env.local`. Najprościej zrobić to z głównego katalogu repozytorium:
  ```bash
  touch application/.env.local
  ```

- **Skonfiguruj `DATABASE_URL`**:
  W pliku `application/.env.local` umieść następującą linię, aby skonfigurować połączenie z bazą danych SQLite:
  ```
  DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
  ```
  *Uwaga: `%kernel.project_dir%` w Symfony będzie automatycznie wskazywać na katalog `application/`, więc ścieżka jest poprawna.*

### Krok 3: Przygotowanie Bazy Danych

Po skonfigurowaniu połączenia, należy przygotować bazę danych.

- **Wyczyść pamięć podręczną (opcjonalnie, ale zalecane)**:
  Aby upewnić się, że nowa konfiguracja została wczytana:
  ```bash
  php application/bin/console cache:clear
  ```

- **Uruchom migracje**:
  W przypadku SQLite, plik bazy danych tworzony jest automatycznie. Wystarczy uruchomić migracje.
  ```bash
  php application/bin/console doctrine:migrations:migrate --no-interaction
  ```
  *Uwaga: Jeśli projekt nie zawiera migracji, polecenie zakończy się błędem "no registered migrations", co jest normalne.*

### Krok 4: Uruchomienie Serwera Deweloperskiego

Aplikacja jest gotowa do uruchomienia.

- **Użyj wbudowanego serwera Symfony**:
  Przejdź do katalogu aplikacji i uruchom serwer:
  ```bash
  cd application && php bin/console server:run
  ```
  Aplikacja będzie dostępna pod adresem `http://127.0.0.1:8000`.

## Uruchamianie Testów

Aplikacja jest wyposażona w zestaw testów PHPUnit.

- **Uruchomienie wszystkich testów**:
  Z katalogu `application/` wykonaj:
  ```bash
  ./vendor/bin/phpunit
  ```
  Lub z głównego katalogu repozytorium:
  ```bash
  cd application && ./vendor/bin/phpunit
  ```

Pamiętaj, aby przed każdą zmianą w kodzie upewnić się, że wszystkie testy przechodzą pomyślnie. Powodzenia!