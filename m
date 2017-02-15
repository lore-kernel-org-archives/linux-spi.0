From: Hartley Sweeten <HartleyS-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH] spi: spi-ep93xx: simplify GPIO chip selects
Date: Wed, 15 Feb 2017 19:21:29 +0000
Message-ID: <SN1PR0101MB15656D1BA2882A3321012678D05B0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170215164422.5957-1-hsweeten@visionengravers.com>
 <20170215190138.g7jsecekhtm4gvkr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170215190138.g7jsecekhtm4gvkr-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, February 15, 2017 12:02 PM, Mark Brown wrote:
> On Wed, Feb 15, 2017 at 09:44:22AM -0700, H Hartley Sweeten wrote:
>> This driver requires a GPIO line to be used for the chip select of
>> each SPI device.
>> 
>> Remove the ep93xx_spi_chip_ops definition from the platform data
>> and just pass the required GPIO line as the controller_data for
>> each spi_board_info entry. Then handle the gpio directly in the
>> driver.
>
> Why not also use the core GPIO handling?

Mark,

Unless I'm missing something, I don't think I can use the core GPIO
handling with the spi-ep93xx driver.

spi_set_cs() is only called to enable the chip select by the default
implementation of transfer_one_message() and the spi-ep93xx
driver does not use that.

Regards,
Hartley

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
