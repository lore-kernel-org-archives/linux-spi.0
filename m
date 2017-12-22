From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add a sysfs interface to instantiate devices
Date: Fri, 22 Dec 2017 15:56:03 +0000
Message-ID: <20171222155603.GM1827@finisterre>
References: <20171221200309.17967-1-kyle.roeschley@ni.com>
 <1513890342.26695.4.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Cc: "kyle.roeschley-acOepvfBmUk@public.gmane.org" <kyle.roeschley-acOepvfBmUk@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513890342.26695.4.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 09:05:43PM +0000, Trent Piepho wrote:
> On Thu, 2017-12-21 at 14:03 -0600, Kyle Roeschley wrote:
> > Add a sysfs interface to instantiate and delete SPI devices using the
> > spidev driver. This can be used when developing a driver on a
> > self-soldered board which doesn't yet have proper SPI device declaration
> > at the platform level, and presumably for various debugging situations.

> > Inspired by 99cd8e25875a ("i2c: Add a sysfs interface to instantiate
> > devices").

> The i2c interface allows one to specify the type of device to create.=20
> Why must this interface be linked to spidev and only capable of
> creating spidev devices? =20

Right, that doesn't seem good.  I also can't see anything in the actual
code which suggests that this is tied to spidev except the log messages.

> > +						   dev);
> > +	struct spi_device *spi, *next;
> > +	int ret =3D -ENXIO;
> > +	u16 cs;

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo9KxMACgkQJNaLcl1U
h9AQRAf/cxBojaxY4ljt/23bIqPe+C6tQGMDe2pJfO9NFe55i19iZOHuJ52w6Ign
fwzC/G5b9GtPXFfTvnlrkiuT1DudMxvwQoUHRVAS1WbYDHySaqiGyFOMwTJSpT6W
9x2DWRUlwaIn5k5vhb06rCP7yV5O9UPXT0l6wrjlk8+e+PBUUNK/siq3gCr4s5vK
Cv11PelYY7Jr2FIVWYxAROkx4iZJOwlglsROKPG2QBifTfp68CImNM9u7NflbQmm
CM0dSw+QvFA/FrlSevqL6Nj4QXJ5RIM/DzEIW4zgjbOV+dmfOxRpWJPaKrPvFw5T
BL9Ck6tSTblQIMZ4qdFYYZ63J/Yc8g==
=5JYI
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
