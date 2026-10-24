<?php
declare(strict_types=1);

/*
 * Arranque común de la API y de los scripts de consola:
 * autoload de clases, variables de entorno, zona horaria y errores.
 */

define('BACKEND_DIR', __DIR__);
define('PUBLIC_DIR', dirname(__DIR__));

spl_autoload_register(static function (string $class): void {
    $prefix = 'App\\';
    if (!str_starts_with($class, $prefix)) {
        return;
    }
    $file = BACKEND_DIR . '/src/' . str_replace('\\', '/', substr($class, strlen($prefix))) . '.php';
    if (is_file($file)) {
        require $file;
    }
});

// El .env se busca primero FUERA de public_html (lo más seguro en Hostinger)
// y, si no existe, en backend/.env (protegido por backend/.htaccess).
App\Env::load(array_filter([
    getenv('APP_ENV_FILE') ?: null,
    dirname(PUBLIC_DIR) . '/.env',
    BACKEND_DIR . '/.env',
]));

date_default_timezone_set(App\Env::get('APP_TIMEZONE', 'Europe/Madrid'));

error_reporting(E_ALL);
ini_set('display_errors', App\Env::bool('APP_DEBUG') ? '1' : '0');
ini_set('log_errors', '1');
ini_set('error_log', BACKEND_DIR . '/storage/logs/php-errors.log');
