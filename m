From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
Date: Tue, 11 Aug 2015 10:28:10 +0100
Message-ID: <20150811092810.GK10748@sirena.org.uk>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com>
 <55B22681.3060000@ti.com>
 <55C9380D.1060802@ti.com>
 <55C99D0D.9050605@ti.com>
 <20150811090342.GG10748@sirena.org.uk>
 <55C9BF51.5080401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C9BF51.5080401-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2015 at 02:54:33PM +0530, Sekhar Nori wrote:
> On Tuesday 11 August 2015 02:33 PM, Mark Brown wrote:

> > Why would there be any interdependency between the the two trees, that
> > would be very unusual?  Adding a new value to DT doesn't need the kernel
> > to understand it and the driver should be compatible with existing DTs.
> > If there *is* some dependency that suggests the driver update has
> > problems...

> The dependency is because of platform data. Patch 2/4 adds a new
> platform data member 'prescaler_limit' which this patch populates for
> DaVinci devices using legacy booting.

Ugh, you still have legacy platforms :(

> > In any case I don't have a copy of the patch any more.

> I can resend this patch to you with my ack included.

I guess.

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVycApAAoJECTWi3JdVIfQ3o4H/3YuAb0iEJR30hpZ56CmKIAQ
aWZ7Ofleq+ybLK5kohRmiADlvjApfKxq3WuuFUD+F+1sEBApev8/OqjWQKN0qDB8
95+d/3vOOlaDpbwWoGkRbc8gvKU/Qi1MCfzquzxrxwA87AADHpzjGax0wYzsnX6n
hDzS+c+OylFwBhnCclPl1Dhr/8zR3sUXHvXE1Y1N9rCa6W37qHWxBuZc+eWu5Oxt
cmpDhk5E1jYFRvgbxx0w1eC1IWM48ps0tGGuKLSYYokydyCM12xlEex02kbWzM3H
982vmGTJ8l/xbGC/skqAKyEHsYnj54bMMHSb2f49GwgkXDsXOSEzqLlCppk2oLU=
=T6Em
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
