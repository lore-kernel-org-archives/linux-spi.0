From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date: Fri, 7 Jun 2019 17:05:39 +0100
Message-ID: <20190607160539.GI2456@sirena.org.uk>
References: <20190607155631.15072-1-paul@crapouillou.net>
 <20190607155907.GH2456@sirena.org.uk>
 <1559923340.1918.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LPYkZes1JsE9T1lX"
Cc: od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559923340.1918.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LPYkZes1JsE9T1lX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 06:02:20PM +0200, Paul Cercueil wrote:
> Le ven. 7 juin 2019 =E0 17:59, Mark Brown <broonie@kernel.org> a =E9crit :

> > Hopefully not since we might probe later on if something registers a new
> > device...

> Makes sense. Sorry for the noise.

No problem.  There used to be an annotation for probe() and remove()
functions but it got removed since hotplug and deferred probe made it
very difficult to ever practically take advanage of it.

--LPYkZes1JsE9T1lX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6i1IACgkQJNaLcl1U
h9Ctggf/ZkWVbeBDP7S/xhHdF5lonQeFIVA24awMWy1BPO+zdDas4oSFwUBik4c4
u+krCzZdQzwLx5ZTHPFSP+cxhvYy0HV3hQxIXjhCFS7JupiL1npDKoCLGjvKSCYI
5hMjEASlUQYk0XiRBVfnEKshR7dPq0UBcRkgCnmo7xOpxaeg75vfjtePZmGYNPKA
q3aDOK9Z7fGJFzF8qSDAUrofo7D2DiWZRuH8/aB6W46IAstodUZjLOS9cnU+SC0e
GQ+hj4XaJg7Jfmy3SAeck6fmDOF6+Xq5hulHItYU+nzYLOLGZiJrjiHzf9ilPNyG
7wU+IQpIiKYRkfo5BIueEGnAvKUf3A==
=UR4I
-----END PGP SIGNATURE-----

--LPYkZes1JsE9T1lX--
