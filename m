From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: send more words at the TX initial phase
Date: Tue, 20 May 2014 23:26:15 +0100
Message-ID: <20140520222615.GM12304@sirena.org.uk>
References: <1400566068-2781-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oK4Ztp+Fbgj9vocW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400566068-2781-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oK4Ztp+Fbgj9vocW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 02:07:48PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> The old codes use the below flow to do TX: send one word at first, after
> this word is finished and TX empty interrupt is generated, send more
> words. This causes redundant interrupt overhead at least for the 1st
> word.

This looks very like the patch I just applied before I looked at this
one...  is there any difference between the two other than the
changelog?

--oK4Ztp+Fbgj9vocW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9aEAAoJELSic+t+oim9TJAQAJFiyIbEGM7ErebrfqNQSHgf
g07wtnVjES26Sp8D315hqxTA+GzP+jfs4f51qBc3gb6IV85ln+ln+h3G0vVJu6JN
Rf/S4G89QRct/AGbZjM7yKsBc4iNehyj3y8zK8DcoDLTQiy5SL3un19b6oDU0rsw
pv2NFzRaG+lWut7uWq8LIBu8H9cyFsYxXltgZNJdN5rH6ukM4FlMLQmPbIZm05PY
LS3KcNkSrvdhMIJOSxaqUVAIRW/EgAUSwv2iaVDfhwYJK7vqGAlgiBT+eqjgApDQ
YIcNoYTKmq7p0jtWvpjv4MvjVo98i3jcTJ/73BphOcw+Y75gyix9UXWPNNfvr0J0
5sm387T3LuofETSLNyTYx6UYNnWZ/WUl/2EoHqb10hpeC5bMH/lfKIbjBKTIJAng
K6wqJ5WRqCjuAM2HDxhnGhNVg4xb+0LmdEtKWPUytKj9+LGnZLpUSGH5Dq1fEU+t
TOlfcz0w+knc3xh3ZUwwpKxemRxwL5Z7j+BcXdUFKpu5CAw9gUWXoDsK1AQ88Orz
VQ/o24qeKXtVgZ4R6oqxC5Ez7pJjzfaHH/juUiXR7qH2gT+TtZBFWP4Pap9Oj1qt
2YPiJn1rc8C+phcA1JDoaMbm3z6K1uiBXfPIT5oBITCJxoYgFx4Ej0mwKEmFGlxv
ps1anxrkVjG0piCHdKNX
=yzuo
-----END PGP SIGNATURE-----

--oK4Ztp+Fbgj9vocW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
