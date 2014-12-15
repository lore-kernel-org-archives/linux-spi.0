From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: sun4i: SPI improvements
Date: Mon, 15 Dec 2014 16:59:51 +0000
Message-ID: <20141215165951.GG11764@sirena.org.uk>
References: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
 <20141211165602.GD8739@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IOWfJl95iVQnrM9l"
Cc: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141211165602.GD8739@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--IOWfJl95iVQnrM9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2014 at 05:56:02PM +0100, Maxime Ripard wrote:
> On Mon, Dec 08, 2014 at 04:13:59AM -0600, Alexandru Gagniuc wrote:

> > This is a series of patches that gets SPI working in a better state on the
> > Cubieboard. The main motivation was to use flashrom to to program SPI ROMs.
> > There is one patch missing, which adds an spidev node on the Cubieboard. Since
> > Maxime did not like the approach in that patch, I've left it out for now.

> Just to make things straight, it's not me alone that didn't like the
> approach.

> It's both wrong on a theorical point of view to put that in the DT,
> since it has no hardware meaning at all (ie it doesn't describe the
> hardware, or the state the bootloader left the hardware in), and this
> has been NAKed a number of times already by Mark Brown.

> See http://permalink.gmane.org/gmane.linux.kernel.spi.devel/11747 for
> example.

Right, I'm getting sufficiently many people making this mistake that I
think I'm going to add code to complain loudly if it's instantiated as
spidev from DT.

--IOWfJl95iVQnrM9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUjxOGAAoJECTWi3JdVIfQOBkH/2s+GVPj6p9Hx/1Eqwi5U2EX
S8FzsSeMeoMMFTKo90ZYtzkBt5TZUvwkHYkcYvdbyavGcxyvDn3psWaVYLHe3KXi
INEGSOpTS18x+61Any0hr/ALReFwSmY3vvwDbib23HqJCDQKE1Yxnj+Ho5IeL7G5
h6p1yAwe6qq/uWi3U0wjCbG6JptRsF+gj121hN5drv4BTJGBlBgx3PDgHpb3nG8G
S69plVLoNDUGXbKj30exbHf/9wpmwLSmh9dnvcAAc53j7cGllKfPrFVUBW2LNGfy
09KeIpSbDExNnRnu7sKW2qKxNdn4ow5WD9WtV5nAMOamX/kHTJ78kZaFrSQ5SkY=
=FtL4
-----END PGP SIGNATURE-----

--IOWfJl95iVQnrM9l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
