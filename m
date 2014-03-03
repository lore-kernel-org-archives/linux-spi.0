From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Remove redundant list_empty checking
Date: Mon, 3 Mar 2014 11:56:28 +0800
Message-ID: <20140303035628.GD2411@sirena.org.uk>
References: <1392810792.9749.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sk6NRVTC9kZ6Mrgo"
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392810792.9749.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sk6NRVTC9kZ6Mrgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 07:53:12PM +0800, Axel Lin wrote:
> This checking is already done in __spi_validate().

Applied, thanks.

--sk6NRVTC9kZ6Mrgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE/1pAAoJELSic+t+oim94XoP/1fXCZCloDrqy+sxhgIY9uO4
wv3GQopP0KUOfBoQIk+S4DO5FPmRc1iUcdUZGSG3FmPdewb9pLEyZIujxOSUhMs0
JuJRfbYrjsVWs4/dExK3ZGnQryUUQR4GfH3lhYW8RNfmQi76u3w9jj6naH2Twik6
zOQTcKgO1Kuwui8p7C6KFmKYepjnky+5NtMhtWbQx642Dz7RmCXOtbEl1j2n0AaE
+k2wZBDK5EEcYrkY8Uw6x8vGrZlIaFPDvco0GWIMpNF+ZLMK8oTCGfeKVAkCFUOL
Va+IUpiAX0W89L+UWJ2urYxlshdME5/CZcZ5DEVkikF679hdDrm6HmcCH+EG7O31
xNMHpZQ1qVr4iAO2At2Wc2wJmN2STlGtiyC4aqBwwHQE89LUSSFNu0DLhnk7Y9AU
LDpCvnZW6wCZ/2yYNKsCJuLswW7QoRHXEpST0iwIUJn9rR7peP9VmZfQSV+uORnH
zU76Q+7dDBZppP0PWLgj44UMcOHXLpuCAcKtTwNjkUsSjbMVKwChtU4TXPrMtRNw
ItQgxfcHXkV1ve7EdOy0jSNW8cMbm3Wf/42xz0IvL9qwoMtUJKqyjeMR/iLUdnax
0W3la1Ibs0mNWS/PHV4YvcRFqbff/O1EwKIT98CTX96IImCzi05JbVJ8/+bIvIFr
EZWZ/drXxZwf9g4c0jo6
=eR1z
-----END PGP SIGNATURE-----

--sk6NRVTC9kZ6Mrgo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
