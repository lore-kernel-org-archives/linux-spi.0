From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: fix ecspi mode setup
Date: Fri, 23 Oct 2015 02:08:47 +0900
Message-ID: <20151022170847.GA29919@sirena.org.uk>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
 <20150714134934.GV11162@sirena.org.uk>
 <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andrew Kuksov <qxovxp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 07:06:36PM +0300, Andrew Kuksov wrote:
> >> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

> > What is the problem and how does this change fix it (this information
> > should be in the changelog)?

> SPI_MODE_0 and SPI_MODE_1 requires clock low when inactive. SPI_MODE_2
> and SPI_MODE_3 requires clk high when inactive.
> Currently driver can just set bits in fields SCLK_PHA (SPI Clock/Data
> Phase Control), SCLK_POL (SPI Clock Polarity Control),
> SCLK_CTL (controls the inactive state of SCLK) ans SS_POL (SPI SS
> Polarity Select) of ECSPIx_CONFIGREG register.
> This patch allows driver to clear corresponding bits in these fields.

OK...  when I was asking for this to be in the changelog what I meant
was that you should send a new patch with a changelog including the
relevant description.  I've done that by hand now.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKRgeAAoJECTWi3JdVIfQ4xEH/1mySCdz7tYzrkDKF8/oqP9j
L2/dZlJg7z3WOG7QKyo4tDoYFUfm5nm3ETMhyoCeUZYC/y/u5egH7Nxawikv6Pka
r6im+vyJsQfe7o3O3c2bKqRFX2xruTaDaWY7l+PCLtKpXAvtuXHKnkB582JlVtXC
y9IYrLMbw2gzijbh8gP8Ujx7Yxz5EDa2vwiMPjNg3CYQXi+JsvHOsCI/y3bwgC3z
MJM6tepRCdjzjyKLYwlIhPDlKbxqj0RPovK492dGej5oKGAsMvJD6b0BHgoLlTjp
rlrhT2FyH1iMId4Rm7082ncIys8yPRXijUwr7socHPdzVDF4LsyRH+ReWPtBn70=
=6meu
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
