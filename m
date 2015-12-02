From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Wed, 2 Dec 2015 12:29:53 +0000
Message-ID: <20151202122953.GG1929@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-2-git-send-email-kernel@martin.sperl.org>
 <20151201210410.GU1929@sirena.org.uk>
 <56C9120A-8979-4156-B3C4-5851D695BDF0@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="suyaDfHbCMIDpItJ"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C9120A-8979-4156-B3C4-5851D695BDF0-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--suyaDfHbCMIDpItJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 08:30:51AM +0100, Martin Sperl wrote:

> > This has exactly one (tiny) user.  Why is it a separate function?

> Readability, mimicking devres code and the option of adding
> object caching/reuse here later...

This is *not* helping readability.

> There is a much higher likelihood that spi_resources will be
> allocated and then freed several times per second, so this
> can save cpu cycles and avoid locks...

In what way does splitting this over two functions helping improve
performance?  If there were multiple users or something perhaps but
there don't appear to be.

--suyaDfHbCMIDpItJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXuRAAAoJECTWi3JdVIfQba0H/j0C7gYWfacg0ux4JncQtetj
bp1M9iwP6Mjlotz0+XUs6X/v97apwk/QEkWmw8iMBeCEltVyvLI6uWRdA97NGQRZ
F2wjdEhddAwJpkZ00Sud0vntyT8q+E/ahvI5aXxnidq3zZvK67fu4w3KdRBFabB4
j0xKbic0iLMIazkDYlbAUZFp9dgOttIh2plHfEZ6Sh5IsIC8mgQ3sDqDR/rQfMOh
DPyFzK1njb1wSls4wSu0mWcw1LtPhBepPR5M8jSPbo3UkLO5J1IPK+pWbPWTLPc0
JA326dXDmYMkkN8+AQJBbZ6xHodEKXDV7arEmv/1tLx8xNBUFbDx3Vi0TWv2qIY=
=qQXS
-----END PGP SIGNATURE-----

--suyaDfHbCMIDpItJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
