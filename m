From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Tue, 12 Apr 2016 02:58:09 +0100
Message-ID: <20160412015809.GS3351@sirena.org.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
 <1459885728.26669.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MdJ3p2aQbVp3YFXz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459885728.26669.7.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MdJ3p2aQbVp3YFXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 08:48:48PM +0100, Ben Hutchings wrote:

> We clamp frame_length to a maximum of 4096, but do not limit the
> number of words written or read properly.  This causes 4K reads (which
> some m25p80-like flash chips support) to return garbage for the last
> few bytes.

> Recalculate the length of each transfer, taking the frame length into
> account.  Use this length in qspi_{read,write}_msg(), and to increment
> spi_message::actual_length.

I'm having a hard time understanding what's actually wrong here or how
this change is intended to fix it, I think again because I don't know
what frame_length is intended to be.  As far as I can tell frame_length
is the number of words we're going to transfer in the entire message and
the driver has in some places been mixing up words and bytes which is
causing the breakage so the intention is to consistently use words
throught the driver.  Is that correct?

> -		ret = qspi_transfer_msg(qspi, t);
> +		wlen = t->bits_per_word >> 3;

For the benefit of readers:

	wlen = t->bits_per_word / 8.

--MdJ3p2aQbVp3YFXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDFYwAAoJECTWi3JdVIfQ1ocH/3CnnWZDZ1+Ej3xWHPIrGgkz
69zEycNHtE3DwtrehcSzsslhChpGegea6LC4ZRGGZW1k7MoE9mf8qmJzIVS8fXmG
Vsa9hzNF1p+D1W+RzmDlojwZjUssRFQIuAeJ8hOpLzSW4oj3qVEM7DPAD+9UxsGN
LAPrGmiAa2vYG1NnwUGJvLO/DQj05sn9cUoQykWvN+oL5CdanxAlcXNh5ThwM3gW
RHBYiOFqts1939jPcwGsSk4c943dZ4CVkO8hKEyTUxxrziTnp6GlAUzYfxrmbMqJ
GH3UXcvts1lvxVi+J6D+BKwTyabRYTh6dCGxuh9eEP1cdpsfyEIdwP1KCSPAssA=
=BsD4
-----END PGP SIGNATURE-----

--MdJ3p2aQbVp3YFXz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
