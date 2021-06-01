<?php

declare(strict_types=1);

$cfg['blowfish_secret'] = 'pfejoieofjwieoafehoihowefwefwfaefab';
//$cfg['blowfish_secret'] = '4567812345678';

$i = 0;

$i++;

$cfg['Servers'][$i]['auth_type'] = 'cookie';

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';