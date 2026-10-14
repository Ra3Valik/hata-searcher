<?php
namespace App\Message;

use Symfony\Component\Messenger\Attribute\AsMessage;

#[AsMessage]
class ParseHataMessage
{
	public function __construct() {}
}