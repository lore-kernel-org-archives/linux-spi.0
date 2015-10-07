From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
Date: Wed, 7 Oct 2015 11:41:21 +0100
Message-ID: <20151007104121.GG12635@sirena.org.uk>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
 <20151006112320.GP12635@sirena.org.uk>
 <5613B2A2.9020309@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="scyazgeAM+HHl7kc"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	eEric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5613B2A2.9020309-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--scyazgeAM+HHl7kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2015 at 01:38:10PM +0200, Martin Sperl wrote:
> On 06.10.2015 13:23, Mark Brown wrote:
> >On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> >>+	bs->irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);

> >Why are we using this unusual DT specific API here?  I'd expect to see
> >just use platform_get_irq() here and this seems to be the only DT
> >dependency in the driver.

> I copied it from spi-bcm2835.c, where it is also used in exactly that
> fashion.

> You want me to move to your recommended api instead for both drivers?

> >I'd expect to request the IRQ after we reset the hardware in order to
> >ensure that the hardware is in a known good state
>=20
> Same copy/paste in this case - i can change the order for both
> drivers if you want.

Yes, that'd be better.  I'll just apply this now and you can send
followup patches fixing these for both drivers.

--scyazgeAM+HHl7kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJWFPbQAAoJECTWi3JdVIfQh04H90mG9uDCQxivIi2xX+bDwEYM
jyI4ePar3YMDM2hqXzdt5pNLEPuscZkxiwWCBlxAnwxFMB7lWpSoj8sPzKF0kAeL
Aq6nkXLM7GOIbWzBO2IGiw4GU/8YnDBLSsStsosao/+XAxsA0YKccFRBL7FFe9Mf
DvJpn9sKCCf0fLltL+4iibUUBKRHrfkLqSnDgz4J/fCN6PqjTnLc+UR1+2TwC3q8
LsTMAma+b8AoNfOyxxvL9/FYl2vMN2I4734WlVmJnxwvOP7iibjU77ZrsrbSxfLp
buFJImLlER4cNywAgTTyubwhY70r+5VkowQk9Z904V1HcFE6ucHJ+cNysEdtDQ==
=SnDA
-----END PGP SIGNATURE-----

--scyazgeAM+HHl7kc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
