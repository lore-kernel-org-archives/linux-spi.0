From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Sat, 18 Apr 2015 11:42:02 +0100
Message-ID: <20150418104202.GA26185@sirena.org.uk>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
 <20150410185132.GU6023@sirena.org.uk>
 <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
 <20150415185824.GU6023@sirena.org.uk>
 <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <262B0C8C-7728-458E-8748-06F79251BE0C-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 09:33:48PM +0200, Martin Sperl wrote:
> > On 15.04.2015, at 20:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Running without a timeout doesn't feel safe - the standard thing here is
> > to busy wait for a short period then fall back to something that sleeps
> > if that times out.

> That is what is implemented now, but unfortunately the issue is that the=
=20
> implementation as of now is depending on jiffies, which I found out to be
> in the order of 10ms and on top requires a timer interrupt which would
> interrupt polling in the first place. But it is still sensitive enough
> to trigger on some rescheduling of the polling thread.

Then that's not what is implemented...  I'd expect something like a busy
wait loop done by something like dead reckoning the number of iterations
followed by msleep() if we go beyond the busy loop period.

> One possibility could be increasing the timeout to something longer like
> one second or a fraction of one second.

> Something along those lines:
> -	unsigned long timeout =3D jiffies +
> -		max(4 * xfer_time_us * HZ / 1000000, 2uL);
> +	/* one second timeout - this should also allow for graceful
> +	 * timeouts even when experiencing rescheduling of the thread
> +	 */
> +	unsigned long timeout =3D jiffies + HZ;

> Would this be sufficient and acceptable?

No, we need to not busy wait for that long.

> The patch removing the timeout worked for about 1.47B SPI messages
> using the polling code-path now without issues.

Sure, if everythinng is working fine then there's never any need to time
out - the question is what happens when things go wrong.  A hard lockup
probably isn't the answer people were looking for there.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMjT5AAoJECTWi3JdVIfQbUgH+gPXqVE1iGd5hcbpr6Rf/Puu
t9w9gHbBurii1lwy6GVNeZuYetdZVhzPc2TOri++cZAlVRynjrJJCg92prufb/n3
6h04NvgamfeziWX6uONWH2qXpFyCjt2gEeo5ltW5wwJBs0XEgs5axVfKUcP/jYiQ
wYurbo+kUvFwrysyWHtkeZ2/VWbVD2uLNE05jXDN6dR/kYeE3p8j6bXUHhSwg1P5
TSgkDNHCi3AbSI/x8aQnIJxoevnKdmy+pQ4pKRyqFqTWpeT266Hh0Twgi9hNShex
/CLijWh1kPngs15JJO0umMwitsqP0JGvnN2A0lgvDIFy6r1CeRFpGmR5WsJakhs=
=YklS
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
