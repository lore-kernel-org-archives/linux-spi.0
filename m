From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] spi: zynqmp: gqspi: add support for stacked mode
 configuration
Date: Tue, 14 Jul 2015 17:28:06 +0100
Message-ID: <20150714162806.GD11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1436445895-25504-3-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iYlQhtYNd1Y0HGg2"
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
In-Reply-To: <1436445895-25504-3-git-send-email-ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--iYlQhtYNd1Y0HGg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 06:14:55PM +0530, Ranjit Waghmode wrote:
> This patch adds support of stacked mode configuration for
> Zynq Ultrascale+ MPSoC GQSPI controller driver.

> +	} else if (qspi->master->flags & SPI_MASTER_U_PAGE) {

Same here, there's no definition of SPI_MASTER_U_PAGE.  It doesn't sound
very generic but I'm not entirely sure what "stacked mode" is.

--iYlQhtYNd1Y0HGg2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpTiVAAoJECTWi3JdVIfQLi8H/jkXLzsBxKK52xQsByI3VT04
lbZ/MP0v2l6XGuM/c7zlhS0H2xffdn2UO91XjPqBR5q1Bj6CTjthspzIa0NcbLMy
PTa4hZ++sslZgJAG4hjO8HZkFpcJ42HiRFdBJJTm0Fa0WD6R6lSlYxhEUcsSsmgq
icLUBY8/Z1eYh7DUSd0VeO2XdgtLBJGi+PQMLqlcFMyarPkaiwFQXpUOaVGdzaEJ
BxxEuyOZcE7y6xXiuLRnm3JAOlhsF767WTdgHrKgocMpYlaCrXmg8AFDmul9NYZ+
zqPota6joYcxUdsVO8Bc6gxN2yebdceaar9TmqtksMs1yBLTZE37/7QKbXkuWFA=
=ghHT
-----END PGP SIGNATURE-----

--iYlQhtYNd1Y0HGg2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
