From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Wed, 13 Apr 2016 08:11:47 +0100
Message-ID: <20160413071146.GO14664@sirena.org.uk>
References: <1460462185.32355.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460462185.32355.7.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 12:56:25PM +0100, Ben Hutchings wrote:
> Each transfer can specify 8, 16 or 32 bits per word independently of
> the default for the device being addressed.  However, currently we
> calculate the number of words in the frame assuming that the word size
> is the device default.

I've applied this but it required some defuzzing, it appears to have
been generated against an old kernel.

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDfExAAoJECTWi3JdVIfQ/jcH/2QI/ALFecYTFgYJinF80rB5
LKaPWYBi2UaGaF57/5Ngj/CxtufuXxMYaVv2KVVHWHg+Y/txkBKgJAfF5+I/o2Wf
AK/oCnh2HMF+wucHbXxf2mtyypxCSEs/D5Bra9ZG69hkmtE26NPsYXZ56bfoyNoL
KETgWHqr4TRl8QnBnfv+KoXwWCGr/NOz4k5BImAGL4OmtuwtgsjfNgzqM2OaCD72
pAQ9B4/G4suYlZRqymBar8Ysd4Bbedyaa6BX3zGn3/TxMKCm240gq0FQb2IvsU36
LxuqcjD51J1hYzgz6TDFPRKG4Ras/+fg/dGe23qXm097k412OYi+NT7l3tUM8ak=
=Z/JA
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
