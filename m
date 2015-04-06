From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Mon, 6 Apr 2015 18:26:43 +0100
Message-ID: <20150406172643.GV6023@sirena.org.uk>
References: <A1AEABE2-F0D2-481B-BD83-E1AD7861E960@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mwz/dta3oUwEdwoz"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A1AEABE2-F0D2-481B-BD83-E1AD7861E960-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Mwz/dta3oUwEdwoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2015 at 12:17:31PM +0200, Martin Sperl wrote:
> > On 01.04.2015, at 17:20, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

It looks like something rewrote Stephen's message to have no word
wrapping...

> If you read the mmc_spi driver there is a lot of places where we have=20
> constructs like this:
>         if (host->dma_dev) {
>                 host->m.is_dma_mapped =3D 1;
>                 dma_sync_single_for_device(host->dma_dev,
>                                 host->data_dma, sizeof(*host->data),
>                                 DMA_BIDIRECTIONAL);
>         }
>         status =3D spi_sync_locked(host->spi, &host->m);

We probably need to have a good, hard look at this stuff - in general we
shouldn't be using this sort of mapping in clients, and for some systems
this will actually end up broken.

> Unfortunately I can not test if the the mmc_spi issue exists on a
> beaglebone, as the mmc_spi driver can not even get compiled there because
> of CONFIG_HIGHMEM being set which conflicts with KConfig portion for
> mmc_spi...

This is a bit alarming and probably also indicates that the code needs
looking at.

--Mwz/dta3oUwEdwoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIsHSAAoJECTWi3JdVIfQUOYH/jodmo21wO0n39Dv4PdYROrl
z2GuxqnvzN9SK7G5+J/SrjjzttIAdXF3hEJ8iYeuWREE01ZI27/Cq4b5/Xt9BGnL
MsFboyyATZ1Qk180AMZpcvNJRqPqSKLYEkGnA0rRBZuzJ8EpCJVQGMB1NwT4FNW7
2flNjyI2SwBbhqBcXW8N3PZ0YtO+DcarjvvLNOKjbBli3BhdHNaZtKzGNpPWSKnA
xBuwyujx6ZXxJyQ2EO/3o/x/ay84BRKpLm08ODpJPPSYmjiE8GiuXLzYWj6Ct36a
gYVpDgSSHHdq24FOJkzNijPitL9tOa39oiqjj7L0qdnggrX93swwQ6GoPJ1hNJA=
=Mt/R
-----END PGP SIGNATURE-----

--Mwz/dta3oUwEdwoz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
