From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] spi: zynqmp: gqspi: add support for dual
 parallel mode configuration
Date: Tue, 14 Jul 2015 17:26:27 +0100
Message-ID: <20150714162627.GC11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1436445895-25504-2-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OmEpep6L+R/25PJj"
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
In-Reply-To: <1436445895-25504-2-git-send-email-ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OmEpep6L+R/25PJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 06:14:54PM +0530, Ranjit Waghmode wrote:

> +	if (qspi->master->flags & SPI_BOTH_FLASH) {

There's currently no SPI_BOTH_FLASH...

--OmEpep6L+R/25PJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpTgyAAoJECTWi3JdVIfQ2doH/AmmtPppWJw/uHkEkc0/kP4P
YtxX4R+MLlxHgsRnLnc3NLzq2EGqz8n20BgY68sLnu6YRrpf9Onx+6UuYnVShJXy
+bvwsqvnvFQrO/cOTgnPcVUQHihp/e5xS69X/i/aE+F1eOStYWYmiAFRANoc9sxN
kcE84q7gd0mHPbP0abk0wkHigZBkoT7rt/nO/4ZjGVdWbccA3t921c4ftkU0gecI
Bp1xhTgHVP0NuCzkDVDniVXzh5mxqcHlCp0+cLYoD/hb9tgRgaNTA2Vau2vIqR6+
GUGLpmAncEQlRc5exnAFvI0L/PBu0N11B24a6PYXapwY5ft8Uhy7vwlDb/PIwMA=
=iJMq
-----END PGP SIGNATURE-----

--OmEpep6L+R/25PJj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
