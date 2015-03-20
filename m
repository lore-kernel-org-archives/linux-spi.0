From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: fix all checkpath --strict messages
Date: Fri, 20 Mar 2015 13:40:53 +0000
Message-ID: <20150320134053.GN2869@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <550BA8FE.7030001@wwwdotorg.org>
 <7727F65E-D8BC-4299-A359-56FA449C3379@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+0pH9m6FYzpAKDUB"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7727F65E-D8BC-4299-A359-56FA449C3379-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+0pH9m6FYzpAKDUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 07:26:29AM +0100, Martin Sperl wrote:
> > On 20.03.2015, at 05:58, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> > Do you have a list of the warnings this fixes and why? The extra
> > wrapping here looks a bit odd, since the lines before your patch are
> > well under 80 columns.

> scripts/checkpatch.pl --file --terse --strict drivers/spi/spi-bcm2835.c
> drivers/spi/spi-bcm2835.c:182: CHECK: Alignment should match open parenthesis

This is telling you to add more indentation to the second argument not
wrap the first.  Though frankly I don't think it matters - it's
certainly not a routinely followed thing and it frequently makes things
worse.

--+0pH9m6FYzpAKDUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDCNkAAoJECTWi3JdVIfQibcH/RpgShUpl5guDg1696Rqv+QC
B06LMVtQ5wrCCFVXj1ke4NSzE1ayJRxtJ0rMjQnfTyKHvg0Jz6FcEwNktOdN0Ica
LWGS0XgjYgowGMfeZeY0qZZnCDBpc4/SJm4eqKk+Imlu9OI+o/Gh4ZHXc02yDv/x
q94VSTxZTBRagg9U24vY7+qYi7U0GibOzSX8LF4O4+9mI8+3XR46aSnkm2SsY0Dc
CX3a5bIIZRYMpkzV8q3EyS+io+KRlCzPTwqF4H4spyOZHzPXfwHi9cE8FNknPKZH
j1PMXnNrI6K6XinMQtXqEnPerZ/vD6u3SLdGQm+1WHKRaRcvVlZVgADHlWYks30=
=WXUp
-----END PGP SIGNATURE-----

--+0pH9m6FYzpAKDUB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
