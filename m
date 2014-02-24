From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: sirf: move to use generic dma dt-binding
Date: Mon, 24 Feb 2014 11:01:35 +0900
Message-ID: <20140224020135.GV25940@sirena.org.uk>
References: <1392222620-17273-1-git-send-email-21cnbao@gmail.com>
 <1392222620-17273-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Azlbkg4pdDb7tRhV"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392222620-17273-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Azlbkg4pdDb7tRhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 12:30:19AM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>=20
> sirf-dma driver enabled generic dt binding for dma channels.
> see here we remove self-defined dma channel prop and move to
> use generic dma_request_slave_channel.
> related changes in dts is something like:

Applied, thanks.

--Azlbkg4pdDb7tRhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCqf8AAoJELSic+t+oim9NlkP/2mvGcscSqpkPPjVxWssMyH4
m5slyWWLXFmq2VJzVquUr/oHXXG4Ws3bNXzF55XXnJmyRsYnJnWd1qXph3DO9V6Z
PDryA1WVew+FBrtPTqP+FH/iIYaR0fHd1F2q/1JSvlu/rUlGtgZO1Ez2OcoJj/7f
FctBwnKyMp8IGXzQGED9UxHiRjSh5VhvM+pIUkvrj1GnhEdGiM6dzQSpqF94goEJ
S/U0PoiRgRdpvtKx/sXuDNWFY2OGNtQy3JqehcDKEJyYRsEd/dWtcIjm2YwdGdzp
IaadUatQG8dH7ZDzp43kYpV+raJhRLeV5gl81AXwwmpI1V6ocy1WLP213/TyguVD
eA+NB2p++4na60iU+dLvxRUwdHXUU++gBFAEJhnn9Yh5hZlCJ9O00FvjZMlmabXM
dC937UD+NDnfdHN+nz0OY+p0uwxdzqwieQMR0ICn0Ps9NoJHNPtcU5QGDijqbHgo
xQUrGnSxutiRWd3wa8m4Bzo7Cs1nltbSu26dLxuBSXm3Cr7DV3rvIVNM/MGaWA01
1X2GiIZUDJdTVoDqePoTokj9i00AX80TizUyHpo0BClbG3OXUlcQJJG6JpAdIMe6
fEk80Sqn3ehtpc9rkVWgs/FVngranIfIR298vqnOTihP4kM5kEH8iIPkcfpgjxGU
rWGhul9modqLcy22kYmD
=V+CV
-----END PGP SIGNATURE-----

--Azlbkg4pdDb7tRhV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
