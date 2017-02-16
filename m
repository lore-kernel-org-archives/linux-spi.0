From: Hartley Sweeten <HartleyS-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH v2] spi: spi-ep93xx: simplify GPIO chip selects
Date: Thu, 16 Feb 2017 19:15:46 +0000
Message-ID: <SN1PR0101MB15656A6802EDBAAA6E7C4F1BD05A0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170216182614.47941-1-hsweeten@visionengravers.com>
 <20170216190109.kvsgigo4wlnaacvm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216190109.kvsgigo4wlnaacvm-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday, February 16, 2017 12:01 PM, Mark Brown wrote:
> On Thu, Feb 16, 2017 at 11:26:14AM -0700, H Hartley Sweeten wrote:
>> This driver requires a GPIO line to be used for the chip select of
>> each SPI device.
>
> This doesn't apply against current code, there's conflicts in the arch
> code.  What's the story here (should I just apply after -rc1?)?

Oops. The conflict is probably with arch/arm/mach-ep93xx/simone.c.

I have another patch to that file that is still under review.

I'll rebase this and post a v3 shortly.

Regards,
Hartley


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
