From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: img-spfi: fix kbuild test robot warning
Date: Thu, 6 Aug 2015 12:28:28 +0100
Message-ID: <20150806112828.GU20873@sirena.org.uk>
References: <1438853581-17154-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eksKrreXPGzCYtak"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438853581-17154-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eksKrreXPGzCYtak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 10:33:01AM +0100, Sifan Naeem wrote:
> drivers/spi/spi-img-spfi.c: In function 'img_spfi_setup':
> drivers/spi/spi-img-spfi.c:446: warning: 'ret' may be used
> uninitialized in this function.
>=20
> Fixes: commit b03ba9e314c1 ("spi: img-spfi: fix multiple calls to request=
 gpio")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

This isn't a good commit message:

>  static int img_spfi_setup(struct spi_device *spi)
>  {
> -	int ret;
> +	int ret =3D -EINVAL;

You're just assigning a return value so that the compiler can't tell if
we've missed anything, that's often a sign of just papering over the
cracks without understanding the problem - for example there may be a
missing else case in some error path that the compiler was trying to
tell you about where other cleanup is needed.  The changelog should say
what the problem was and why the change solves it sensibly.

--eksKrreXPGzCYtak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw0TbAAoJECTWi3JdVIfQeR8H+wQBpnqObmkTJZnthapLgKx6
wK3ZScN+c+3xOBmfIW16F4CbUnQTT6TcGZP3I1eEME4tdphRYXa1VnHfIPal+nJB
HwjR58UBAwkaNW9rMv9YummS2bTnoV/mmUnSNMozeRoK7grpIKiAWCtko+OEUTT2
rZhiWngwSgWiWQXvaCCSebf6uEYOAdmOp8QQK8mmS7lR/T8px8Y26kMEsr6xXsEg
DgCOgt3MSWuVcisjP6ptwrNKquBpRdIlNx+q64a/4tfjlxSIKxE/C3wUoRagtDGN
Kt8JuBzjqg8V79Y9hUYt4AVYKX3CyPOQ8NrArPbgamCh479UGX1/47oUAAEJ7Ug=
=x7Bk
-----END PGP SIGNATURE-----

--eksKrreXPGzCYtak--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
