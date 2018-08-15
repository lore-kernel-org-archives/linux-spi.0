From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Subject: Re2: [PATCH] spi:fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Date: Wed, 15 Aug 2018 17:28:56 +0300
Message-ID: <13c72347-d1fc-6250-3ec4-2066f9fd5e1c@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.stach@pengutronix.de
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/14/2018 05:18 PM, Mark Brown wrote:
 > Is this something that's actually happened for you?

Yes, I observed it.

Background:
The platform: fitlet2 [1] , CPU Intel(R) Celeron(R) CPU J3455 @ 1.50GHz.
On an extension board there are three SPI master controllers "Intel 
Corporation Atom/Celeron/Pentium Processor N4200/N3350/E3900 Series SPI 
Controller", controlled with spi_pxa2xx_platform  driver,
and two USB/SPI bridges "FT232H Single HS USB-UART/FIFO IC".

I'm working on a driver for FT232H bridge and saw the following:
spi_pxa2xx driver occupy IDs 1,2,3 this way [2].
Thus when my code tries to get ID automatically (set spi_master.bus_num= 
-1), it gets IDs 0 and 1, that leads a crash.

BTW, I haven't the faintest idea, how to cure this problem in the 
opposite case: when a device that gets ID dynamically squats an ID 
purposed for a device that uses a fixed numbering order.

 >> +    } else {
 >> +    /* devices with a fixed bus num must check-in with the num */
 >> +        mutex_lock(&board_lock);
 > The indentation here is weird, the comment isn't aligned with the code
 > it's commenting on.
I'm sorry for the oversight, it'll be fixed.

[1] https://fit-iot.com/web/products/fitlet2/
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-pxa2xx.c#L1361
