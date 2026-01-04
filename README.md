# Platforma Ogłoszeniowa

## Cel Projektu

Celem projektu jest stworzenie nowoczesnej platformy ogłoszeniowej, która umożliwia użytkownikom łatwe dodawanie, przeglądanie i wyszukiwanie ogłoszeń w różnych kategoriach.

## Założenia MVP (Minimum Viable Product)

Na obecnym, początkowym etapie rozwoju, skupiamy się na dostarczeniu podstawowych funkcjonalności, które stanowią fundament dla dalszej rozbudowy platformy. MVP obejmuje:

*   Możliwość dodawania ogłoszeń.
*   Możliwość przeglądania listy dostępnych ogłoszeń.
*   Prosty system wyszukiwania.

## Struktura Projektu

Główny kod aplikacji Symfony znajduje się w podkatalogu `application/`.

- `application/`: Główny katalog aplikacji Symfony.
  - `src/`: Kod źródłowy aplikacji (kontrolery, encje, serwisy, etc.).
  - `config/`: Pliki konfiguracyjne Symfony.
  - `public/`: Publiczny katalog główny, zawiera `index.php`.
  - `tests/`: Testy aplikacji.
  - `composer.json`: Definicje zależności PHP.
- `AGENTS.md`: Ten plik.

---

## Konfiguracja Środowiska Deweloperskiego

Masz dwie opcje konfiguracji środowiska: za pomocą **Docker** (zalecane, uproszczone) lub **lokalnie** (wymaga PHP i Composer).

### Opcja 1: Konfiguracja z Użyciem Docker (Zalecane)

Aplikacja jest w pełni skonteneryzowana, co znacznie upraszcza proces konfiguracji.

**Wymagania:**
*   Docker
*   Docker Compose

**1. Uruchomienie Aplikacji:**
Aby uruchomić wszystkie niezbędne usługi (serwer WWW, PHP, baza danych), wykonaj poniższe polecenie w głównym katalogu projektu:
```bash
docker-compose up -d
```

**2. Dostęp do Aplikacji:**
Po pomyślnym uruchomieniu kontenerów, aplikacja będzie dostępna pod następującymi adresami:
*   **Aplikacja Webowa**: [http://localhost:8080](http://localhost:8080)
*   **Mailpit (przechwytywanie e-maili)**: [http://localhost:8025](http://localhost:8025)

**3. Praca z Aplikacją (wewnątrz kontenera):**
Większość operacji, takich jak zarządzanie zależnościami, praca z bazą danych czy uruchamianie testów, wymaga wykonywania poleceń wewnątrz kontenera `php`.

- **Wejście do Kontenera:**
  ```bash
  docker-compose exec php bash
  ```
- **Instalacja zależności (Composer):**
  ```bash
  composer install
  ```
- **Tworzenie bazy danych:**
  ```bash
  php bin/console doctrine:database:create
  ```
- **Uruchamianie migracji:**
  ```bash
  php bin/console doctrine:migrations:migrate
  ```
- **Uruchamianie testów:**
  ```bash
  ./vendor/bin/phpunit
  ```

---

### Opcja 2: Konfiguracja Lokalna (PHP + SQLite)

Ta opcja pozwala na uruchomienie aplikacji bez Dockera, używając lokalnie zainstalowanego PHP. Wszystkie polecenia należy wykonywać z głównego katalogu repozytorium, chyba że zaznaczono inaczej.

**1. Instalacja Zależności (Composer):**
Wszystkie zależności PHP znajdują się w katalogu `application/`.
```bash
cd application && composer install
```
*Jeśli Composer zgłosi błąd dotyczący blokowania wtyczek, zezwól na ich użycie poleceniem `composer config --no-plugins allow-plugins.NAZWA/WTYCZKI true` w katalogu `application`.*

**2. Konfiguracja Połączenia z Bazą Danych (SQLite):**
- **Utwórz plik `.env.local`**:
  ```bash
  touch application/.env.local
  ```
- **Skonfiguruj `DATABASE_URL`**:
  W pliku `application/.env.local` umieść następującą linię:
  ```
  DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
  ```

**3. Przygotowanie Bazy Danych:**
- **Uruchom migracje**:
  ```bash
  php application/bin/console doctrine:migrations:migrate --no-interaction
  ```

**4. Uruchomienie Serwera Deweloperskiego:**
- **Użyj wbudowanego serwera Symfony**:
  ```bash
  cd application && php bin/console server:run
  ```
  Aplikacja będzie dostępna pod adresem `http://127.0.0.1:8000`.

**5. Uruchamianie Testów (lokalnie):**
Z katalogu `application/` wykonaj:
```bash
./vendor/bin/phpunit
```