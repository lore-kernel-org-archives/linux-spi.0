From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Tue, 28 Oct 2014 22:41:56 +0000
Message-ID: <20141028224156.GN18557@sirena.org.uk>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UEuIyxvdBb2zujbm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414513502-595-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UEuIyxvdBb2zujbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 06:25:00PM +0200, Andy Shevchenko wrote:
> In current shape the driver relies on both TX and RX transfers when DMA is
> enabled. In case of simplex transfer the driver will stuck, since call back
> function will never achieve the proper condition to finish the transfer.

Applied both, thanks.  Can you please also send a patch for Linus
setting SPI_MASTER_MUST_RX and SPI_MASTER_MUST_TX - this is a bug which
should be fixed in mainline but these seem a bit big for merge right
now, those flags will cause the core to always ensure that both
directions have data avoiding the issue?

--UEuIyxvdBb2zujbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUBuzAAoJECTWi3JdVIfQqWoH/1zkCcH6bIpQ3EGotuEg5XjE
FKS0msf3eyQdZgKwHH+XM70sXDwtbhRJMohHuccv3qfsiPlCj/rWrrMvcpf1W/3V
wluDsc8sgWNWjF9z1JU1VXFPigvZqRuhgtDAhyjkbyRfWPpjh+z/JTewlbGEEG4s
CB+iC1BAx1OcnUEJmXVKLexdOx6DVIeHLTraBT4H1YzYu97M6eh+g42VwKyPKKQL
1sc7a0HM6gw1R6P28uWAq0Bi5HKSHV9Z2RAzt5w4iXzil4DFB/xTgOQ5pr2VQ5IX
rgD7tEPp6FmHOFGoXua7SBrAyJIkltSEkBSlz40MDcjv+tL7YGzvlhUaS6bpsvw=
=Fjac
-----END PGP SIGNATURE-----

--UEuIyxvdBb2zujbm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
