From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: disallow building on MMP
Date: Tue, 19 Apr 2016 16:06:56 +0100
Message-ID: <20160419150656.GU3217@sirena.org.uk>
References: <1461071933-3273163-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p19/OaUkOQckSefz"
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461071933-3273163-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p19/OaUkOQckSefz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 03:18:20PM +0200, Arnd Bergmann wrote:

> What happens here is that we can enable SPI_PXA2XX when some other
> platform in the same build supports PCI. This normally works because the
> pxa_ssp_request/pxa_ssp_free functions are stubbed out when CONFIG_PXA_SSP
> is disabled. However, we can have PXA_SSP=m when that driver is used by
> the SND_SOC_TTC_DKB audio driver.

> This changes the Kconfig logic to just disallow the pxa2xx SPI
> driver on anything but x86 and pxa.

This doesn't seem like a sane fix, I'd be *very* surprised if Marvell
had created a new SPI controller for the MMP SoCs.

--p19/OaUkOQckSefz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFkmPAAoJECTWi3JdVIfQimgH/03B9BxnS0w8i6IbCCXbI3oj
5Mxc+2CBTEfj/X7wM/Ar4eqpNZntH8QmOAely/MvTSI8vCuCg/xwn6v4EAlewxZI
z8GyQQh/5RzG1P9C6AwZcH5+xMtL5xchfveB4ITcIuu0wtvnPP6MdNj1ZCXTQTV4
K7QOU+330XPFyvs6/OvCpULb91BB2bfoHJLdlmPazZzDCfyFgMmK+SUI2kvyYPkI
dJ7m4G1GQLChksst2Zy1szW1GWTWKVP2qrNaiBKaMlOy620bpwNmnU63JVf7tWMY
HQ57Bc6Nc9NeUkLngvi60AFQaQqsd9nJ3rh+9O4RWn2hVVmFUHCteQvMGHZGueE=
=9W43
-----END PGP SIGNATURE-----

--p19/OaUkOQckSefz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
