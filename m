From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: driver for SPI controller on Broadcom bcma
 SoC
Date: Tue, 19 Aug 2014 11:29:46 -0500
Message-ID: <20140819162946.GL24407@sirena.org.uk>
References: <1407933212-20530-1-git-send-email-zajec5@gmail.com>
 <1408228864-20313-1-git-send-email-zajec5@gmail.com>
 <20140817142117.GI14537@sirena.org.uk>
 <CACna6ryqmkYhDFHHiLdE3b9TpypJAko=Z2xRsXCiMu2iQyvFDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6ryqmkYhDFHHiLdE3b9TpypJAko=Z2xRsXCiMu2iQyvFDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2014 at 05:28:13PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 17 August 2014 16:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'm also not seeing a set_cs() operation here.

> I found no info about that, none of the registers seem to be
> responsible for that. Is that OK for the driver to work without set_cs
> handler/callback?

Well, it's going to break with quite a few client drivers but I guess
whoever runs into that problem can resolve it.

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83txAAoJELSic+t+oim9/20P/1t3l3M+Ctk6sXZLsqDFSmcQ
dHASj7mf+nepFudN3juQSCJeytWOdDFE+Cn+IW6guOaeaE/5ctMId9oWi5WBqW/M
IdZdZTsWJf7EXod/EngnlnH9ZwmFNxVSCLHdIE2lu/1AmyTCVMFpxQGpAVbk8xbX
S2AIYGk5ZUSHj/r/hkX/fvBJ7ItBn3QGtFDNCcuUw67j+o0IhjrjfF+5YCkYm76S
L9qNII4fvcCrCKhXY08DhChOvRP9dqBpCWYmXat6dDrMXVqoXWzRVRNTVybAem/U
CAOohIB1G6gPS6nG8ob98/22zaH2RG9W0lt+vWX48FDXAWZmN6j9IGBaeZgiqkzT
eYoWYpxVjo7XUmXVURU7BFBCqKx5lK1n6n9s4LKz3PE6PV+ETTLUdaMTpQ53iRU0
01O48RaztZOWZbubtLwWPnegLv7v8pc4HbebVuoedU9viZTX5BzYyvMrSdqBRQ3C
150Z16H8Xe6i8G2enWo+2Jp9LyuusK3ffiVo00jd/cCWrLplOVCgwhGT5uNbbQVE
QVt5aOBA5HPny7hD4klyOHMoNyQtA9KZwLp/4+pF8XoeIy0Ya93g9hqos8vJQnzP
aD74hxnoCWirCrkFm9gxGf9b4yX95j8L6MRDB2fRFUweSFTgnRadoLJPMuoyBgfd
cOoS27ddnoEAXo9YngD1
=Ybmg
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
