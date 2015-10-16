From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: change initialization order and switch to
 platform_get_irq
Date: Fri, 16 Oct 2015 15:35:13 +0100
Message-ID: <20151016143513.GN14956@sirena.org.uk>
References: <1444903752-9180-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3LbzE+0aVzOo6fIw"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444903752-9180-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3LbzE+0aVzOo6fIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 10:09:11AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Change the initialization order of the HW so that the interrupt
> is only requested after the HW is initialized
>=20
> Also the use of irq_of_parse_and_map is replaced by platform_get_irq.

Thanks for doing this, but as I keep saying please send one change per
patch since it makes review and applying much easier.

--3LbzE+0aVzOo6fIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIQshAAoJECTWi3JdVIfQ/U0H/A37E8hTxhYvRXsfnuSmKrdL
c1vdmX3owQQU+CTz9lPUcD1A+nd4SCHLqoqlNPrlxRFM+OJvfNIdDSLeBE/1GUUz
uh0iQDBbJ3j8wCk1cWcoQxmdJCD3ar4I8K9cDrm/ObFykifAlMCjz6fduzRtiqXs
8J6Tc7slHQZYYEV7UMPT6qsn1UhABKLG+An7BRmIbBwcNr00Emf11LepinTbO2FG
WfS/lAGYgTBqzszF7pClZWBIH5l3vF8YU/K64XGvgrMfT5VpAPtZ3JGOsY7rObLB
jWiAP7RFg0QJPHWCyunsE0mC6oZtVmPRQwwzOMvSVaFZfJC7VktkRHwRBIBbx54=
=1aE+
-----END PGP SIGNATURE-----

--3LbzE+0aVzOo6fIw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
