From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Tue, 30 Jun 2015 10:42:32 +0100
Message-ID: <20150630094232.GM11162@sirena.org.uk>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
 <20150622165529.1b758b07@north>
 <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org>
 <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <97C7561C-6D67-4F51-94BB-3B8D401D77A0-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2015 at 04:19:17PM +0200, Martin Sperl wrote:
> So what does it require to get this merged?

Don't top post.

This looks relevant:

> >> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> wrote:
> >> As mentioned by Noralf UART1 is quite commonly used on Compute Modules.
> >> Proper driver - perhaps modelled as a bus - seems like a prerequisite
> >> for this work.  You are also not using IRQ mux in DT binding example
> >> which is very misleading.

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkmSHAAoJECTWi3JdVIfQk8gH/1fvuSsjq7h/kj0PBkRKVXSw
z2ixs8Wx7meucb7w3T+fVvaUJ5CTQIFGoA2nCRDDDupNkjMFraNnhhS5W2UFdnDy
Z2ONmywiySMc3wfUl0MmXgz0ETF6Q9OwQ8DFsdQVsl7KnVvgW0TUWJo8DugX2hJD
DFt/eImM6YrbIjAz2H4UatKb5xsoogpeImoT6eXxKCEPtrBxvOG/h+UPMWSFFyco
BP3j7P6BT9rSElPObl47O0aCz30+78JlkZrd8vf8NEkEEyTiUiSmr5cFrTmSP9mO
5nQmis/29NgnI/JotjSoKsp/lg5JaR7zlPPAzGJi1McVRlTtpNpz1toyFKDOpo0=
=OWhC
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
