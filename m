From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Rewrite GPIO SPI to use descriptors
Date: Wed, 3 Jan 2018 16:24:49 +0000
Message-ID: <20180103162449.GG28713@sirena.org.uk>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <1514918569.26695.151.camel@impinj.com>
 <CACRpkdYRJ=jR4B2Ko2P1axwGMKob2vHkY2h8cMc9t9Qi7n52sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYRJ=jR4B2Ko2P1axwGMKob2vHkY2h8cMc9t9Qi7n52sQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 12:17:07AM +0100, Linus Walleij wrote:

> I'd be surprised if either performance or object code size is affected
> in a bad way though. I don't have any high-speed SPI devices I can test
> really, and loopback would require some special hardware set-up I
> don't have.

You could just do something like spin on register reads on some device
or something?  Something like dumping a regmap via debugfs would do the
trick probably.  I too would be surprised if there were a substantial
hit but it'd be good to check, while they've never been fast equally the
slowness can make people more sensitive to performance (including impact
on the rest of the system).  One of the reasons people can end up with
the GPIO controller is discovering some hardware bug in a hardware
controller (like the issues a lot of the Freescale controllers have with
trying to deassert chip select on every word transferred).

> The last patch in the series remove remnants of an unused mechanism
> that seemed to be for performance critical bitbanged SPI, that was never
> put to use, I kind of assume noone is really doing performance critical
> SPI over GPIO but I've been wrong before.

It was never really possible to upstream users of that code, AFAICT it
was always for custom out of tree builds.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpNA9AACgkQJNaLcl1U
h9AOegf9GzlfxoDf6PtCCx7/uq0oE++vshKhhx50Fhttn8cc5Gn+G/VhCKYxLdyX
zv5x83Dy9/rtIThEPGxCZUbP2sAnlE8bel0Ng6WZPfCf0lSpfWIT+QHw2awCDked
Epan/OyXr8T6QbrjasRsfOWNWCBv35z0lApbdyErfatYmmuXoG0kGEvcMG1+e+Ty
5r+KJ45O+vpd0KhSMr20zsbKB2/wNt8gd17Akd4ZpAdgloQyRAqjcu1v1WMBa+Eu
CUSTjX78nm5dD/THBuriXkulZKCoQrZYtxVmpJLdeEOwErEs8eCn5OqtlDz2Qbpg
7HVtSn8nU7BQNixzWR6nxjywozkNUQ==
=8ckI
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
