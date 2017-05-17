From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spidev: introduce
 SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
Date: Wed, 17 May 2017 10:04:07 +0100
Message-ID: <20170517090407.oc7d2hmydrsieli7@sirena.org.uk>
References: <20170515081711.fcvexppqkjzlc7at@macchiaveli>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dk3md7hlq2zohmxu"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170515081711.fcvexppqkjzlc7at@macchiaveli>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dk3md7hlq2zohmxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 10:17:11AM +0200, Seraphime Kirkovski wrote:
> On Sun, May 14, 2017 at 06:27:16PM +0900, Mark Brown wrote:

> > Do we have any evidence that such users exist? =20

> I can't guarantee for other such users, but this change did disturb our=
=20
> workflow. We were using this feature to prototype and test=20
> hardware/firmware at different speeds.

> I was thinking this morning that maybe a sysfs interface will be better=
=20
> for setting global settings. Do you prefer ?

I just don't see this as something that should be being varied at
runtime; it is supposed to be the maximum speed that the bus can be run
at, that's not something that should vary at runtime.  Possibly a sysfs
thing but honestly if you're prototyping via spidev I'd just set the
speed in your application each time it starts.

--dk3md7hlq2zohmxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkcEgYACgkQJNaLcl1U
h9ArYgf9EuSwRkj9En7Yv89QcgdkbN1oFEgy/c9W0oCM1Y00dEwX8Ye6NxqWGPc7
0VSTQuDctMJXrbTNPvyVO0Kq8MvrN4p/atKtWg04u6XM7WB3LCRY3lir3uLja5mM
D7WgXneRuuCoE/a0Xpu1WBsU88sI6ndDOEeCCiXOkf4tBL+egHTsvR9U9B4EYS/m
NEXp0hnSXg9K/T/ha2TvTWSDYiNlL+YjqkCe4q0oQyVDkw6VpzXZbRdY3moEeKzI
/QfyGJR53k+aWXHVCvqeRq9zY6ca/RrQPJZIIY8FqS4h+OzoRxTTPX0Gt82SE8/4
sSFm504ncY/GOVLS880MiQ+XXqM2ow==
=dNGi
-----END PGP SIGNATURE-----

--dk3md7hlq2zohmxu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
