From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Wed, 13 Apr 2016 07:59:03 +0100
Message-ID: <20160413065903.GM14664@sirena.org.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
 <20160412013014.GR3351@sirena.org.uk>
 <1460459249.32355.4.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460459249.32355.4.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 12:07:29PM +0100, Ben Hutchings wrote:
> On Tue, 2016-04-12 at 02:30 +0100, Mark Brown wrote:

> > This doesn't seem obviously correct - what exactly is the frame length
> > here and why doesn't it change per transfer like the word length does?
> > There's nothing in the changelog about this.

> The frame_length is the number of words in the frame, as it was before
> this change.  Shall I insert a preparatory patch to give the variables
> better names?

I see you did that already.

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDe42AAoJECTWi3JdVIfQ5wMH+wd739qd+gibZJ9fkglxvBhK
i7Dh/ogWZN+9Q06IX1RXUcs89uekPOTFLkDVIB4HqkQU70P7CApJrS0TDR7FQ1aj
5usSHzqPl0PXWsM2g2Pu/4FYNz6FJsMl42ZbjmUXcGBYrlndlpLV28wcWe6cnRMp
lr74YHz3IGwM2wJFMD1V+beWo9kR9ntCqV2qg8z8gobxfH8JpPux0fDbeqhzL12w
8qnZ5xXO8MNyVVO3pv7JcSd1YzcIGYWVqW+ZaStVVFvvPL79t3XkomEBYbTqeY77
Hz1tfPa6SA8yHdDd3mDnTeXTfCvjrkGNfif4vkWYyD/H2B2gf4cuU0Idg5fmUBw=
=cFMm
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
