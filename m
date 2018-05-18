From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-s3c64xx: Fix system resume support
Date: Fri, 18 May 2018 09:34:11 +0100
Message-ID: <20180518083411.GB24209@sirena.org.uk>
References: <CGME20180517102518eucas1p10e55ae3c884f6fe29b37c01eff0fe7a4@eucas1p1.samsung.com>
 <20180517101508.25867-1-m.szyprowski@samsung.com>
 <20180517164102.GT20254@sirena.org.uk>
 <CAJKOXPegbcXzy7QYpt09pXKcHaLji0Xyy+nmYz+wj+_awqAG4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-spi@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, Andi Shyti <andi@etezian.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPegbcXzy7QYpt09pXKcHaLji0Xyy+nmYz+wj+_awqAG4A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2018 at 07:33:03AM +0200, Krzysztof Kozlowski wrote:

> The point of resend was to add the specific cc-stable tags with a
> prerequisite for backporting:
>     CC: <stable@vger.kernel.org> # 4.10.x: 1c75862d8e5a spi:
> spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
>     CC: <stable@vger.kernel.org> # 4.10.x

> Unfortunately I saw that these did not end up in patch you committed.
> Mentioning required commit is, I think, quite helpful for stable guys.

If you want to mention the commit being fixed then use a Fixes: tag.  I
was complaining because I'd already applied the commit before that got
resent so I had to try to figure out what was going on with it.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr+kAIACgkQJNaLcl1U
h9D/fwf+MUZi/FPGYEwovQWGxYt5EiE2yl15583FjuWsiT8ZPNn+PgyeCA+aUuss
JQrW6llC5B4GX4nz1Ac67lkzmoGkdz5nohRO0cmgwPmKCjTPzC/K0ejRUnrpY98u
2qDvHACQmH3MlYkpWCXOcH7gJfHRMlFcrSGaZZHpqn9SXkQZYVHb0MrriDoo2Dnj
Tco4BYphkWFUwODEEUYiixQOS0T2sALzAG6q1oNgZvHrSOfLuaP8vYFoXYYXO8HI
yH73FOIwUx/nCcLkiEMyfy9YW3l6OBaEPZ+jB2y33vlGJGzp/9QTFjhUywkXx7iY
iMGbgEjwohUThKzLFMf4S74Y4cH1rA==
=u4A0
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
