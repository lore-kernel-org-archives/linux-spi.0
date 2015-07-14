From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Tue, 14 Jul 2015 17:40:05 +0100
Message-ID: <20150714164005.GE11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BC0PqexbI+QDQ83Q"
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	marex-ynQEQJNshbs@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org,
	ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BC0PqexbI+QDQ83Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 06:14:53PM +0530, Ranjit Waghmode wrote:


> What is dual parallel mode?
> ---------------------------
> ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
> 2) Chip selects and clock are shared to both the flash devices
> 3) This mode is targeted for faster read/write speed and also doubles the size
> 4) Commands/data can be transmitted/received from both the devices(mirror),
>    or only upper or only lower flash memory devices.
> 5) Data arrangement:
>    With stripe enabled,
>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

For the SPI code this just seems like SPI with an 8 bit data width.

> What is stacked mode?
> ---------------------
> ZynqMP GQSPI controller supports stacked mode with following functionalities:
> 1) The Generic Quad-SPI controller also supports two SPI flash memories
>    in a shared bus arrangement to reduce IO pin count.
> 2) Separate chip select lines
> 3) Shared I/O lines
> 4) This mode is targeted for increasing the flash memory and no performance
>    improvement when compared with single.

This is just a normal SPI controller from a SPI point of view.

--BC0PqexbI+QDQ83Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpTtkAAoJECTWi3JdVIfQAWgH/2jTg94UlpB2zKtJL/FOWWzm
TLJv6Kx5gYzLvin6CWk8Ww8y0BJ6SKImSo/e9xGY4vK9lPHPYpkluGMZchap74gG
toVIkiAvXvhqhKHzeb5HnOPEXEIuJmod6U8eR6xLUkj3j2YDUx1hqp4GIDngRTU1
DF1pojb0u4oejEg4KafdByjkVrs49sjBX9YVg2c2b2CQTiLOojJXSqf90NZ7eWmp
6B0Gw0ikbpVELvnoEL/BK7xjDolTJXdO3Nb8HfTV8+bSysd24SOHgnwG+vuDpDoG
7ESsyXQ0P1thcoWkiPDJrYhuIPqrOiMiC5EkjOYkxSBBXSWe20k/y9Ww3AixsFQ=
=4RN1
-----END PGP SIGNATURE-----

--BC0PqexbI+QDQ83Q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
