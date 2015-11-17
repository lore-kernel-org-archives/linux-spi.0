From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/8] spi: Move spi code from Documentation to tools
Date: Tue, 17 Nov 2015 18:11:17 +0000
Message-ID: <20151117181117.GA31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <7f1a4995f0e48b738d3aa4f4d8ddd210a0ae2b24.1447773299.git.stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6nDKxlhctiV7bVq"
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7f1a4995f0e48b738d3aa4f4d8ddd210a0ae2b24.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--d6nDKxlhctiV7bVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 07:24:28AM -0800, Joshua Clayton wrote:
> Jon Corbet requested this code moved with the last changeset,
> https://lkml.org/lkml/2015/3/1/144,
> but the patch was not applied because it missed the Makefile.
> Moved spidev_test, spidev_fdx and their Makefile infrastructure.

Trivial moves like this should generally come early rather than
later in the series so that they are easier to apply, as this is at the
end of the series it depends on the entire series.

--d6nDKxlhctiV7bVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS23EAAoJECTWi3JdVIfQxrsH/1ZZ+pJHD1fBWeJKtYYS1EJC
f+lXS4vf7cv6ESEOIdnJp4xAEHGA692iUY+x5AqwsCpa2TxReVYO/ac4IyjvCQNV
4s9cvf43hfESUY7CGXXefCCtC7Dc+QG3mQ8hPmal+RJbRSjeEjW/6+npmSXuqoIa
AZbV3OEzVNvi1qhDGDNT4v8jZW4+wt9AyCOYbKEKuYO8wonvqi0zz4LOovhzLYAV
i6wRPcBsFcTVPQRwyqEt6SI18dSaSl7aTP972fDZr7px3i05u7ehochw9tCLvH8S
KWc+Ck8xNoahNpk9JE2eL2xO9Bi9laGMOXyAm1bRFG+IEXeue77Dcjd8s4lei1k=
=21vk
-----END PGP SIGNATURE-----

--d6nDKxlhctiV7bVq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
