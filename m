From: Andrew Kuksov <qxovxp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: imx: fix ecspi mode setup
Date: Tue, 14 Jul 2015 19:06:36 +0300
Message-ID: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
	<20150714134934.GV11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150714134934.GV11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3
> What is the problem and how does this change fix it (this information
> should be in the changelog)?

SPI_MODE_0 and SPI_MODE_1 requires clock low when inactive. SPI_MODE_2
and SPI_MODE_3 requires clk high when inactive.
Currently driver can just set bits in fields SCLK_PHA (SPI Clock/Data
Phase Control), SCLK_POL (SPI Clock Polarity Control),
SCLK_CTL (controls the inactive state of SCLK) ans SS_POL (SPI SS
Polarity Select) of ECSPIx_CONFIGREG register.
This patch allows driver to clear corresponding bits in these fields.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
