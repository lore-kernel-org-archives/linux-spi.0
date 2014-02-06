From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Use of_match_ptr at appropriate place
Date: Thu, 6 Feb 2014 12:56:40 +0000
Message-ID: <20140206125640.GO32298@sirena.org.uk>
References: <1391658308.12574.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uX2tiToO0oGq+LKk"
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391658308.12574.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uX2tiToO0oGq+LKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 11:45:08AM +0800, Axel Lin wrote:
> It's pointless to use of_match_ptr within CONFIG_OF guard.
> Use of_match_ptr around davinci_spi_of_match when setting .of_match_table.

Applied, thanks.

--uX2tiToO0oGq+LKk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS84aFAAoJELSic+t+oim9Lt0P/iDMVP7kwuw5SXfXfjCG5bxF
zd6fIIWOJd30WNj9KVk4NW/Aypk5Z/bbfbyblwdctSIXlzVWxZv8AHyGI2ptUETb
0OPQtr4t+Quh6v5S+Mc3atwlIveVvhovR4fHMikHIdfmDf5ahSnxdn6pvOTXIElZ
IO86/8CuMQRSSdKtztq+BepEqNWWtblUJgiOV1spWXBOKK0iKcWMWBFTaUZ37JuD
k790e2E6Ish6sdtG9m3jYRt0zoIyfvI6+wP1gdSTpn4WCzYCCjQT0DrJgV0eedfe
+OR3ToMBaVkp9Q+Kc5Fwe+jI9lTy0d8UAs5nJAZIJHaD9mePSu7MBnYBM+m6AVlN
cNlG/KRWAJwElMedSL4YmaYfnhocwgpbTaPtlD12d02EY11zoCcfFfLDCZ1+hphc
Op4PCuNxkYnf+yJCVkcs/rf+BuMSRZFEYOO1bNE+jsnSMj0YyYpFk1VIeZgY2Zeo
X+5tP3TRW2lwPlPC20yDdLsU75L5behFM78mbkxOwqmFdYFeICllYU1ZVyQmMtYh
jVjnxanbxI8hbQjR+oYNXMRfQFI3pi/lWVmt50FmMUkvnbIEW7TxE0w8ZiBFn66L
TQQ7T69+FSvZCqZ0gX23/kLZzZhUyQTLXc2bbB0XNZRFzG2NUe2lY5MoCC4WjrGv
WaaGNaViSj1QvF5LYfWf
=kVrh
-----END PGP SIGNATURE-----

--uX2tiToO0oGq+LKk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
