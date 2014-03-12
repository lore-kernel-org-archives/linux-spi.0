From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: psdev: add passive serial driver
Date: Wed, 12 Mar 2014 16:34:27 +0000
Message-ID: <20140312163427.GV28112@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlQZSM0l8BcKFQ5V"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WlQZSM0l8BcKFQ5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 04:53:37PM +0100, Michael Grzeschik wrote:

> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
>=20
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.

Having read the above I'm still not entirely sure what this is supposed
to do.  It sounds like it might be something to do with programming
FPGAs but that doesn't seem like something for the SPI subsystem, it
sounds like something for a FPGA handling subsystem.  People keep
talking about that, there's a bunch of other stuff to integrate with
there like loading DTs for the downloeaded bitstream.  I'm not sure what
the status is there.

--WlQZSM0l8BcKFQ5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIIyQAAoJELSic+t+oim9yIsP/0e7zdmULwuDC+Z3uFHz7fks
AZu5UCQKb092vn/jMRWhsXm6ZcuBYmVBBuwd8Rqaca0eQp4DDzOiuUTWucBggHvp
igfqM9yb4R5B6cmQWBXNJHXCmIn3bdn3BY27C62L+IqLiPy/ZPJRWRDGlfAoV+Xf
uPck9lTKTJkbVb6OwVECINB0ISN9Pct1C/ZBTvGFi8VKAJMgzazY2QH54vgZXGLV
9JSb+0QDsyTb7SKQpQHRFmj+ITVuh8iBId0adInv7DQB/vxOWs5zuCzCEan5cIXe
xmXYrmbidEzyi6qbs/XXAijSUZ/z7AM8P2AmCpQZct3JlaviT/6lropFMb78a9pv
l1OgZXP0CreTKhMpnMRPijOJBm5A3fX2duit802FJR63dopLhNIXSPxFz3TaBPjl
hmU3THx0oagkvQEFi7AU0jko9xP9FEZBlXxi0H6GbW+ng1DldqUH5DIeD0yhznrm
TLe83m6K9Mg3+pJFFWxVKRzLbBLPqnof1NbjwyeE86l1w5iAx06DJtHt3nHGDDDo
Cvsr1THlp9bgP8RahvPi8BVu9pIphZ3rn+i1+LInqtBuKqPyiHxGRhORtPleTSOC
NX4euS/VnpZaMfr24UcQI9c2geK4lCJNHGVPX0RhQBoqcA9FtcqJ46+fR0cAqWVB
n957S/oi5Eea9+zmV8YR
=60/b
-----END PGP SIGNATURE-----

--WlQZSM0l8BcKFQ5V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
