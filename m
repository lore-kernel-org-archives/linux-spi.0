From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/18] spi: rspi: SPI DMA core needs both RX and TX DMA
 to function
Date: Mon, 2 Jun 2014 17:28:57 +0100
Message-ID: <20140602162857.GN31751@sirena.org.uk>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
 <1401716301-29612-10-git-send-email-geert+renesas@glider.be>
 <20140602144221.GI31751@sirena.org.uk>
 <CAMuHMdXra=NjAy6WuQBf1Rm3iHv8J2qYubTpq3scxGq8+wK_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXra=NjAy6WuQBf1Rm3iHv8J2qYubTpq3scxGq8+wK_tg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2014 at 04:55:14PM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 2, 2014 at 4:42 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Hrm, was this error handling or is it a hardware limitation that it can
> > only do DMA in one direction?  Perhaps the core ought to be changed to
> > support that if it's a hardware limit, I honestly hadn't considered that
> > possibility when I wrote the code.

> So it's not a hardware limitation, but a software optimization ;-)
> If there's no data to receive, RSPI on SH can do transmit only.
> If there's data to receive, it must do both transmit and receive.

...

> Hence if only one DMA channel is available, RSPI on SH could still do DMA TX
> before. I don't know whether anyone ever used this, as there were no in-tree
> users of RSPI DMA.

OK, that is quite common I guess in hardware where the number of DMA
channels is limited (which does exist).  We should probably support it
at some point.

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjKZGAAoJELSic+t+oim9P6IQAIuABbgztMDuvHAy3satVWHT
SUJkpywVwjImkS6pZKrAk6nb70hwNc8eUldAL95p5ibTYSibeczSEDrL/eteADv5
KojW07b7y6iziA4qxE6d0vtwPiOepOgN7d7PJZ8jhOFLIXApCxK+hull/xae+8X3
rxI7Yzj8oQ6FVUaf2K777NDEYkZwjPLyt4QkUtLcfCBOE+ltFDOZ2B9L3jzwp5Jw
+zadUThd6fuakdcjVe2PYSKnvzZuPgBTQCvGFnXxq77IwfJOENZAO+IgRodsHzn5
E1D/95eFpP9m1M/3a9AeVdf8ziINVAtfASzZHZV0gH1ma1nvkDgyGv8GQAo7eER9
STmdV0qZxm21RACnHF64qDr6YaAjklEE4E1k6Mj1mgMcm1rlYZHpcFaw8q8k+AYp
Vy+ub89KaVXVeY53pFjczMqGaJGPdheg40SGKeB4qpUZIm/yVjZMxsTVVcdB0cU7
h+Jne2r5DtiM/QxtNWZIlp63vhxbccSRaOANmIEQChQ7qhWZ7VxuCXYb2pcQQ3Ks
VYPx8R4VizBCHSL15GwdjEU944rbqJYksloG59DDjMbz15MO8wgjxP7Vwl2qq/Gz
jYhovxI5Mq6XJQVh1lNgkeILxIk27f6tSFYtnBI8J2Bzq54cAOWm3PulmTEv4+x1
V4R/+nQiH7Ayd1LXmDil
=iDmm
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
