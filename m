From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct spi_message
Date: Tue, 12 May 2015 11:23:15 +0100
Message-ID: <20150512102315.GO2761@sirena.org.uk>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
 <CAMuHMdUakeDgLZ4hXe0DBu97Xx4eiC9K_Qfc-imkDBrDBXNs6A@mail.gmail.com>
 <CY1PR0301MB0780A4057DBB4DEBC45A631F8BDA0@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <CAMuHMdUzkr6_evPD5y-gaH=rtEgyZ+bHAddD+UmpTssQXZry1g@mail.gmail.com>
 <CY1PR0301MB078056CF0855A97334FD96458BDA0@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <CAMuHMdXFY_W6Rd37rNeNUnztZ=8xUcZBS3=eLQwK52N6byGgBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w6U88vdWm8UqIXvc"
Cc: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFY_W6Rd37rNeNUnztZ=8xUcZBS3=eLQwK52N6byGgBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w6U88vdWm8UqIXvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 10:57:03AM +0200, Geert Uytterhoeven wrote:

> So it looks like we need something like i2c_adapter_quirks, where spi masters
> can advertise their limitations?

We already have some flags for features/limitations (mostly only used by
the core) like _MUST_TX.

--w6U88vdWm8UqIXvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUdSSAAoJECTWi3JdVIfQVtsH/29OfoRXrMJlj2mdt6cgwQhj
NnKEA/bW5Fhk4K9+A941jCaSB3OHC/1FoKYC3eVKpHclrixA8cmuLvF4ptrUkfgE
6A7xSRTi12eTFTyt5l3BZOqb/kEUat1whlKZRYF+p5H2SHL97SsAZ3mGT8ke2E91
fJ4I00kErQpYVknVUlnoygQGff8AC4BEbsIzeyN5fPE+mdpNgV4/ko0iWrxoSeGs
gDrfBMgL8V010K97wON5J58KP9tBBaSKQXUqcVKrdF9ATCRXa+qifzVEHdnbisGD
yGfUTos4DD4iTpc+0wkt2MlJuUjzuTzw9nZb81QP+uRGfLl3FY+jr9ve6OfsJLE=
=FBwp
-----END PGP SIGNATURE-----

--w6U88vdWm8UqIXvc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
