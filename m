From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6] ARM: sun4i: spi: Allow transfers larger than FIFO size
Date: Thu, 21 Jul 2016 19:15:45 +0100
Message-ID: <20160721181545.GP6509@sirena.org.uk>
References: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
 <20160721112701.GB6610@weiser.dinsnail.net>
 <20160721163153.GO6509@sirena.org.uk>
 <20160721172712.GA10640@weiser.dinsnail.net>
 <34E27D10-C620-4288-A1A8-489B75D4757B@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Cc: Michael Weiser <michael.weiser-Mmb7MZpHnFY@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <34E27D10-C620-4288-A1A8-489B75D4757B-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 08:03:16PM +0200, Olliver Schinagl wrote:
> As i recall, some claimed it was needed as we have dma now, but i think this patch still scratches the same itch ...

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXkRFQAAoJECTWi3JdVIfQOEgH/1+rv6GXF8TsfDY8bYFsi0PI
t4ohQuEISP0TYpYs2rf32Ke7bICvAmaFPCzPm5QOxUAA+usfwaqijYaBCqH6KOHU
hi9YwLoiAJhpIhRHZ6tWwyRM47fuyl890OO1nJlD4GTY75I7tBlQgC5O8rGTgzx1
65W4376fX9pD1fogbC6HLZmS/hyxWz9y4CMnSzr1mb5rdcakV/wFRKKqGKWY73wx
SEX4Go7pj8mtUbGjvT5hF563t4dCvinhs4R2nwErRiKMYb59mWIXutqZoPeTD/xu
ovlKRx635oex/dkLE2TDoCdsm6BvFRcmeDlJKEL3Yp2aQvbKTURJ97wR9hAXIQA=
=EvpZ
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
