From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based
 chipselects
Date: Mon, 2 Dec 2013 11:43:10 +0000
Message-ID: <20131202114310.GP27568@sirena.org.uk>
References: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3duvV/J7KUqO/slB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385884756-31373-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3duvV/J7KUqO/slB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 01, 2013 at 11:59:16AM +0400, Alexander Shiyan wrote:
> This patch takes the CS active level from the GPIO bindings,
> so we remove the special property "spi-cs-high" for chipselects
> that use GPIO.

Unfortuantely this would introduce an incompatible change in the DT
bindings so we can't do this.  Updating the documentation to deprecate
the old binding would be OK, though I'm not sure it's a great advantage
since it means you wouldn't be able to use the same binding with GPIOs
as you could with controller integrated chip selects.

Adding support for using the GPIO binding information is fine but
removing the old method (especially without a binding update) doesn't
seem great.

--3duvV/J7KUqO/slB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHJLAAoJELSic+t+oim9nZoP/jSy3oRZA8xBLhBA9mznmqxu
QfpB051LvoIM4u9AbOVt7nFniA8yhn/skGSa2FLspQsP4cxQSwYTEeSD4Q3Lh3DQ
Rotk4FrPzDW4JI1D5bN0HFEnrxLSrSK7opwoTIpg3ESfQ61aHlRSdI5J+05/DsGg
GTfz5NZXhF6csFGA1ISWo5c2mWot2n+US8DcA0TvdhY/bLfdOV9N0bCNJgI35hU7
ZPiQ0pO2UgvAYIhmZpIBZtJx92A4V9QT2WXN9W7XaVqy1i3u/WX93Zl4NvIu9lgw
nSy8eDdRv/vfbZwJX3XvyPjSyf9+8HnA6FiAZlSFPjSZndkHG376ucF5RN2VAfFL
fjqd/Aw+oKk6tQDtHDYRGxUtImlEvUs+S567ZFDwZM4kXCtj3XuswI/fMmkAukM9
73XTZk97utiK5yVr56nbNl+kqOHyl6eCpUQRcC1DlRDobaD0GAKPGfLv1VtMQY/s
X2oXoas5JmGIXaZW04JodccvENWnMOOcQw/1bLO5FuUmdNr/ZK+fYLblCy3d859+
Elw8+qkin1hTw+nwwzxkpWjqlFrRXiPIIAEitdcsBi0qJPQWImtsQVyopER8J/xg
o0ccRdx4w3JFxtT6hIgZblBTfT8nAsPgf+huqn4FphfTHK6R69I/ELB69oHFjnr5
zjL70J9TRc0ETP1FZwbZ
=sGf5
-----END PGP SIGNATURE-----

--3duvV/J7KUqO/slB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
