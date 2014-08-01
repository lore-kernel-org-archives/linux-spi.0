From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
Date: Fri, 1 Aug 2014 18:35:06 +0100
Message-ID: <20140801173506.GB30458@sirena.org.uk>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q4O3w8UJ36hkf4ip"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406911233-18999-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--q4O3w8UJ36hkf4ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>=20
> Currently driver supports only configuration of GPIO CS through
> platform data. This patch enhances the driver to configure GPIO
> CS through DT. Also update the DT binding documentation to
> reflect the availability of cs-gpios.

Ah, sorry - this is the unapplied patch from before.  It would have been
much better to submit this as the second patch after your rework patch
since this...

> -	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
> -				pdata->chip_sel[chip_sel] !=3D SPI_INTERN_CS)
> +	if (np && master->cs_gpios !=3D NULL && spi->cs_gpio >=3D 0) {
> +		/* SPI core parse and update master->cs_gpio */
>  		gpio_chipsel =3D true;
> +		gpio =3D spi->cs_gpio;
> +	} else if (pdata->chip_sel &&
> +		   chip_sel < pdata->num_chipselect &&
> +		   pdata->chip_sel[chip_sel] !=3D SPI_INTERN_CS) {
> +		/* platform data defines chip_sel */
> +		gpio_chipsel =3D true;
> +		gpio =3D pdata->chip_sel[chip_sel];
> +	}

=2E..still looks excessively confusing - it is way more logic than I'd
expect to see on every chip select.

--q4O3w8UJ36hkf4ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT28/HAAoJELSic+t+oim93BYP/Aob5Felubt/RAt6f6g+nXCZ
OknxAUW+YvpXLf42p4amT5uYzv+fNSWpV/S0jt+Qg9c7Fz4kCUFmMkKPEjgZ0BXN
OcX/6jV7GAT6LofFZ02ugvtoLfayY2oy/w5+4+R0efOBbzv2+fD99ftt4JvE2jmK
lre5ZoWH1MZoYl7beP4hw67JgPoGGX3mTu0YhV3+pNZFogfTR3VFg0DD0/jgqooZ
V7RDj4hguc8TlDXqMTiuF2rxluGYsUQ9I6bldvgZ0OtpXDCRKC2jdCoZpEsSkcJq
ZyGU6M+4t1uHci4mEhRwJXH8Ldgop+VRzToOwCjaTOvkvYZoXO8LogJIzo0o9i0f
2bi21C2l5tYYKk4+Z0w1JrnrmSDOcQ5Ze0OcUmhW9wdw0IfIiUoDCz44+FnZ50Gz
7lHFLUKUUAGBT9ZYlwtr2OqG+mTb5wTlr7zTiKnMDeO+ew90UWPhptZLQj6LzFmk
0/FhzaA3wJgy8aI2ubqsl0Gbpsx/vVvysqlaWH1T1i+MJoxWpHvvi+MpfiDUj1JD
Xn0UsRjYXQSw0qKMmcUz6ZWBK1bp2Qd7lJvTxIkMczBxR3a4WZza2ODxRlZw4mM+
RBjuMQkKXXTvVHrNQXVRqvBtG6nviw15hi4jds63LM2l7nhCYjmyImqxaceGC/Oo
4sSo4+IuWbI/YrqFsw1i
=cHlI
-----END PGP SIGNATURE-----

--q4O3w8UJ36hkf4ip--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
