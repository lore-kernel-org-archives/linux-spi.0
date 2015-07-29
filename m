From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
Date: Wed, 29 Jul 2015 19:40:43 +0100
Message-ID: <20150729184043.GL11162@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk>
 <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="akWijmsqBEgP5JG6"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Padmavathi Venna <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--akWijmsqBEgP5JG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 08:21:34PM +0200, Michal Suchanek wrote:
> On 29 July 2015 at 19:16, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> It will not break anything. It will just spam dmesg.

> > I'm confused - if all this change does is to spam dmesg then what's the
> > point?

> Presumably when your SPI NOR flash fails to probe this message will be
> just above and you will look into the binding doc and add the
> compatible.

If you're looking to add a warning message when the flash device fails
to probe then add that in the flash driver when it detects an error,
this will cause needless noise for everyone else using this controller
purely to work around the broken binding.

And like I say compatible really seems like it isn't an appropriate
property here.

--akWijmsqBEgP5JG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuR4qAAoJECTWi3JdVIfQw84H+gIG06W1d5C+xW+3hdwVcySH
U+hKQACjqxbhWce28likOpb+KV3qC8Vqp4vRNYrfTgQbpJfnI4Sz/0q6UW28FL2y
ybxkDt3/XMC9D4fWRodIDZYUxEm/76Z0/y1h0VAwXSHMS8bziwltgiTVMfpxRhPv
yXOFjuhdMDHQcoTzj34vBpep1c6RT6ymMw0C0szqmElwDUvcMvh1GTidkDTTk/nQ
o/IrC2dXrjQF12YpuwRPpth98ZR2b38WkVa/Fd/nyCTbvRWiwdAY7Yn3tBTD/Hns
w1GsUiOys9kPykg/qeBOI5sLr/Y2GmYeYzz4hUdfENXDo3CCm2T62riqAjUfNng=
=+uJe
-----END PGP SIGNATURE-----

--akWijmsqBEgP5JG6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
