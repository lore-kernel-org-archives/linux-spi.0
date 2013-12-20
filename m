From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: Fix out-of-order CS/SCLK operation at low
 speeds
Date: Fri, 20 Dec 2013 11:54:43 +0000
Message-ID: <20131220115443.GQ31886@sirena.org.uk>
References: <1387387907-19756-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fV3mxwFPWhsKHyX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387387907-19756-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2fV3mxwFPWhsKHyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 06:31:47PM +0100, Marek Vasut wrote:
> Problem:
> --------
>  The problem this patch addresses has the following assumptions about the
>  SPI bus setup:

Applied, thanks.  Really nice analysis.

--2fV3mxwFPWhsKHyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStDAAAAoJELSic+t+oim9/mAP/RvSl4mqWqCOYpMzurrXIOsg
tJXx/TaJculGx+UAcOoLba5rayXWxgj45/wiOmmOUnbf7S7VawDqo82dasfI8k6R
r5bpqjfyisKm3+4eLGNMk1c1d7l7jtuKYn3CbQzzm7Iv87lPHpnA+twv2nRVt7Ci
Pd+sKMU7XxR8nk1IkMsC+rm2r1lT08Qh9WRahZ6kYwmqsbN4uB4Z1+dGWEBSFCZR
Kh9IvcujP6+Qnv/Eye6A6yyKyzr8hUxbwtKfQ5LMqZ96arHOn7/MRuHtJ9wVWTAF
hyXmQP07DLhzgH517hE54pfujfYOfM7pnOaFe6jLM6t9jgCV54jlvAh59UP8rIk5
tNvsn+NPaMJ+xkfQHGplXr+dwNjO580/PbZCQZd6Y68aj94tj08e+gCzcEzGo/Cw
NfmaQOJsiPCfNh81zcSkCZgvHYdSA+bq2jZN696dZ6OB6rEZ2SoQ+Vdg0oEYuH3f
Dmus7NXQFHCqJiJUNcXgiEbmzGp0GJ7acoUb/ynfjnwM5SZAMUV7u3xbPhCibKa+
FdX5xUpD91y3EWDyNi4Ggvi2hR5QpYNBfty+Z/H5VxqPr7jQM9nFiFL0NCaSgJWh
+ESY461Eb1hnHCnmI7ag0qqgpUnx+LRx8UPaHI0ki1DJMt7o5Yol2sfgGt2WbsQ7
CbmVhzoFPlAkQPnlnPFx
=XIS9
-----END PGP SIGNATURE-----

--2fV3mxwFPWhsKHyX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
