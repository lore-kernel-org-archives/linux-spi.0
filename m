From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sirf: fix word width configuration
Date: Tue, 18 Nov 2014 14:44:06 +0000
Message-ID: <20141118144406.GL22111@sirena.org.uk>
References: <1416237423-3606-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416237423-3606-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 11:17:02PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> commit 8c328a262f ("spi: sirf: Avoid duplicate code in various
> bits_per_word cases") is wrong in setting data width register of
> fifo is not right, it should use sspi->word_width >> 1 to set
> related bits. According to hardware spec, the mapping between
> register value and data width:

Applied, thanks.

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa1s1AAoJECTWi3JdVIfQroUH/jhKDJ5mXKefGbmmg2gQvkm2
mQuwL0UIPJfUSGw7ue8xdEP0UblPc0WW1BXU531VGgG06Az69FA+r5yieiJQXW2L
wmwm2B27W4FYQ4+OqVsynHyflHrD8XsOEp5YnkxRRYo064Y5v4PozD30bVBmBW9z
xZB5/l+18H5rsu3lhpGxOYhWnUg5qlvXT9lriDQYlJxe8KrmHjoNYSDYcZnjRxGV
ZBHMlCbSKC/DVgPKublGORdSfI1Ob+B/fyWGcSZXOFcr430kD0bHrP3W7O6Dw6kp
2PfF21+VMiB1dOQ19Y2HvnuGnRU76KY18/ug0JiuoiUUcod1w122ra4sb/gWh38=
=wuEW
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
