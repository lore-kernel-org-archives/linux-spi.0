From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: bcm2835aux: fix bitmask defines
Date: Tue, 9 Feb 2016 20:54:03 +0100
Message-ID: <56BA43DB.7030209@lategoodbye.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-2-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Stephan,

Am 09.02.2016 um 19:10 schrieb stephanolbrich-Mmb7MZpHnFY@public.gmane.org:
> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> The bitmasks for txempty and idle interrupts were interchanged.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
> ---
>   drivers/spi/spi-bcm2835aux.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7de6f84..ecc73c0 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -73,8 +73,8 @@
>
>   /* Bitfields in CNTL1 */
>   #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
> -#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
> -#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040

according to a comment in this file these values are from 
brcm_usrlib/dag/vmcsx/vcinclude/bcm2708_chip/aux_io.h.

So you want to say that at least these 2 are wrong and you took the 
values from BCM2835-ARM-Peripherals.pdf [1]?

I think it's worth to mention it.

Regards

[1] - 
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

> +#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
> +#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
>   #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
>   #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001
>



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
