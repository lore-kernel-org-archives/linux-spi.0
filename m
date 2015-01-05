From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix detecting FIFO depth
Date: Mon, 5 Jan 2015 19:04:32 +0000
Message-ID: <20150105190432.GG2634@sirena.org.uk>
References: <1420421576.6968.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Cc: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420421576.6968.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 09:32:56AM +0800, Axel Lin wrote:
> Current code tries to find the highest valid fifo depth by checking the value
> it wrote to DW_SPI_TXFLTR. There are a few problems in current code:
> 1) There is an off-by-one in dws->fifo_len setting because it assumes the latest
>    register write fails so the latest valid value should be fifo - 1.

Applied, thanks.

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUquBAAAoJECTWi3JdVIfQh44IAIEr6nqtsiRKb+SOKbPw+Y54
sZWGG9wtSuM2aPgLV1uHxThSv+0Wc7SArhaQJg+TqWgqa51zSod2JKCqaWaDLdIN
l7zI6aMYkLVipfKYqTo/AzL0QCJTVwTkaLoGwOk5i8XBsIZdl2gcJpxaqzzafXDb
H1wQuFJhzujOmkAQA/daZXd+JrNf9MX1Usk6zrwNta3xqLkDm7PUCSbYGkBme4tD
j8PEiPiouVuT9ELerB+BAb3Cyt1SB2rjr9pU8PIn9nsa5KiPu4oJIax69xY9wiuP
lp2jDNN2Pwpt+IeFbzsG2RGlwsRiKTG8tYHrGGP+MfB3H+PUU0lbGcXwN37HDAs=
=d0L3
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
