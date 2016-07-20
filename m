From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 20 Jul 2016 12:25:47 +0100
Message-ID: <20160720112547.GE6509@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk>
 <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk>
 <578EA695.1030909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <578EA695.1030909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 03:15:49PM -0700, Florian Fainelli wrote:
> On 07/13/2016 03:36 PM, Mark Brown wrote:

> > If it was unconditionally in the perhipheral it'd be fairly normal and
> > standard but it's not, it's a completely separate and optional register
> > block with a bunch of separate code in a driver which already has above
> > average complexity even for the bits that belong in it.

> It is not separate nor optional, the fact that the register range seems
> discontiguous is just an integration choice here, but it contains bits
> that are relevant exclusively to the SPI controller.

Some versions of the block have it, some versions of the block don't
have it.  That suggests that it's optional.  It is a completely separate
register map, that suggests that it is an external block.

> It is not exclusively an interrupt controller, there are other bits in
> there are do not functionally belong into an interrupt controller driver
> per-se, things like a clock enable, arbiter control and a random bit to
> control MSPI flush behavior.

> Oh, and please don't tell me regmap is the solution here if we need to
> control both the interrupt-related bits and the other bits within this
> register.

That does sound system controllerish if those bits do need to be
managed.  Are we sure future designs won't just integrate this into the
main system controller?

> Considering that this block aggregates interrupt enable bits, but not
> just, there is no reason for this block to change over time, and clearly
> this won't be handled via a generic interrupt controller driver either.

There must be *some* logic behind the way the hardware has been
structured, and right now the code just isn't making any of this
apparent which makes it look like it needs refactoring. =20

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXj1+6AAoJECTWi3JdVIfQRZQH/1Ja/CiszbLCiQSMWQ9F75RV
n0c78qJANSA1lCDzAZkKyBYVb2HKkUKPrW1LPHk7fg7EDlrFjGeVALCs1XqLANEH
AnEP9jt9MDMUSB7/+gP9oWZlrcj9FbEInYB+I+VQhPt06pD6bplk4bAiyAn5qmhY
Wt09HK3h/KMR/VRaLzkDj1QPMr9tKYOCRIWzMvnGhBJ84e8elweEip7oj6KC9baX
Xgq6U8pMM3TeJCG08oqBb8C2s7cLEpdSbV6WzGNSLafoRQ9Gj28eCBGqzoOpiF1H
gKqOz6y0bjGTsriylNR9q6v8LlLyi82k3v9BbDhDbO4H9kxKGqWDC2puQ/xjJ+c=
=8n6a
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
