From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Tue, 12 Apr 2016 02:30:14 +0100
Message-ID: <20160412013014.GR3351@sirena.org.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kJZGYML2m3vFaueA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459885528.26669.5.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kJZGYML2m3vFaueA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2016 at 08:45:28PM +0100, Ben Hutchings wrote:

> +	frame_length =3D 0;
> +	list_for_each_entry(t, &m->transfers, transfer_list)
> +		frame_length +=3D t->len / (t->bits_per_word >> 3);
> +	frame_length =3D min_t(unsigned int, frame_length, QSPI_FRAME);
> =20

This doesn't seem obviously correct - what exactly is the frame length
here and why doesn't it change per transfer like the word length does?
There's nothing in the changelog about this.

--kJZGYML2m3vFaueA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDE+lAAoJECTWi3JdVIfQ77sH/Rkk6wHvs5FApPY92m/jRFuP
UGAdukFYZ5ZoigfaFyMsfSWaZQZpibP5sbH3tbJESf7ldneJxWff/bDMiIeOUA7p
L9u+ALNrwdj+3nzB4tXCWTIgmSKDyV49f0DUavaBcKQ43HndSWCvdMlHmLAqmWjk
VK73ZhmL2ZosOQ/OGXnfCbdwXkXuqyaLI3LisJOBVRrmBk0vh6YSiT23RB2NVOhl
Qw7b1+l/VZ+/Fnmtqa+B+NrAfOZWZ9+AivakoQLouBwN0LkJk1QafaMDHYY7x0vj
vyMh7V/jUT+vSw0yJnZWQZJSQPju/a3Vq/3JLctT4RZOn9IyCgFD4YqZ3T1I880=
=LxOc
-----END PGP SIGNATURE-----

--kJZGYML2m3vFaueA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
