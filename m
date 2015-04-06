From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Mon, 6 Apr 2015 18:21:30 +0100
Message-ID: <20150406172130.GU6023@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
 <551A1185.6060502@wwwdotorg.org>
 <20150331052519.GZ2869@sirena.org.uk>
 <552094B5.3050109@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="csoOxBvjhnnTVlaS"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <552094B5.3050109-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--csoOxBvjhnnTVlaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 04, 2015 at 07:49:41PM -0600, Stephen Warren wrote:
> On 03/30/2015 11:25 PM, Mark Brown wrote:
> > On Mon, Mar 30, 2015 at 09:16:21PM -0600, Stephen Warren wrote:
> >> On 03/29/2015 08:03 AM, Martin Sperl wrote:

> >>> There have been rare cases where short (<200ns) chip-select
> >>> switches with native CS have been observed during such
> >>> operation, this is why this optimization is only enabled for
> >>> GPIO-CS.

> >> However, I'm not sure why this is in any way related to whether
> >> the chip-select GPIO is valid. Surely we always want to do this?
> >> How does the mechanism used to control chip selects influence
> >> whether we want to pre-fill the FIFO?

> > I think both the comment and the commit message answer that
> > question - something triggers spurious chip select changes?

> I must admit I don't feel either the commit message or the comment
> explain the situation. They certainly state that there are glitches in
> the "native CS" case, but that doesn't *explain* them. It seems more
> likely the under-filling the FIFO would cause periods where the FIFO
> was empty which would be aout the only case I could naively think of
> for the CS to be de-asserted. More investigation would be useful.

Right, and I have to say I do suspect that the underlying thing is that
the FIFO is underrunning, but as far as the optimization is concerned
that's a separate thing.  The reason this isn't enabled for native chip
selects is that it's not working, the reason it's not working is
something that should indeed probably be investigated.

--csoOxBvjhnnTVlaS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIsCZAAoJECTWi3JdVIfQSv0H/R2cL8Iu8M831P8hUSmxQZYS
48agAqvnLRzcgVc+Sym1eTQkO21wMskW+1vgjnl6LYmYvPmZ1wWX9rj8N8nWEbOX
aOQXQX+sKJEjwZPLp10DeLYTjtwQhf/JVZylwtUGfzs4cDoylabimg1mvo0KP4o6
qt/5+cbOlh4MdSOpX/doh85fsyxCnIhBEhtJ9sDuYSyjBezw5kJ1M07JqJtaKLYS
5usBi44qVeICdCJwMOBHhv2RwHweIIE6Jkwv8719xcP3BseOaNLdhs95AjkvXOQH
QpWCZFliHTPb1Y0ZcVxUX6E6tB5K2lvDJjgyKERMuEX6EG2lof4pyn2v5Rd/jo4=
=ZNKM
-----END PGP SIGNATURE-----

--csoOxBvjhnnTVlaS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
