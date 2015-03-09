From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC/PATCHv2 2/3] dt-binding: spi: spi-dw: Select 16b or 32b
 access for Designware SPI
Date: Mon, 9 Mar 2015 18:19:36 +0000
Message-ID: <20150309181936.GU28806@sirena.org.uk>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
 <1425685594-26595-3-git-send-email-tthayer@opensource.altera.com>
 <CAHp75Vddg3T4oymsixbJWPWnELF3fE5Z4HRe4CxAFd+Eb=VVmA@mail.gmail.com>
 <54FDE250.3050705@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PseDLKNfj4uXA+Je"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
	Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54FDE250.3050705-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PseDLKNfj4uXA+Je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 01:11:28PM -0500, Thor Thayer wrote:

> I stay away from dashes because these variable names are problematic to
> parse in languages like Python which may be used as an external tool.

Dashes are idiomatic for device tree.

--PseDLKNfj4uXA+Je
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eQ4AAoJECTWi3JdVIfQdQcH/3bVLG4cEheukAUc5dG0Bn0j
4DkqWZ4JCLWzF2Bsgdj41mmBU5r+FergtJIW1bNHqcDOn1GPcoD3CrtfcS1tACGq
4SchHNogYbhAxgJr9bZJ+Z+Px/jxJjBKOTV2JRTQZj8+H8nLjT/nrjlR8iVhLrND
2zUC1Y1llsG0nS7agn4ioGpSErKs9T824Izrdor+sGo1+kgUydfmUcx1aekDs3zh
V9NjMfMIfJ1gljv4b7TccqLEu0pw5S2B83k+LUk0x6IAGYjeQ9DfzNp5Qlmnt0Et
1ytkpdXlq/fbN2NMKn1RzvGNkqveCFYn1TNvzF0G1mtisjG9m3DYACau+xrPG3E=
=6Nbk
-----END PGP SIGNATURE-----

--PseDLKNfj4uXA+Je--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
