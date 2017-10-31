From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/4] spi: imx: Fix failure path leak on GPIO request
 error
Date: Tue, 31 Oct 2017 20:01:43 +0000
Message-ID: <20171031200143.iwhoennvpwvqspnf@sirena.co.uk>
References: <20171031194907.29108-1-tpiepho@impinj.com>
 <20171031194907.29108-3-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahy5auejb7olrwiv"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171031194907.29108-3-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ahy5auejb7olrwiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 31, 2017 at 12:49:05PM -0700, Trent Piepho wrote:
> If the code that requests any chip select GPIOs fails, the cleanup of
> spi_bitbang_start() by calling spi_bitbang_stop() is not done.  Add this
> to the failure path.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--ahy5auejb7olrwiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln41qYACgkQJNaLcl1U
h9BxxAf7B4ca16Td/VbDphvOxNDF685YQ3XlsPhMiO3UV+T+aKAihuymWa1m42K0
Rgj5KSdb3zXY72l5zLsRsPcMMqUDXwES064JSX4i6I2WlCSP5ccqvTj6aCqoE+DX
qdNx7xEqJNvPlO0KW8CopEBSxiOyWzljmuSAV1nQPyPfrDeVnFjUZKB6qBYiBqGK
HC7znwfavBD3UdBoWtrCgObWQjKRm0dFN9obkTSUacAdgdXkScpnrc4CsC5PRz1X
h63zqZiumF1YdkIcr/xeKNa/T1CYj7LXVxb8LPjWykvfbRe7tGaclTutjuTN/Wz6
DnE2Az2k/3sRExOuRE5HOCn4okNMiw==
=dmha
-----END PGP SIGNATURE-----

--ahy5auejb7olrwiv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
