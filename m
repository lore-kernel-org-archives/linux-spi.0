From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fix overflow in calculation of transfer
 time
Date: Wed, 29 Jul 2015 15:03:31 +0100
Message-ID: <20150729140331.GC11082@sirena.org.uk>
References: <1438155250-14476-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438155250-14476-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 07:34:10AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> This resulted in the use of polling mode when other approaches
> (dma or interrupts) would have been more appropriate.

Please describe the actual issue and how it's being fixed in the commit
message.  In this case the fix appears to be converting the timeout
variable to a long long which will make things better but obviously
isn't a complete fix for overflows - presumably the ideal thing here is
to handle saturation better?

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuN0zAAoJECTWi3JdVIfQvyEH/A32+P3w1AfLO67iFMtbEElV
HBCs2Iy1/jmj1cIcohe0prU4GaQXG6Y0TGy+p/PMj1TYklUYlMl/fgUBZovjh/Ar
TBqtqwRUFNVF4eu4QWLTnSj3RwhmlJiVQJ77IOnOqY/O8eSjMg6+Aez0UZEdHxFb
k1GeSmkyWwwSBlhsJNaqy/O1DAa0/+VS+OurOfRorfLvvMFOhUr03BMlJSDceBkO
H3pM2r/xov4MIgNR8jZAircPETuKCfX8vmI/lLXmRNvoMHGJXJVcxqNOUueJShCi
5PzhyAdsI8hFPgQpbnCVy1crwLmAqLyEcb2lGnTs4CpUQmS8fg2w/96Ae3p9NrU=
=OfEu
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
