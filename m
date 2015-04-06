From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Mon, 6 Apr 2015 19:10:33 +0100
Message-ID: <20150406181033.GB6023@sirena.org.uk>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
 <20150406172913.GW6023@sirena.org.uk>
 <12F93D4D-EDCB-4F48-B42B-049ECAD7F5E8@martin.sperl.org>
 <20150406174552.GY6023@sirena.org.uk>
 <F4571783-619C-4664-B14F-207E2D3F60C3@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZuerDrdIzQbPgkrC"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F4571783-619C-4664-B14F-207E2D3F60C3-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZuerDrdIzQbPgkrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 07:58:15PM +0200, Martin Sperl wrote:

> One note though: as most systems will get "deploying" the rpi-foundation
> pre-build kernels and their corresponding device tree it seems unlikely=
=20
> that a lot of alternate dts will get used...

> So when they switch, then >99% of all users will be using the new code
> plus the new device-tree that handles that.

People adding things to the standard kernel (presumably people push
their board support in there) would still have to work out which chip
select corresponds to which GPIO and write that mapping into their DT
with the corresponding loss of legibility there, and of course there's
the cost of modifying existing users.

It *would* be nice if the mapping to which pin has which function were
pushed into the pinctrl driver (and then possibly into the DT for it)
but generally this seems like something we should be doing more of not
less of.

--ZuerDrdIzQbPgkrC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIswZAAoJECTWi3JdVIfQY1MH/j3gFVkfM6CBbw3vT9kiYfk1
e9JEO9msteYwFYFQpEAv+y6O4wfmO+kKU1T/h98cUeUEs56rAARz2AX87Fzjb9dv
d1eQ2RHdAgSzxXzCL8Kh70CU1bq4VSnY4NLV/dsAPaiDQDBlvrQUr6G8fiVD4tS5
cTP44/GT3n0C+Yd1YUxW4P2Fk6c6qzYeZwfwGtxwgx9JGoGFTIfIJuFguiSqj8Ww
QX/OEgFR324Tx+/Wr1U8OIIwaKI8vaN+XL6K9QQw5ZRDbHYnByXPcfnOJsdsl2ad
q84Ogm0/dhlWmQSPeIQ7Ot7R+8iihr/yo4qk7FjB+K8OAruL9qp97L645Z/RmTY=
=6F0u
-----END PGP SIGNATURE-----

--ZuerDrdIzQbPgkrC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
