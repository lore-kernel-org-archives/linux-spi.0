From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 10/15] spi: fsl-espi: improve the ISR frame
Date: Sat, 24 Sep 2016 19:45:37 +0100
Message-ID: <20160924184537.lsrfzj6ob6yt4if6@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <7733dbde-1950-d6e3-6d71-975b25d6ded1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4c4ls6s6zrhqx5vx"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7733dbde-1950-d6e3-6d71-975b25d6ded1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4c4ls6s6zrhqx5vx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2016 at 10:53:23PM +0200, Heiner Kallweit wrote:
> Improve the ISR frame:

I *think* that by "frame" you mean "function" here but it's really hard
to tell.  Please try to use normal technical terms, it makes things much
easier to review.

> - move resetting the event bits to the ISR frame
> - change type of parameter irq to int
> - make sure that the event bits match at least one bit in the
>   interrupt mask register

This sounds like three separate changes and should therefore have been
three patches.

--4c4ls6s6zrhqx5vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5snQAAoJECTWi3JdVIfQcEcH/RKL/RPq84Ik8NElZR2yThHj
nqNmET9G462WmuueebRTVzrH4JW3+m3zf85K40VR0KH5j1rcqtoEMCgb9ACis9Te
uYK0t4MSEOBiAtke3MRCurrc/CResffmLiQ8Prgrw+tMoXyY4LBZgRXsjptMSDiH
cAi1VpacHRvVOSNE0UZYGbv0R+Vk/yR6HXHoL08dgtc66iL/sHjPlbmvyFNz9IIQ
1l9vcQs3C1PAx2fTxq3cTK/J57bcqOC97Ui86+CqarJpozHG2NRnhyXMFjqtDSss
fGBgPYFKI88rYe21uVyfWDnifR7YTc05/u+Njzq3nL3VD1lvhwE0Xuh97e+Ps1E=
=RXsi
-----END PGP SIGNATURE-----

--4c4ls6s6zrhqx5vx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
