From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: fsl-(e)spi: migrate to using devm_ functions to
 simplify cleanup
Date: Tue, 25 Aug 2015 18:26:44 +0100
Message-ID: <20150825172644.GD12878@sirena.org.uk>
References: <55D9BAAA.7060401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D9BAAA.7060401-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 23, 2015 at 02:20:58PM +0200, Heiner Kallweit wrote:

> -	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
> +	mpc8xxx_spi->reg_base = devm_ioremap(dev, mem->start,
> +					     resource_size(mem));

What would be even nicer here would be to convert to devm_ioremap_resource()

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KVTAAoJECTWi3JdVIfQRbYH/jWKI1FYa0+PiPiDKpzsOX1M
ibaVG81Iq+vSLRsmqZQh86Zkf/9yjRcJoxE/MqfTxv89EJP3qWAE/NOE2S09HP9b
bY3vKe6sNDwrO324f7RSifOUO3UxzVG9M81j9TpaUZSOwjPIfQJdA8VBlQuYBGGT
LEx63ePZobXTf2/6TWQCzt0eIzDVQK2wEhYly4Sdj3itg9b1ZeKtBGL8wZaWgIVX
+Um2bN6l1lit7bKEtTgPzjjATNN6bk+lbmkU4DUUhKELawoBQ+ZtHhT7KDQnB04Y
cH7aRp9xGGpNTMoPBWToRST4SI4n2Abf7gCeHerUTNTeBZD95k4XqXsoiiQYPgQ=
=0PBc
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
