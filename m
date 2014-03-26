From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-uwire: Remove full duplex check
Date: Wed, 26 Mar 2014 16:41:28 +0000
Message-ID: <20140326164128.GB14287@sirena.org.uk>
References: <1395832928.19941.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Cc: Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395832928.19941.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 07:22:08PM +0800, Axel Lin wrote:
> This driver sets the SPI_MASTER_HALF_DUPLEX flag, so the spi core will check
> transfers to ensure they are not full duplex.

Applied, thanks.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMwM1AAoJELSic+t+oim9sUsP/R0zCrrejfiCvwXpUFwIMOhA
/UyqQJn1F6m+qEekzTrKwIr+6dycM3W9PO+jYyDnhP1LCyR1KAi26KMWwgckzMOy
+/O5ESpPBF34SG6nsGXyZxtBtFVSXJqlnJb8E4a4UXDp4Iw+x1B4vDXYJCc7yLkw
S1ADWNYm9KASDkqAoYZt2j5talCdRWuYCXe7Se+HOKpItx0z2DfJNv7iUpJEAPow
WJ8v2HDo5BHLvYL22A/Xp1KIS4cqgIHE5I2Zl/H7t7j7t7IfP0zOnB2GPlDdxh4J
+mjnuJpgXSMrgsYk5AhaYpzjLaXf7jRfEmgJ2laCN9Rklo9V+XWjvkziiGbM794j
38Fb/+07AdNYhtLr4XmBvDBW8FxkFqEGvRUmX0neuPA76h+Gc8cqjcOjZ95deL1j
62A5fh7u7Xo+qeH608niFJViHq8IieWMW+kqZINhLjTcPzqqrSBsKqbqIy5VcjwE
3+mbE69eCzZkfRmOY1fX/68hw/0Hjj27/ZTcKkd7zHfBoC11dmqmfflkNfXh5fxc
asHVLucJniw/QknhgP0qjwihqnuV8gGsrdKMyq/bpkeLvARGJ4Vf0yycVB42DFdR
KIDdvvtKUTxc2DysYw542fYyCUdWgqblF5dptXyDJuEOo72X1GqR+HWIF29tLyrh
jjv9AJMyN/xCcFGVescs
=Q4ht
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
