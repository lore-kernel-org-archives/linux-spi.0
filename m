From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: fsl-espi: remove unneeded check for
 SPI_QE_CPU_MODE
Date: Wed, 26 Oct 2016 18:07:00 +0100
Message-ID: <20161026170700.GD25322@sirena.org.uk>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
 <20608368-44e6-21f8-d970-5ade9990ce59@gmail.com>
 <20161006154543.rxlrc3sumejozpcg@sirena.org.uk>
 <bbe77580-1ac2-4071-5d7d-f786c54ad177@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bbe77580-1ac2-4071-5d7d-f786c54ad177-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 08:36:29PM +0200, Heiner Kallweit wrote:
> Am 06.10.2016 um 17:45 schrieb Mark Brown:

> > Shouldn't we be warning if we encounter a DT that has this set since it
> > probably indicates that something went wrong?

> The values of mpc8xxx_spi->rx_shift and mpc8xxx_spi->tx_shift were
> overwritten in fsl_espi_setup_transfer anyway. Therefore the removed
> code effectively was dead code.
> As we just remove dead code and don't change the behavior of the driver
> I see no need to introduce an additional check / warning.

There's still the potential to either uncover an existing bug that only
worked by accident or to catch some future bug that someone introduces.
The existing code may have problems but that doesn't mean it's not a
good idea to do a good job now.

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEOKzAAoJECTWi3JdVIfQndUH/jTgsTgB7ygqilJhl+MbJWjQ
2U79x6VJ0UL9h3IpAQ45a6RAzRF8JBQMSVvkgN2E2INMhLzogq7cr0ifwz7AqPDI
KQYXGOcMcti2r7MAhj2Rtazmj9P1iEinD9Z9smOdZIy6d0c/qtA/CA1jOA2lf1Ne
MyQ25OUd2tG8tZEuBRczRjGa23qvrYX75XV7uVKSXg2gw15hPO+o3qZ4gneQi/OG
FJb0C3aS3gTjLIOIbLJhcXACGtxoFsLfYyWRFemtRkU4KbmByhzH7L5pQck1x8cS
1+HDMNCKiSTAGMRVKYNCpFITb9+zeHnETNsnduuYDfXwR6ux9SuP7sBicLuTExE=
=u90b
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
