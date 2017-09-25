From: Igor Plyatov <plyatov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi-atmel.c: problem with PDC on AT91SAM9G20
Date: Mon, 25 Sep 2017 13:34:34 +0300
Message-ID: <de4b4952-35a0-fd95-6adf-9219385644e9@gmail.com>
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

Dear Nicolas, Mark, Cyrille and other developers,

please help to manage issue with data corruption by PDC of SPI.


Versions
--------

I use linux4sam kernel 4.9.36+ 
(7e82b52ca2286e9823d2467b64bfe78980b464b7) on the custom AT91SAM9G20 
board (Stamp9G20 SOM from Taskit.de).

The drivers/spi/spi-atmel.c updated by patches from upstream kernel, 
where last commit is 7094576ccdc3acfe1e06a1e2ab547add375baf7f
Author: Cyrille Pitchen <cyrille.pitchen-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Date:   Fri Jun 23 17:39:16 2017 +0200

     spi: atmel: fix corrupted data issue on SAM9 family SoCs


Issue
-----

Data corruption happens during receiving of SPI data by kernel. It 
happens quite often (once per minute or so) if OS has some light load, 
like periodical writes to SD card in parallel with communication to SPI 
device (DSP).

Corruption of received SPI data by AT91SAM9G20 CPU confirmed with help 
of logical analyzer.
Analyzer is connected to SPI bus right near CPU.
DSP print SPI data to own serial console for debugging purposes.
Logical analyzer show exactly same data which was printed by DSP.
Kernel driver for DSP print SPI data, where some bytes corrupted, into 
kernel logs for debugging purposes.

The DSP and its linux driver has custom protocol to control correctness 
of communication between Linux host and DSP.
Protocol is quite simple:
* Half duplex.
* Main data transceived as 32 bytes long packets with CRC8 as byte #32.
* Each 32 bytes packet ACKed by one byte (error code) sent back in responce.

This protocol allow to control data integrity during communication 
between Linux host and DSP.


spi-atmel.c reports
-------------------

atmel_spi fffc8000.spi: Atmel SPI Controller version 0x199 at 0xfffc8000 
(irq 32)
atmel_spi fffcc000.spi: Atmel SPI Controller version 0x199 at 0xfffcc000 
(irq 33)

And works with use of SPI PDC.


DSP & Logical Analyzer Data
---------------------------

To Linux Host:   01 01 43 F3 00 01 43 E8 00 01 43 EB 00 01 43 E1
To Linux Host:   00 01 43 F4 00 01 43 E1 00 01 43 F0 00 01 43 22
 From Linux Host: CRC error.


Kernel Data
-----------

 From DSP:        01 01 43 F3 00 01 43 E8 00 01 43 EB 00 01 43 E1
 From DSP:        00 01 43 F4 00 01 43 E1 00 01 F0 F0 00 01 43 22
                                                **
To DSP: CRC error.

** Corrupted byte.


The SPI PIO mode works without data corruption, but this is not an 
option, because communication can have critically big lags if OS has 
some load. These lags are not acceptable for our high speed DSP.

Best wishes.
--
Igor Plyatov
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
