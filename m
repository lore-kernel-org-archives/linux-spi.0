From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Fri, 3 Nov 2017 19:36:49 +0000
Message-ID: <20171103193649.jcoiy3raefikko2h@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sohhyoroq6sqhlw5"
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509736735.5473.87.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sohhyoroq6sqhlw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 07:18:56PM +0000, Trent Piepho wrote:
> On Fri, 2017-11-03 at 18:37 +0000, Mark Brown wrote:

> > If there are non-standard bindings then mark them as deprecated.  I
> > can't immediately find *any* binding documentation for this controller.
> > The last commit looks like it was more attempting to work round broken
> > board bindings and do something sensible than add a new binding, at
> > least that's what I remember my sense of it being.

> The non-standard part is needing to add cs-gpios = <0> to get a native
> chip select when that is documented as being optional.  It doesn't
> follow the spec.  It doesn't match other drivers (and dw-spi is equally
> as broken in the same manner, probably others too) that do follow the
> spec.

Is there any documentation of the bindings for this driver at all?  I
wasn't able to find it.

> > If the hardware is as broken as these controllers always were in the
> > past and there are workarounds which work in all practical situations
> > (AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)

> Comments in the driver indicate that some SoCs do not allow GPIO usage
> on all chip select pins.

Ah, that's an issue.  We will need support for the hardware chip selects
then.

> > documenting something as supported is just going to make people
> > miserable.  The reason I know about this breakage is that I had to go
> > through the process of working out that the native chip select support
> > didn't work on a system.

> I just don't see how not following the device tree binding
> specification documents the hardware flaw, or how following the spec
> documents that the flaw does not exist.

Hardware chip selects aren't present in all controllers and at times
have entertaining enumerations in the hardware, the details on them need
to be covered in the device specific binding (which like I say seems to
be missing for this controller).  If they just don't work well the
kindest thing may be to not support them and document the binding that
way.

> > Yes, better documentation would be great.

> How about I add something to Documentation/spi and add a note in
> Kconfig, but make the driver standard compliant in its device tree
> bindings?

Writing a binding document for the controller would probably cover it.

--sohhyoroq6sqhlw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8xVEACgkQJNaLcl1U
h9CcNgf/blE6FKozZjZp8jGE+NvJDjSbLoNAOrGB0yWoTLfh3140w4jorSeaBLRs
25EMnamVDDgcsvAxb3y942z2fnCAokAlXAsb/7ux8FvDjUYlXJxcxHsH/v9ggx8Q
t7fpBcewOV45pm3AwjdZxlnbmqyJz2vTZAYjScjo4yQzHXMVWuNexTJ66WHny93A
jg1HrD31G+aFiKT+NBinQS33pImCzvlYWsGUBDSDkNnfsnQsAzyFkLger6bgDkhz
kVErwv6m3zhJkj9Z0wqwRymCE78T01eV5leNbXXSW8nSWc4AJAOVr2VXdNm6BZex
Ps50B4kF30ehGwSq3RjoaccwR0u+DA==
=Tf9J
-----END PGP SIGNATURE-----

--sohhyoroq6sqhlw5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
