From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Fix transfer failure when
 master->transfer_one returns positive value
Date: Tue, 21 Jan 2014 18:45:48 +0000
Message-ID: <20140121184548.GT17314@sirena.org.uk>
References: <1390053922.16621.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPE53++ukAbB0PKL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390053922.16621.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jPE53++ukAbB0PKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 18, 2014 at 10:05:22PM +0800, Axel Lin wrote:
> master->transfer_one returns positive value is not a error.
> So set ret to 0 when master->transfer_one returns positive value.
> Otherwise, I hit "spi_master spi0: failed to transfer one message from queue"
> error when my transfer_one callback returns 1.

Applied, thanks.

--jPE53++ukAbB0PKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3sBZAAoJELSic+t+oim9ua4P/A8YeImNbXKnWyeJ7Wf3tLwZ
dJItia9PmLgsiCmatVesG9JqDug41TDYMrCt020rcSC3b/WTR+5aFnJzO682xQUy
6R43rs3dJ3z88BWupuBRzAlhT4qpSqG96aYVVnd76CUlpJDPlqTF+2/iwFJt4pgy
wvQ2IO2SXNtiRZnC8Mamom0dlo+yapSAekwofJuwGcTPJd7zNc4kb5VP6z4OVfjD
14y94DZFmrVHLbtJgTQ5VPmZqoK56myopA5UajMI9mGzXMXSv5LxMtn/Wv1Nyqxk
UDO1MG27jZ1cE13pcsZg+0Y/8dYQIHoEqTJjux7XLoNNwOWhMh8rQbJAuUmMILfQ
LFcrPN4HEEejNJ9PV4meS37JETQuyRC7W29jgj/EMI1m7ohaeLxLNsydABa0UvRT
nOJB4DGFsbPNW5EO7oTUZt8F285MxRSNDmEebcjClUhza02r0BSlgsi7jd/sH5TA
wy8UpLePCnjDix96bNjYGFoNitPJD1PHqtxUFnf+ll24Ww0HoKi7AZJD5591Tixj
Rv5CULq/JVgm6NT44QA6flaz/2P8RndG7Yh9NcpYBAY9/P7bdRUYjYHvTHXM3WHx
eslU0BDJWYvcs+Z4mBavXklvbdY9wX/JNNBI8IXCA2cgG+xdP03OW94EdjPyQQ9t
hxZ2NDpzC9bGIUFFVH3O
=0TU1
-----END PGP SIGNATURE-----

--jPE53++ukAbB0PKL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
