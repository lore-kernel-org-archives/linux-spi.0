From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
Date: Tue, 11 Aug 2015 10:03:42 +0100
Message-ID: <20150811090342.GG10748@sirena.org.uk>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com>
 <55B22681.3060000@ti.com>
 <55C9380D.1060802@ti.com>
 <55C99D0D.9050605@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C99D0D.9050605-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2015 at 12:28:21PM +0530, Sekhar Nori wrote:
> On Tuesday 11 August 2015 05:17 AM, Franklin S Cooper Jr. wrote:

> > ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.

> Mark, can you apply this patch to your tree as well? Thats the preferred
> route for me.

> If thats not an option for you, can you confirm that the topic/davinci
> branch of your spi tree is an immutable commit I can base my pull
> request to ARM-SoC on?

Why would there be any interdependency between the the two trees, that
would be very unusual?  Adding a new value to DT doesn't need the kernel
to understand it and the driver should be compatible with existing DTs.
If there *is* some dependency that suggests the driver update has
problems...

In any case I don't have a copy of the patch any more.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVybpiAAoJECTWi3JdVIfQy6AH/jsTpJkwNzit/4E5DwA8iphc
whdCT3aK5x02MdbMKwNmbG9X672Yq/fVpjYvF20hS+nVzz/8R1Qbi+93pf+M4zli
XdcfaRjShlhitnT2J3CoZR+T476lVlkP+txXar/Ew2j0YzHHo02ZolazjNcOM1Yt
xxUd7dk6GzqGoaoXZnAx+i7s34aWCRDjyXvy/MCMdLV8V10fapSJwc8OhzFn9pol
Vlf7A655jQ+rlnIny/Ln9tGFga6MB7/mTBxGfELGMHNaySCm3RiC6ighkE2OpVU8
1xeEFl748xRkdfQfzfE0a+V+AfdskCDxjOPYXrE5ZZyhKe19I1SzYlI+mbbBNJA=
=Qba/
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
