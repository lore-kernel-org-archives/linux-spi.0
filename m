From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] spi: davinci: fix spurious i/o error
Date: Thu, 17 Dec 2015 15:26:17 +0200
Message-ID: <5672B7F9.4050803@ti.com>
References: <cover.1449764266.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1449764266.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/10/2015 06:29 PM, Sekhar Nori wrote:
> This patch series fixes a spurious I/O error with
> DaVinci SPI.
>
> v2:
> - Update to handle DMA case
> - add a patch to use dev_err() for error reporting
>
> Sekhar Nori (2):
>    spi: davinci: fix spurious i/o error
>    spi: davinci: use dev_err() for error reporting
>
>   drivers/spi/spi-davinci.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>

Looks good:
Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
