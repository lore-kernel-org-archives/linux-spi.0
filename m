From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Wed, 1 Jun 2016 20:00:56 +0200
Message-ID: <20160601180056.GA4908@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nlttjmhgc7EeTk3T"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160530155016.GO29837-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nlttjmhgc7EeTk3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 30, 2016 at 04:50:16PM +0100, Mark Brown wrote:
> On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
> > On 30 May 2016 at 17:03, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> > > I really don't think it's worth caring too much about cases where the
> > > DMA driver hasn't been compiled in, it's not like SPI is the only thi=
ng
>=20
> > It's what the driver did to start with and it was requested to fall
> > back to non-DMA in the case DMA is not available.
>=20
> Why?  I really can't see any sensible use case for this that doesn't
> have a better solution available.

SPI works just fine without DMA, which might just be considered an
(optional) optimisation.

We've been using it without DMA for years now, and it was working just
fine, and it will work even better with the other patches in this
serie. There's no reason to add a hard dependency on something that we
don't really need.

Maxime


--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--nlttjmhgc7EeTk3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXTyLYAAoJEBx+YmzsjxAgi18P/38gyeOkQkz1RreXW17wIRr6
89Fvjr/0bZUEf5WIOjIj8klc2XAIEmnLKoBsd7RyftgfSRVHyDX5ZmvUPu2FDa3A
PCVpteJyQmgPoGnlw2ofiYK80eew1MCDKQJsgmOpome/WBr6/vA+hNSfEvfzN1IB
gk47ey7118lWCP7kIhmAant5PI9EBpYlexhmi2fC92XdTLqtDIoJHzyKuv87qWdH
wAelA50Zwo1jP4j2XhANAXOgLzJ0RFgHo3eMly2tR7A6AR2HXHISYt9E/Pm2uObD
uz0zzoOHgs/Wtb/r4+eMDI4kMtxBoL7rhm4kJpyxFAo2Mjyje29miYUebBFdMyVt
mef/F+0IK1DsbB3bP3qktCH4twlDSCDzCvU5qreOZitOzaN//8xKtIhvNFonbdOj
tuQG2d1k+lB3CmXJ7VkM4luntIDfO6T8bQLwgudZZqifT5LyJyyPxrt7YcAlQCLy
w5o6YfP5KjLgi4GqCjVsb64kHj1j0F0OF7ysASPAJB4/J4TKMtZ0hExhjmHzm/H4
5PggVDePmEqRjuTe2ldok14/4n/AEVWRdcEWJRuoiesE3O+fcm8nxm9DtvTtvXui
z6gCcXt6p3EYFbZvy9NVqrleaFY1wt0L8OHtEVLEem9R/uURTaGFQQtgRAvzb5R8
F+umlFdjbfzBa36ydTs9
=sR0e
-----END PGP SIGNATURE-----

--nlttjmhgc7EeTk3T--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
