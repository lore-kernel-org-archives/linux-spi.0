From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RFC] spi: efm32: Make "efm32,location" property optional
Date: Mon, 7 Apr 2014 08:16:23 +0200
Message-ID: <20140407061623.GM29751@pengutronix.de>
References: <1396840732.7635.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396840732.7635.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Axel,

On Mon, Apr 07, 2014 at 11:18:52AM +0800, Axel Lin wrote:
> The spi driver still works even if "efm32,location" property is not p=
rovided.
> Thus make "efm32,location" property optional.
good catch. The changelog is wrong though. You don't make the property
optional, you only adapt the documentation to reality. It would be also
nice to mention the default value (i.e. keeping what is already
configured in the hardware, so its either the reset default 0 or
whatever the bootloader did.) OTOH I'm not sure if that should go into
the binding doc as it sounds Linux specific?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
