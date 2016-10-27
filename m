From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Thu, 27 Oct 2016 23:47:12 +0100
Message-ID: <20161027224712.GY25322@sirena.org.uk>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
 <20161027111419.GK25322@sirena.org.uk>
 <20161027212727.leqg3gvwhd3u64er@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cDkCB6tn7aZ2Gopm"
Cc: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wens-jdAy2FN1RRM@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027212727.leqg3gvwhd3u64er@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cDkCB6tn7aZ2Gopm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2016 at 11:27:27PM +0200, Maxime Ripard wrote:
> On Thu, Oct 27, 2016 at 12:14:19PM +0100, Mark Brown wrote:

> > but since I'm not turning up anything with this subject line I've no
> > idea what that might have been (and that's very concerning in itself
> > given that this is apparently v7...).

> v4 was here: https://patchwork.kernel.org/patch/3893371/
> v5: https://patchwork.kernel.org/patch/5455381/
> v6: https://patchwork.kernel.org/patch/6975871/

> So basically, I really have no idea why, but it really seems like it
> was just falling through the cracks, repeatedly (I'm not puting the
> blame on anyone though, it just happened). Maybe it was just because
> of the lack of comments :)

Oh, those subject lines were all starting ARM: rather than spi: -
there's a good chance I didn't look at the patches if I was busy
thinking they were changes for arch/arm rather than the SPI driver.

> > I'm also concerned that there isn't a version of this for sun6i,
> > it's going to make all the cut'n'pasting between the two drivers
> > harder if we make changes in one and not the other.

> I think I'll give reg_field a shot though, and try to merge the sun6i
> driver into this one and see the results. If it can help your
> decision.

It would definitely be nice given the level of duplication.

> > If the concern from the previous reviews to do with not using DMA is
> > there some reason it's hard to do DMA?

> I think just like Alexandru that it is orthogonal. But to really
> answer, no, it's not difficult. There's just been some fundamental
> disagreement on whether DMA was supposed to be optional or not that
> stalled everything I guess.

Oh, I seem to remember some patches adding DMA support that were doing
some strange special snowflake thing with ignoring errors now that I
think about it but that's not this one...  why did nobody ever follow up
on those?

--cDkCB6tn7aZ2Gopm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEoPwAAoJECTWi3JdVIfQd2oH/1W3GscFmedx+HSx3EyEWHW6
QENgc75XOLyl5il30PZYruN2VDMRzP+KiRu2aV3QdIYlYN/KY05H3dLQYfdVeb/Q
oCFaOGbQd0S4FjwOBNWgWa+qb2BG8q8WzEwCoEGNz3M38oeVN7Y7D6YhJn4pGogK
PkL/mD5zAk2c/9YyYDClmD+8hOGXs1vCR169sZuHrXSgfg6c4dMQZgdB0wG1YTia
4tMx/uhNFGpygM8qdn9HYyW7Hx0kGLfwKs8d462yNp3rOKQ1eLOCiHGJZMWpjung
8KenDvLWDxD2ANowbsirTlV/25Yb63sg2S/T0pbFpfazRQAdJx8lIaMX046rKsI=
=YUIq
-----END PGP SIGNATURE-----

--cDkCB6tn7aZ2Gopm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
