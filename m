From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Wed, 2 Nov 2016 18:47:53 +0100
Message-ID: <20161102174753.elbukxnrc3x27xxc@lukather>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
 <20161027111419.GK25322@sirena.org.uk>
 <20161027212727.leqg3gvwhd3u64er@lukather>
 <20161027224712.GY25322@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7eofhf2lw3xmi3lr"
Cc: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wens-jdAy2FN1RRM@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027224712.GY25322-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7eofhf2lw3xmi3lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Oct 27, 2016 at 11:47:12PM +0100, Mark Brown wrote:
> > > If the concern from the previous reviews to do with not using DMA is
> > > there some reason it's hard to do DMA?
>=20
> > I think just like Alexandru that it is orthogonal. But to really
> > answer, no, it's not difficult. There's just been some fundamental
> > disagreement on whether DMA was supposed to be optional or not that
> > stalled everything I guess.
>=20
> Oh, I seem to remember some patches adding DMA support that were doing
> some strange special snowflake thing with ignoring errors now that I
> think about it but that's not this one...  why did nobody ever follow up
> on those?

I have no idea. I think last time we discussed this was last
July. Especially with this in now, there's probably no rush anyway.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--7eofhf2lw3xmi3lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGibEAAoJEBx+YmzsjxAg8xcP/1VLSmk7F7b0Xcxonymz9dO8
kqdwJSn3q9eJSaSkUqKRsQBdau6FdW9/c9uAKTJL5aurfzH+zaRW5RkVKpGdHdjy
2gpliBYHP5b8B1Cfvt3bKV/efKBpppKOcSr+pWya8DysjAmjFAV3+nNAAAC/XYn6
eKGL1lBk9JVnZt8VbTR4LlJJVsXVI1E2T+D/dSDbXv2bs87R+io2qFofMKBFBsA4
x7jlEpbf7QlVu+YHZL6cJmVVdp4UFhT1D/zq5LAwVEpa0XVcap16AOlbjpAh+nXf
eDtBIbYSMunTwKkrLKBXWZVx6M8/3NLQWq4VrQd1bJ1CpGxX9f0rLwRdkgg2FupY
TSVnSi/bb1XkbkJ86+uMPQ00fX+vGmv41Km39TC3rHrp3a+sHhBFt5VuGxmCrUhA
qsp1rSwulMT2A9kjX7aCpVq6HiE26VpjfM8KRt0hwL4PkYffi/yt3+jRXDGy/G35
Wj9Z6YDMNDs3Jzv7vblPzvhiiCcZOicDFlotVsGajcgmwlE+6n3gckFWU8ZxfJ+g
JskR8+YuTvAy0ZPxkhDHKoWDEuo+hItP2gPJEBzZ1Q7LrqKDeGQER7a5aoAzjLBA
7u930UdKm45uSNu5mMHuVC/+4zLjSfYTkyEgIePOtXxr5YifRV+H3MYxMsiJ1C38
TYFaP3iZqZGmZPnU1hEM
=GM2B
-----END PGP SIGNATURE-----

--7eofhf2lw3xmi3lr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
