<?php
namespace App\Message;

use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;

#[AsMessageHandler]
class ParseHataMessageHandler
{
	public function __construct(private LoggerInterface $logger) {}

	# Здесь будет вся логика работы
	# Надо сначала запустить все парсер Kufar, Realt, Onliner
	# Затем записать все данные в базу данных
	# Потом отправить инфу о новых хатах в RabbitMQ
	# Пока просто залогируем что что-то произошло
	public function __invoke( ParseHataMessage $message ) : void
	{
		$this->logger->debug( 'Мы попали в парсер! debug' );
		$this->logger->info('Мы попали в парсер! info');
		$this->logger->warning('Мы попали в парсер! warning');
	}
}