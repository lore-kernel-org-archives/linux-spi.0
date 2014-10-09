From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Fri, 10 Oct 2014 00:05:43 +0100
Message-ID: <20141009230543.GB18557@sirena.org.uk>
References: <1412796428-3255-1-git-send-email-tthayer@opensource.altera.com>
 <20141008200515.GK4609@sirena.org.uk>
 <5436DFAD.2010902@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org,
	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5436DFAD.2010902-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2014 at 02:19:09PM -0500, Thor Thayer wrote:

> There are quite a few instances of the spidev as a child of a spi node in
> the arch/arm/dts directory
> - imx6qdl-tx6.dtsi
> - imx53-tx53.dtsi
> - tegra30-apalis-eval.dts
> - spear1340-evb.dts

> I believe the reason these are added to the device tree is that they are
> automatically probed.

These are all buggy - the DT is there to describe the hardware, not how
Linux currently implements it.  I see I need to add some code to spidev
to make it complain loudy if instantiated from DT.

> If there is a different or better way to handle spidev, I'll be happy to do
> it. This seemed to be the cleanest way and had precedent.

The DT should say what the physical device connected to the bus is using
whatever binding is appropriate for that device.  If that happens to be
spidev in current Linux then the appropriate ID should be added to spidev.

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNxTHAAoJECTWi3JdVIfQP6QH/RBKYoiGGrp/yUKGPmZY8td0
9SXSI41O7ikgz0xa6twGJKx04MiOdPD23oxtzdEFXjKvJ9ZEdWZLtj3XtydnXy4A
B3rlg9pHVSTyTJs468oZzWSFYnNQsvicBYQGd5SVKn1VQca4qnTSL+X+pIgevISZ
LcyViacD2dAQRcdM6uqOQf/gyq0kwCg+C5TYSlumBUbOEWIXsvBMcBMox0eB78q7
1+mMPSnwIqh08l9Ldzfuaf92WBmVj5KIdEhM/P9AIE+N7aS9WdFXqr03bt/xwhYj
OWZPAQJP0/UBJsdD7hD7OuxpMPgCyeqoaP0f0l4kzaVZJ28MG+1PYOOosKqqxcE=
=mfvC
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
