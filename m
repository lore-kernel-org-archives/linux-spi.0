From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: pxa2xx: Remove needless includes
Date: Mon, 23 Mar 2015 09:43:54 -0700
Message-ID: <20150323164354.GF14954@sirena.org.uk>
References: <1427112468-26782-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427112468-26782-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 02:07:47PM +0200, Jarkko Nikula wrote:
> These asm/io.h, asm/irq.h and asm/delay.h are needless since they are
> already included by linux/io.h via drivers/spi/spi-pxa2xx.h,
> linux/interrupt.h and linux/delay.h.

Applied both, thanks.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEELJAAoJECTWi3JdVIfQktMH/2DjLmgxoAcSGTOEox0jwvVN
dyWklYk9zE0lFsXT53UwHuL9yZIWlbwR5i5eY50G6F3kkFVY8NeeMDP/XVgaFQXP
SUAd0TwA/TpunHxtnGR3hLzdgJUIhZ1gSdXRBbV7qlgQQbLJvzfqobYJYQbi+V+P
Uc59d4yAVWmu9IEPIzLOeEWZeXXSHsb3U+duwm7m5GE0mH0ZY0epEgVTU40IAcEU
E9JKVQeMbrVmZ8cdlMe9ZXwt7lEMhe/C9vncexjk5alUnaot5Q2I2OKFz0TbGnur
S7bladzwxyr0tjM0xofcgNuqMXQjwQFWiCm5lFF4eEE5x6NYpnxAcfci2eruQVA=
=7I9A
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
