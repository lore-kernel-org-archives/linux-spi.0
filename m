From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Thu, 27 Oct 2016 23:27:27 +0200
Message-ID: <20161027212727.leqg3gvwhd3u64er@lukather>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
 <20161027111419.GK25322@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ypua56zvlstrqgf6"
Cc: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wens-jdAy2FN1RRM@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027111419.GK25322-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ypua56zvlstrqgf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Oct 27, 2016 at 12:14:19PM +0100, Mark Brown wrote:
> On Wed, Oct 26, 2016 at 10:55:28AM +0200, Maxime Ripard wrote:
> > On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:
>=20
> > > When DMA finally takes over, this fallback path is not mutually exclu=
sive.
>=20
> > I definitely agree, and we had this patch in the CHIP kernel for quite
> > some time, working like a charm.
>=20
> > I was planning to respin it in the next few days, glad to see you took
> > care of it :)
>=20
> > Mark, any comments on this? For the record, it already has my Acked-by.
>=20
> Without knowing what the previous discussion was it's hard to comment,
> it sounds like some prior review comments are just being ignored here
> but since I'm not turning up anything with this subject line I've no
> idea what that might have been (and that's very concerning in itself
> given that this is apparently v7...).

v4 was here: https://patchwork.kernel.org/patch/3893371/
v5: https://patchwork.kernel.org/patch/5455381/
v6: https://patchwork.kernel.org/patch/6975871/

So basically, I really have no idea why, but it really seems like it
was just falling through the cracks, repeatedly (I'm not puting the
blame on anyone though, it just happened). Maybe it was just because
of the lack of comments :)

> I'm also concerned that there isn't a version of this for sun6i,
> it's going to make all the cut'n'pasting between the two drivers
> harder if we make changes in one and not the other.

I think I'll give reg_field a shot though, and try to merge the sun6i
driver into this one and see the results. If it can help your
decision.

> If the concern from the previous reviews to do with not using DMA is
> there some reason it's hard to do DMA?

I think just like Alexandru that it is orthogonal. But to really
answer, no, it's not difficult. There's just been some fundamental
disagreement on whether DMA was supposed to be optional or not that
stalled everything I guess.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ypua56zvlstrqgf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYEnE6AAoJEBx+YmzsjxAg4l0P/R1N0Vy8dMWy7F7eU1n6XjyB
GTx2hQjTxLNYQuLHfbOuQt2IzRs8W/bjqaw94vHFU5Uq3qxUAkNVLpWhvimG3KbI
X8dxi/G6jUvSwSxvbeHwWdgmBCJCHAos4JlcbtIku+DpAW9iGYyVuOg5rjycz4ci
x5vacDVyoU9rWYjA5NgrMln4CDpn2NLBQDW3rDxkY2yJ7QEoSXNylJdylGB3Z6YZ
zgDB/l/15b/e0mooQND2WXH4YGrxTZ8tIj6GbGRzRpvZgNf1VQg3CT6I4/2hKIFr
9hSXnNUdfzAy/VqdPBFj5f545UCe56epSncYbsrQ95BZ3WZMvRCkZSYIqgzYDxVJ
N5LqrdJoCp8wP4oikmYkikhNbhd1FeynKMDCJX46pEaDx3s3dxCsMT9wHSLDmej8
B8R618/oan+i7g4bSXaAofIyHfuarq51UmlMOlXNxrYojMliR2aNDzuUkPqljaTb
zroWh6xWoX46tYfA8WKGaaufKeLdxS2jxKer96DZ63M86OTKEWamFsZmUO7D2phr
FAZ/xFGQ0lDbA9WjSDl04EGJiB1PJaxK79IfSnT+T66cSAUcetODAVRj+gWlhjOb
CSDGWiu7XC3EoHT/WChsDckNqHSz7/5UXBcXfh/zHYN4H3cmxZWpvHXJbDhpWUM1
PrHlh/a9iAsjUD5qB+Ez
=+h/t
-----END PGP SIGNATURE-----

--ypua56zvlstrqgf6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
