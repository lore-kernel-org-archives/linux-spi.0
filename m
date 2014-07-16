From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/6] spi: atmel: Use dmaengine_prep_slave_sg() API
Date: Wed, 16 Jul 2014 23:27:46 +0100
Message-ID: <20140716222746.GN17528@sirena.org.uk>
References: <1405095208-14642-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sh9dYexoRflRb0jn"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405095208-14642-6-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Sh9dYexoRflRb0jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 06:13:28PM +0200, Geert Uytterhoeven wrote:
> Use the inline wrapper introduced by commit
> 16052827d98fbc13c31ebad560af4bd53e2b4dd5 ("dmaengine/dma_slave: introduce
> inline wrappers").

Applied, thanks.  Please make sure everyone gets the cover letter on
patch serieses (or just send the patches individually if there's no
dependency) - it makes it easier to figure out what's going on.

--Sh9dYexoRflRb0jn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvxfAAoJELSic+t+oim9P/8P/iw5Pw1Esd/hizoVoujvCTT6
JHyW6hrXDjPxDiBAN2y+4rOIa8kbl2cn8XYwRiH7qN5hZZYEyKcvH6iiJ7dUQsaN
zOyk1MAG7HxI2nYnraTqcOukrVX5cpm7D5I83v3MedNbOJrWj2fN/QiZcT9B7mRJ
J2j0UTyPUe0657A1A46D3OPyHI7nALVO3oRDdnU81coyW3hU5MzyQ+joNyqqL3NT
WgfIzGMUqJ84ElQlj/DJVYJRJPiFQuXa6noil9kp6gjgg1EeaDjSBq8PVB1389Wp
wvzXCXRV00uBvNtut2ycxGr04RRAfVCkPd8OzzwZ75O56QML2359GWz51/ErULJt
BhyHCvJ8ru6PjznhPehyAk0haXazsnldi4HjH9ChSnFSgbxwQQljjMqEMCaLj2Zd
ti4WP1FD1MEOgmCTND/WCXAhQL5kOeWrfLK6bajSdKNcLBuwEW1wiBJUF69VCQyx
8AwZNOTMBlv5ilxayrZ+jq1tuxRVVJIkfS9H2jZG8oQAGDXaEZgoO5F54Nm37RUI
DUy3l7jFp3NfHEmlH+7q/uNLxqBo9G8jBroovMaDG92NxYdyWR3DEk8J00gsFaSQ
O0wq3THu3i9NPxly2HcfRFDWRzPaNJWw5KeKy248WOVnYytxX93GloqxbPdwXkvk
S6znuHDRK0T3QQbkUFni
=lS9P
-----END PGP SIGNATURE-----

--Sh9dYexoRflRb0jn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
