From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/13] spi: atmel: use endian agnostic IO
Date: Thu, 19 Mar 2015 00:56:19 +0000
Message-ID: <20150319005619.GL2869@sirena.org.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426693992-31163-10-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 03:53:08PM +0000, Ben Dooks wrote:
> Use the endian agnositc IO functions instead of the __raw ones for when
> the driver is in use on big-endian systems.
>=20
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

I'm not CCed on either the cover letter or the rest of the series: are
there any dependencies here or is it safe to apply this by itself?

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCh6yAAoJECTWi3JdVIfQ8uAIAIAU1jSHV79CdZ/SSTMqlqln
ibcJc1yOXEF7/XPXXARDNIZWwtl4RsXI9OZTpXhm5fkgEgxSkuhJIMirly2NNR1s
I28ROP6JHHCVms5yI1xmYGI+Dmse6fqAXgnP2NBAi5LLmW8krraoawFeplWD8JdW
I5lNoJbkQtoj++Fd4oevRkSxxhvj0yiAIN9flq7lAmdBK0jpOGhtfolkSXxyCQ5X
A6v57Kkm18nesfTrCl+40sW++p6aF+qJ7S38JIm/Y9IHDgfV/iCYBzX8xtcveLWR
LoWQPV+JTuytNKy66m5C/6KEdxtQqd2khJqnczZjgo2eAUJ8eWmeeViMgvqwKKI=
=asHz
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
