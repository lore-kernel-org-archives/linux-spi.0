From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC, PATCH] Add support for long SPI transfers
Date: Mon, 24 Nov 2014 17:57:13 +0000
Message-ID: <20141124175713.GN7712@sirena.org.uk>
References: <1416851423-1902-1-git-send-email-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yurovsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416851423-1902-1-git-send-email-andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 09:50:22AM -0800, Andrey Smirnov wrote:
> Hi,
>=20
> This patch is a very first, very preliminary version of the feature I
> am implementing for niche usecase of SPI in a system I am working
> on. It by no means contains production code and is purely RFC to "test
> the water" and see if there would be any interest in including this in
> mainline tree.

Please don't send cover letters for single patches, if there's anything
that needs saying it should either be in the changelog or (if it
shouldn't end up there) after the --- as covered in SubmittingPatches.

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3F4AAoJECTWi3JdVIfQSswH/0Hvw4CuQza8zhgJpZr7lBav
1WtA5/yhYyhc/OyIDWCGWZt6osH/maxxVAMEWYJWx277Zhty9WI7L4Q4Qi/RDdgm
l/5TjtiD4glWGcNWcECrganMQZWZrd5BkmwaSyQ7/Shi8m1fG7wLZR6sEs+5pRvx
tgqCM2AeJivs8s+bUJudX0qupwx4fcCRPK+vqu2iIo+i96Oyz6S7B6CIMGIb0fAa
OSqJ0TBb8Uyg7dwtMoLrPSQBx6eWnwsoCLDD+Nj3ACKyksjdK7aKLfWNbVPhMTo3
krTyWT/EJDblfyc5ysmoWdStUfA3CIhcYWw267+iOHn2MOUDoy9yXW2FbOgucVk=
=Ikcz
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
