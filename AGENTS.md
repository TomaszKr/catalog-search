# AGENTS.md - Instructions for AI Agents

## Project Overview

This is a Symfony application. The main source code is located in the `application/` directory.

## Core Commands

All commands should be executed from the repository root directory unless otherwise specified.

- **Install Dependencies:**
  ```bash
  cd application && composer install
  ```

- **Run Database Migrations:**
  ```bash
  php application/bin/console doctrine:migrations:migrate --no-interaction
  ```

- **Run Tests:**
  ```bash
  cd application && ./vendor/bin/phpunit
  ```

## Development Workflow

1.  **Dependency Management:** If you add or remove packages, run `cd application && composer update`.
2.  **Database Changes:** After modifying a Doctrine entity, create a new migration:
    ```bash
    php application/bin/console make:migration
    ```
3.  **Testing:** Always run the test suite before submitting changes to ensure no regressions were introduced.

## Coding Conventions

- **Symfony Best Practices:** Follow standard Symfony coding conventions.
- **Service-Oriented:** Use services for business logic instead of controllers.
- **Strict Typing:** Use strict typing for all new code.
- **User Preference:** The user prefers `symfony console` over `php bin/console`. Please use `symfony console` where possible.
