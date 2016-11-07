From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: make architecture specific hardware depend on the
 associated hardware
Date: Mon, 7 Nov 2016 17:49:35 +0000
Message-ID: <20161107174935.25r32yoq626yselg@sirena.org.uk>
References: <20161106222128.24433-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rsy2gb42cho647l6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161106222128.24433-1-pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rsy2gb42cho647l6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 06, 2016 at 10:21:28PM +0000, Peter Robinson wrote:

> There's not much point enabling hardware specific hardware drivers if the
> actual SoC architecture platforms aren't enabled as they're not much use
> with out it.

This really needs cross checking with the various platform maintainers
that the dependencies are correct and it's breaking compile test
coverage for quite a few of the individual drivers.

>  config SPI_DW_MID_DMA
>  	bool "DMA support for DW SPI controller on Intel MID platform"
> -	depends on SPI_DW_PCI && DW_DMAC_PCI
> +	depends on X86 && SPI_DW_PCI && DW_DMAC_PCI

This isn't right - while Intel do use this IP Desginware are a generic
IP vendor and PCI is an architecture neutral bus so there shouldn't be
an x86 dependency.

--rsy2gb42cho647l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIL6uAAoJECTWi3JdVIfQrIkH/2xPW+6WGi2EoQ6DylxFVPkj
BPPPl+t+YVe49BD7Z+ZC01SkBLll4njbcRCLgLxB298dbLRHK8sUHlOf86sIsU9g
nZNvcY8/wG+h5soPk0izz+vO8pjk/ae+zY4mjOrwQHyiJQ7r2Re8sQUmqCSlEYCY
kbQugEltkmZXKTri8C+m/Z2Uua6taTH/wjCGr0MOQqNo14PhorrB8cBWlRqb8uRm
Q1qHYRyPCgo84GUdts2Bc3TNiD2c3avd88kGoMghEkYComoLvxjTjed8e0f1fSkk
j3IdGjj3zDcMOwuEdIJGEA5h6/bY51E7s+K4PFHW9bcTYawAI00j95Z9iRzsovc=
=fupc
-----END PGP SIGNATURE-----

--rsy2gb42cho647l6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
