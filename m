From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fix overflow in calculation of transfer
 time
Date: Wed, 29 Jul 2015 17:03:43 +0100
Message-ID: <20150729160343.GH11162@sirena.org.uk>
References: <1438155250-14476-1-git-send-email-kernel@martin.sperl.org>
 <20150729140331.GC11082@sirena.org.uk>
 <0D1C5BFD-04A0-4074-8424-DE941B00F887@martin.sperl.org>
 <0C2A92A8-867B-4BCE-8AD4-F2D297DB918F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y3Ez3x+4XXFFBlFj"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0C2A92A8-867B-4BCE-8AD4-F2D297DB918F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y3Ez3x+4XXFFBlFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 04:35:03PM +0200, Martin Sperl wrote:

> Now that you have applied the patch already, do I need to
> resubmit the commit with a changed description?

No, it's fine.

--y3Ez3x+4XXFFBlFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuPlZAAoJECTWi3JdVIfQlzsH/1FRMTCIppiNoBK+v28iu6sG
fT7GfwEtsT+qRIOqjmcfKjSOfpIPVWhhcAsPkJJOWKXdOjjoDuDCy16HPitw80bc
dBQrcyuAan/5ZDXv0/DlY9h6veLWCvUK5ZS022BdsUEPPwpLf1eWw4WAHg+5y0GM
DihUJxCoA4J+UMsPCPZk0lweQCAnQb/fma1rYQerdJS7QniURq8wzxnQyga2kcnz
nmQqVjB/F6p+KLW/R2U8qYMQ92nid5Osy+fzHi4Yfj/Y++uHc/CGH/+xbVl4vB5+
unCCSbXLhUbsCbYQyISIAwrKUZoyznjDGH7SE4KvBqWhTOwZbZzu5FbVEQTFEck=
=G5dC
-----END PGP SIGNATURE-----

--y3Ez3x+4XXFFBlFj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
