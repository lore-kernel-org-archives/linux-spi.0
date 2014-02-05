From: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Remove unused pointer in
 orion_spi_write_read()
Date: Thu, 6 Feb 2014 00:30:17 +0100
Message-ID: <20140206003017.33fbc7f0@spike>
References: <20140205222301.14fbb441@spike>
	<20140205213116.GA12659@sirena.org.uk>
	<20140205225421.013da54a@spike>
	<20140205221226.GJ32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/NkrVeFo0chksBTjeNCjZANK"; protocol="application/pgp-signature"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140205221226.GJ32298-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--Sig_/NkrVeFo0chksBTjeNCjZANK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2014 22:12:26 +0000, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Feb 05, 2014 at 10:54:21PM +0100, Christian Engelmayer wrote:
> > > I'll apply this but please follow the patch submission process in
> > > SubmittingPatches, in particular please always CC maintainers on
> > > patches.
>=20
> > Thanks. For trivial patches like this I tend to rely on
> > get_maintainer.pl which clearly pointed me to You. I'll put more
> > investigation into it again next time.
>=20
> It should've listed the maintainer as broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org rather at
> linaro.org which was where you sent this - IIRC you posted some other
> stuff recently which missed my comaintainer on that subsystem.  Checking
> right now I can't get it to give my Linaro address at all for that file,
> odd.  It could find that via signoffs but it seems to have squashed
> those into the maintainer section.

You are right, I already recently used Your linaro address and the referenc=
ed
commit that led me to addressing You and just CC the list was signed-off-by
broonie-QSEj5FYQhm64UlQgPVntAg@public.gmane.org Interestingly I had both Your linaro/kernel.org address=
es
in my MUA's address book - prefering linaro. So get_maintainer.pl in this c=
ase
chose Mark Brown, but isn't to blame for the wrong address. Again, my apolo=
gies
for the noise.

--Sig_/NkrVeFo0chksBTjeNCjZANK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS8smJAAoJEKssnEpaPQKES50P/0OFgMYlKBThKQqxS63uHeVk
9pJOtueihlv6FkdAsbxUoLPSgsPPmE9hL6z2GxhS1cYZ7NiLJWehPdNURgJd8Jiw
oB5EihZWOj96iQGw04NpXN+IVL9mJi9gtjfPsrmwQna4vexe3oENe1olYxCBNY9g
4wLb2ZFgIbm2zXY4M4sCmJDHIzXjieYzKqHZHswFdshFLrvSrWvcDVIBQafk7qMC
Hd5HpjBld9id76FV8VhLHOF9ma/OpXQKvh51jiT5OYviXfXjZzlADK9z7bwpvGMt
VP4ZxrvnKrNfIsBvGOI3J5zGghwfQkt4xi2Dy0eTlcXQruTzJ6R/Y92dUetHeKzu
51rcvVk1ZUFnZ9Gc3uDmgklDotLEloGp+5tZkzbi8UeJP3UQHy0NuSIP0cU9oEDU
KdJWgvxztqlHSJ4vhgpwu7cQKniFP0P7l3z/0hoQ0DAlJ0NoogIp0TuWS8vZHlEC
xpqNUvdYX93XjtR8zdGkgMFfMYlD0nLL4CyMZ3Ex0DZClia2NP/3h/OXnwVRn4th
cIjnNA0ZAyHCxrSbinl3fvIYQj6i8qwMkZva1bW0vIaIDliZcDnRyXJkZFUN1PSg
PHsmIOzxUEQckeybjrjyidltYAMJ4h6plZTCMC5qy8S0bCBj1bFPUyF5cnen4hFS
44qp4GholWMLDiHoQRkF
=Q58Q
-----END PGP SIGNATURE-----

--Sig_/NkrVeFo0chksBTjeNCjZANK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
