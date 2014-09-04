From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/8] spi: sirf: add fifo reset/start for cmd transfer
Date: Thu, 4 Sep 2014 23:37:45 +0100
Message-ID: <20140904223745.GT29327@sirena.org.uk>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JKqnEsEWyvhRy1Sr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648557-5470-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JKqnEsEWyvhRy1Sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:02:34PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> for command mode spi transfer, HW spec requires to do fifo reset work to
> clear FIFO status.

Applied, thanks.  This seems like a bug fix so sohuld have been towards
the start of the series.

--JKqnEsEWyvhRy1Sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCOm2AAoJELSic+t+oim9H3MP/0f5/TFttUEk+qHt5O1pJ9wI
gSvAPCm8jj1cEEG4HGJISRQwrpogL/jXUSIO/edWTLaAe3ZMCN3g7pGEN8g93G4+
hOhR2EonSF0BLB5hDRBMldRgsSo8t9Y3Go2KIAVzA2PLcjneETbUvoSrXf5vmrCA
kZ8NI1Y4BF0MX8CRktQB12d5eJ3PzPMfx06lsLUNunU6/jKjJIZdN4i1Wsxvo1ho
+D8d6TIajJPdl7gLgVS+/OJdhM+BpotgOmzJp7DplO8NDu6a7MdPolOetFJcPyrp
XLSViS1reIcFcGYq16amiA5L2evqjfnuAQMpZLWmEhj+mnvswSmoceJbji7vBgQw
b8DTyFlTyfCdeZ9bBvMazyTXgRuzQ5FC3ApjpcoTuZv9Ha2nhB8XDc4zIKV/3u+A
Ur0zhduY8kRH0mwY83vLwEnLglTCcWi9F0uQmHVpOQfHqBxX7CXhEY2wduK5Ft3v
GlB12kibVTP7xBgkxPd7wFJP9m4LN18A1U/FQBqbZakr8+stPzkDdXbdYJEcqNC3
+OzEwg+dDWQksw49MSt61jpLZSJtrcYVGkkMIYS/vW3tpS4ceFpkzTlNJfsQ2VVE
1O6U230sZqZ8/8+9bxrFbd25NOG9WPMoOgQR06JdVETFhNb5Xm0UgJVenlzvSidR
rJXDw6TKjSm7AuxFvTlC
=6Nd6
-----END PGP SIGNATURE-----

--JKqnEsEWyvhRy1Sr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
