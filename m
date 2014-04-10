From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] SPI: Add driver for Cadence SPI controller
Date: Thu, 10 Apr 2014 23:48:25 +0100
Message-ID: <20140410224825.GI6518@sirena.org.uk>
References: <1397132030-2440-1-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mMdCh5/a0q2ATNCM"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397132030-2440-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mMdCh5/a0q2ATNCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2014 at 05:43:49PM +0530, Harini Katakam wrote:
> Add driver for Cadence SPI controller. This is used in Xilinx Zynq.

This looks mostly good, the issues below are very small.

> +static int __maybe_unused cdns_spi_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = container_of(dev,
> +			struct platform_device, dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct cdns_spi *xspi = spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +
> +	clk_disable(xspi->ref_clk);
> +
> +	clk_disable(xspi->pclk);

You're only doing clk_disable() here, I would expect the clocks to also
be unprepared over suspend - there is no value in leaving them prepared
that I can see.  Just use clk_unprepare_disable().

It would also be good (though not essential) to implement runtime PM and
disable the clocks while there are no transfers in progress for a small
power saving.  The auto_runtime_pm feature in the core will do the
runtime PM calls for you.

Otherwise this looks good.

--mMdCh5/a0q2ATNCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRx+1AAoJELSic+t+oim9YVkQAJ2dUex91vcYl6b65nAPLgvJ
i8TriQvUQ5Sa0x4SJiaNp/42gnDDZY0697g4OL6SNozLmhbK+e4rJGH0pIW6Qnnw
2c3oOj2zoImBaKC3psdXbwNAwib3AGFpMCXvL+xJr6vQUuFKoSne2R1WI4YbT+NA
JGR4IVXhxU/pLF/xFXUMMFEMMLnf1g56GukVILzehocAvpBqOm0mXeoZrUDBJRxU
4NYGQE+EGDZKRse4UryQ/LcgZreHUuaMTAj93B+emrmxwixhJhKVOtE1iLsDwoCV
olUQ81ZmiKNVNY6cE2+9z+nDOxRdjCoqqPG5SOViFJAPZa9ot6/4PrpmD89DvtiR
t5TzdkZMoHRvz0PahpE+aR5Crv5GTYX5WulrGmWCN12v42Op6uceh0PBpEtg9lVV
fcbnRPFC2WqZzdiSCcfP3w8neVpQlsCz7ZyQThmEJvX75FUvj03eL8NWfIWIdckw
JojHpijnbhWpI1lvOLoHOLJcq336mUmmxe9MbsE0mUI2noxq6XMz0hpPc3THGvwT
1rR07nG3Ib2t0XdVXNIvh34vQhOc6xISDkUgK2CrsC+GGAnp6wtFmi53kDOGH9Ru
yPUe66bNNeP5HF9QQHLyszWnwCA37928pbQK/iSFjBw9YlWJzxMYZ9W6blNI0KK+
vvxIXt5Zr1YivmkvaYGM
=3GyS
-----END PGP SIGNATURE-----

--mMdCh5/a0q2ATNCM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
