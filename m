From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Mon, 11 Nov 2013 11:18:42 +0000
Message-ID: <20131111111842.GE2674@sirena.org.uk>
References: <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <20131110110524.GA878@sirena.org.uk>
 <3361A01A-C7D0-4689-AFBD-085D3E62A67C@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3361A01A-C7D0-4689-AFBD-085D3E62A67C-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2013 at 05:41:30PM +0100, Martin Sperl wrote:

> As explained - you would need to make an educated guess if a spi_transfer=
=20
> chain has changed or not (and I talk about the need to check the chain=20
> itself, speed, transferlength, rx_buff,tx_buff,... have not changed).

No, you're going off and talking about something else here.  You are
very focused on the idea of skipping some of the setup but that's not
the only thing being discussed.  Please try to separate the various
ideas.

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgL0JAAoJELSic+t+oim9sjgP+wbYVeoVsDxIgkBBUX3sXCkq
8AfSiK6u3K1ee9Gc0Vi7/gCq81VLCXAkJgsM+IUyVfr2k+312NhELwabdUtfIqP3
YZ0syWyp5rChX26hz+Soe+goUGumNCDHKgtXPoFuYZb5CqKohSKXaujzMXDVZLd1
9BjjOLaRHyqqnE8knLKJZ84xV0YXf0fzzoK0U61PrQrUHCg3Ua/a43fHhsVEGRw/
+5QSi+UlDWNTgychVGDFWLOatyTSGAT53ShUx/fTLUEjaQB11MFmrjo34ClONmzm
tGdzDr0UDYUbg4we6HMgCr64df7WvhKN41ILU2LRBLB0j33e7XRBYkQk+85bhBD1
kVZIaTu3tSL8c4tCg7tRJ3Tn8oVEcUQ5RhV35s6bQJStPK0/W9C2lL2Di3JGJjoh
lAArVgNSDY5OT/GzmioGr8MlpxVWPC2osdkKcwA+Ah0Oby/P1zxIsOSxcHxmWEdu
2QxLhU7aZqyoAO+V3QSjUquIYWw45R6GvpbdLO79tbJgwEuJHPZf3syrM17h8XCW
wHQBfR1iDtG5rrfFCyvwuKxzjoqhMpUyemyc19wU5lvh1z74MlOT1mcK+7ubUR1h
QNjtwIlKPllPl1pVpbLZa7QSm7ADZJbBf3Y6QNOMiD7dVBI2ap2cSHOK0jAuOdcx
50XnRn8QhmHAI9Y/fdKc
=PrJs
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
