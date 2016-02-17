From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i.MX SPI DMA cleanup
Date: Wed, 17 Feb 2016 13:40:42 -0200
Message-ID: <CAOMZO5Bcwf335VY2809YU2b_-+jntJ_pjNQw_E+jdvEYV==NrQ@mail.gmail.com>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
	<56C478C9.6050706@de.bosch.com>
	<20160217135441.GA3939@pengutronix.de>
	<56C47F64.1080706@de.bosch.com>
	<20160217145944.GB3939@pengutronix.de>
	<56C492DB.6000405@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56C492DB.6000405-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 17, 2016 at 1:33 PM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:

> To my understanding, the TKT238285 hardware issue exists on both i.MX6Q and
> i.MX6DL. Even though the commit message in
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c802
>
> states it differently. Maybe due to timing issues it happens less often on
> i.MX6Q and therefore wasn't in the focus there, yet.

Yes, this is my understanding as well.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
