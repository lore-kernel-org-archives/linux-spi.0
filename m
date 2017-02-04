From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/5] spi: Added way to check for pm support for flash
 devices
Date: Sat, 4 Feb 2017 12:25:55 +0100
Message-ID: <20170204112555.p77votp5m7klygbe@sirena.org.uk>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-4-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhzquobfemza2aic"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486164676-12912-4-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uhzquobfemza2aic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2017 at 06:31:14PM -0500, Kamal Dasu wrote:

> Device drivers can check if the master controller driver has to support
> flash pm. The controller driver indicates this using flash_pm_supported()
> spi master interface.

What is "flash pm" and how would a client use it given that no API for
actually managing power is being added here?  Someone looking at the API
needs to be able to figure these things out and right now I can't see
how they'd do that...

--uhzquobfemza2aic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliVukIACgkQJNaLcl1U
h9CaFwf/fI0j+4+tXplMhLnprqxa06Pm8LD5JMkgsZYszNi3hsu7GTuI6NjMl/Ur
Av9KozbatHQj1X25rl2WOdGMWpFKMDY+CcZjNap14APM+nYjOBzYk57Xn+qBklnB
FMFg6e+4VR7DJxS+Um63zEldVHW4+sBFjU4jojwgUqsAS08dLcbyQFHfmE8yzFG6
gDs1O/bnS0nfTHxQnRxxiIa6whHyJYS7OE5ndksXXFJWvVOkRAflZQyIOtSe4sOr
GXicySd3xXYYa/ZBRrNcGT8ETgsutM9DLABqXMmy0oXge40BV7VlVdLCmJSOesN7
7KRcgneo4+1eK6Uwpy+9Uo6aej61Kg==
=3fGF
-----END PGP SIGNATURE-----

--uhzquobfemza2aic--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
