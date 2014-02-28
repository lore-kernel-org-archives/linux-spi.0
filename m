From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Fri, 28 Feb 2014 14:28:04 +0800
Message-ID: <53102C74.2070609@freescale.com>
References: <530EFE8E.5050303@freescale.com> <1393492575-32495-1-git-send-email-phdm@macqel.be> <20140228034620.GH9383@sirena.org.uk> <53100FEF.7060600@freescale.com> <20140228061344.GD29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140228061344.GD29849-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=D3=DA 2014=C4=EA02=D4=C228=C8=D5 14:13, Mark Brown =D0=B4=B5=C0:
> little while after the last use has finished?  That's a little more
> involved though and would still need this due to runtime PM being
yes. we can use the runtime PM too.

but i am not sure which one is _better_. the runtime PM? or the current=
 way?




thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
