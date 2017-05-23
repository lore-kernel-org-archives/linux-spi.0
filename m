From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: imx: dynamic burst length adjust for PIO
 mode"
Date: Tue, 23 May 2017 19:22:38 +0100
Message-ID: <20170523182238.fekbuuzgah6occrz@sirena.org.uk>
References: <20170523123827.22408-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7nx5jt7rwbfb5afk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170523123827.22408-1-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7nx5jt7rwbfb5afk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2017 at 02:38:27PM +0200, Sascha Hauer wrote:
> This reverts commits 8d4a6cad7adb3ddac32cd52635f20e11de11a658 and
> 179547e143e773f9f866ad3536275ab627711f3a.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--7nx5jt7rwbfb5afk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkkfe0ACgkQJNaLcl1U
h9AGewf/XyW438NCvYPCrDK22Ki10/Db+DhQbnYfPrW/eIyK4F54hdl+VZUI1EI0
g6sSCu/pYmvlXYtRJd849/RZ9BnzSnjBoGPhSiJKGe3OjbHBg0iN5wufmcxEh6RV
Tnv630p1ZkhUCumT/Uc9U9JZfvw2fCzmvCw4iak9hKCCzj7pLrziyEyIVpaTMpN7
NJkG4EsJ/t7nMYK80BmYcocbzVrO7egbFwHnSbFd6WDLlbQQJWSgS3fjMJLfX2eo
jiKggEslK3GGLtGVkA1Stzq5t5Hdo007UmWR7lte4GE4Lt4xrvRryfaNIRYKi+Mr
4kPD4/kNfR+0CdZ6KUjHHRxudTO0Pw==
=awOI
-----END PGP SIGNATURE-----

--7nx5jt7rwbfb5afk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
