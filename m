From: Otavio Salvador <otavio.salvador-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>
Subject: SPI irq regression
Date: Mon, 9 Mar 2020 15:54:20 -0300
Message-ID: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: kernel-sKpHZLTYfq0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

Since commit:

commit 01b59ce5dac856323a0c13c1d51d99a819f32efe
Author: Emil Renner Berthing <kernel-sKpHZLTYfq0@public.gmane.org>
Date:   Wed Oct 31 11:57:09 2018 +0100

    spi: rockchip: use irq rather than polling

    Register an interrupt handler to fill/empty the
    tx and rx fifos rather than busy-looping.

    Signed-off-by: Emil Renner Berthing <kernel-sKpHZLTYfq0@public.gmane.org>
    Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
    Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

SPI is no longer functional on a RV1108 Elgin board.

The error messages are:

[   46.186916] spidev spi0.0: SPI transfer timed out
[   46.187435] spi_master spi0: failed to transfer one message from queue

Reverting this commit makes SPI to work again.

Any ideas on how we can properly fix this regression?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
