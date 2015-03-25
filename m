From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as
 SPI-chip_select
Date: Wed, 25 Mar 2015 09:54:41 -0700
Message-ID: <20150325165441.GI3572@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <1426755714-28130-2-git-send-email-kernel@martin.sperl.org>
 <550BAA89.5090707@wwwdotorg.org>
 <20150320095247.GE2869@sirena.org.uk>
 <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
 <20150325151611.GA3572@sirena.org.uk>
 <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <681599F9-2D88-49FF-BD16-4F388D0B2874-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 05:13:13PM +0100, Martin Sperl wrote:
> > On 25.03.2015, at 16:16, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This appears to be open coding the core spi_set_cs() support for GPIOs,
> > why are we not just setting cs_gpio and letting the core take care of
> > things?

> In principle yes - the problem is that the core method is not exported.
> If you agree to export it then I will create a patch using that.
> Maybe even exporting it in that patch).

There is no need for it to be exported, as I said you simply need to set
cs_gpio and it will be used.

> The problem with the core framework as is is that it currently does
> not support handling multiple spi_transfers in the irq-handler itself.
> Instead we have to wake up the worker-thread to handle the next
> spi_transfer which will - at some point - will trigger another irq,
> where the overhead is again 5-6us until the spi-irq-handler runs.
> This obviously adds unnecessary overhead.

We've been round this loop repeatedly, as we've discussed improving the
framework is a good idea.

> Keeping it as is means we can easily backport(=copy) it to the kernel
> that the RPI foundation maintains and that gets lots of exposure and
> testing.

The thing to do here is to get this code upstream, supporting out of
tree code isn't particularly persuasive here - people commonly try to
use their out of tree requirements as a reason to merge code that's
got problems upstream and I don't want people to get the idea that this
is an argument that's going to work.

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEuhQAAoJECTWi3JdVIfQxqQH/2G6whe2R6vngnjiGG29SY3p
a3awG2XjI1HeChTs1L/rJqh9v1s1n+EV6H9LkU2FerFi2EC5Lw6X2qMh6GcAoy+o
2cCiJFfyWQQThHUWxDp+jujQfZhCggfeLf4hMpIZHmlwJXXlY0T2XBB7PDZiB6c2
hPIKjKnSAGgJptKjD+bRoGJXOSF/xUFLrKkYsOEW8Z5iGb/rwUXG7v2fR+zryfXv
0FZX2wNEgg9BvyaryK8kxI5yE5KRJCPcY/9vZ6IkCgnVGzITbJU8IKVbAOttQJXh
UHZn7mrFr2WR2Wn16cpOeJg570cZp+EGMM2S6fZTyUylxoPw8Luv4hVGmtpzVx4=
=pMBN
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
