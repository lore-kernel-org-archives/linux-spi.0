From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: fix rx_buf in
 fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Fri, 16 May 2014 20:07:23 +0100
Message-ID: <20140516190723.GT22111@sirena.org.uk>
References: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFwAERqMlXzMQ5I7"
Cc: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400251581-26617-1-git-send-email-valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pFwAERqMlXzMQ5I7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 04:46:21PM +0200, Valentin Longchamp wrote:

> By default for every espi transfer, the rx_buf is placed right after the
> tx_buf. This can lead to a buffer overflow when the size of both the TX
> and RX data cumulated is higher than the allocated 64K buffer for the
> transfer (this is the case when sending for instance a read command and
> reading 64K back, please see:
> http://article.gmane.org/gmane.linux.drivers.mtd/53411 )
>=20
> This gets fixed by always setting the RX buffer pointer at the begining
> of the transfer buffer.

This still doesn't seem safe - we're now going to be DMAing to and from
the same buffer at the same time (and doubtless mapping it twice...).
Would it not be safer to allocate separate rx and tx buffers?  Indeed
can we not use the core DMA mapping support to avoid the need to copy at
all (it will construct scatterlists in PAGE_SIZE chunks)?

--pFwAERqMlXzMQ5I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdmHoAAoJELSic+t+oim9cMEQAJ2NQch7vblSA4K6d1pr4/Bu
HltEAdxBu4RNOoakAqIGNZE6Xf+qXzu3oWFw2zAIe1bV7BQgPXcuksR55JH3U4vs
B7mkEkEiz1EL7d4YX4op6CMGAnGk1FbjalUk+3DGqDN0oJRcrJoOr9fGPgMaYpH4
TDSqFFtOgw9zvueN9yZa3MFda/MwdTQdnLgXJFvo1YURSGvdAqD90wvt3euc9pLr
bu1XK8QbLFBk9QHy+KI5JMhrtfcSAlc4x9tUMjruSbCqLRvzCJ0yPROy927P2039
BLRgfUisWAsK3MnDnohhM6lHUBthUsCPPp3gkU8uq1DJQAWrs0e60P1PQGlsyKbR
jK23H4ioyYJtBMhAJR2FEZDV03dUB1aMS8Oc8MN3UpHY9tETt24sGZqUDCVvPuhS
LhNEMm0xWOz+5rXeX2LuRA478OX0O+sQM5dJnrjXlymCfcjEymcm8stBB+sbUEbc
Qy4QIz8oB9B5Of2KX6w6eDN+I41VSc3QmYlP4YAsSdTHBLWKU8zBLTCFN8Vi0wKd
Ql83bmGqpIsD1RP579K5bXZIPeWsZJKS1u8Nj/CJwWD/5IpwRpTf97vaJ7i0hiOD
3ZwGJ+3gMEwNzj5qWymjJYO8cEjpZvmp5h98TZ/qsP7xb2aMAqLKV+3HqBW4K4b4
WymlWTw89FBKX73iteNO
=OVL3
-----END PGP SIGNATURE-----

--pFwAERqMlXzMQ5I7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
