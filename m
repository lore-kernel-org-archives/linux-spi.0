From: Igor Plyatov <plyatov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi-atmel.c: regression
Date: Mon, 2 Oct 2017 17:45:07 +0300
Message-ID: <0876ce0a-cb93-07b7-8019-e365d08cca2a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Cyrille Pitchen <cyrille.pitchen-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello!

please help to manage issue with data corruption by PDC of SPI.


I have compared operation of Linux-2.6.39 and linux4sam kernel 4.9.36+ 
on the AT91SAM9G20 (Stamp9G20 SOM from Taskit.de) and found regression 
in the spi-atmel.c.

New spi-atmel.c driver works very bad with SPI speeds above 6 MHz. I see 
corruption in data received by Linux and SPI overruns when OS has big 
CPI and IO load.

Old kernel works fine at 22 MHz with the same device driver and hardware.

Can somebody comment and/or help on how to resolve this issue?

Best wishes.
--
Igor Plyatov
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
