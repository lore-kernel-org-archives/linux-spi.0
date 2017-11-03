From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Fri, 3 Nov 2017 18:37:00 +0000
Message-ID: <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afciwvqykpwy4eef"
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509731639.5473.60.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--afciwvqykpwy4eef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 05:53:59PM +0000, Trent Piepho wrote:

> Just to be clear, one doesn't need to use GPIOs with the driver as is.=20
> But the bindings to do that are non-standard and these patches make the
> driver follow the standard. (and don't break anyone).

If there are non-standard bindings then mark them as deprecated.  I
can't immediately find *any* binding documentation for this controller.
The last commit looks like it was more attempting to work round broken
board bindings and do something sensible than add a new binding, at
least that's what I remember my sense of it being.

> It's unfortunate that this, and in my experience every, SPI master
> doesn't always (or ever) generate the waveforms it should according to
> the Linux API.  But I don't think not following the specification for
> the device tree bindings is a mitigation of this.  If anything, it just
> creates more problems.

If the hardware is as broken as these controllers always were in the
past and there are workarounds which work in all practical situations
(AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)
documenting something as supported is just going to make people
miserable.  The reason I know about this breakage is that I had to go
through the process of working out that the native chip select support
didn't work on a system.

> If the goal is to document the hardware quirks, then shouldn't this be
> done through documentation?  A note or pointer in the kconfig,
> something in the source, a better description in Documention/
> somewhere, etc.  That would have a better chance of being seen before
> hardware is designed, and would explain the issue too, instead of just
> appearing as another quirk in device tree bindings.

Yes, better documentation would be great.

--afciwvqykpwy4eef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8t0wACgkQJNaLcl1U
h9Bkdwf+Pe8OuwTEINoDuRoLj/XXa4vNBHXvTCplVzHMw7YK/7KUPDxBhKxTlMme
sr9FPgR29JbI4SzcyU4NRaSfDU3GIKRAxSsIbXwwUIbqFo82s2YCo2WMXF1Gie8V
P4a0xVDmmoVNFDEdg9gA/uYSoMlrVZJbwPgJsA5o9hNHKNLEHYO89zSUBI1fstHn
HHSqZRwnOnZ1JT3+vooFwVGPjdYx23+jpg51WZ0POJRYk1g27T2dCDG1NKK8M1iY
Io33gyzQKuqcjRo2317WVmL4cOBfoNofZokGEUy/8TSaKx/Syw9iSOFq5C6ATI/Q
GAII4C2BOwBPVoUmAHtvesGdDN9RHw==
=d8Md
-----END PGP SIGNATURE-----

--afciwvqykpwy4eef--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
