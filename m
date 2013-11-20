From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Wed, 20 Nov 2013 16:24:49 +0000
Message-ID: <20131120162449.GJ2674@sirena.org.uk>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org>
 <20131120112920.GX2674@sirena.org.uk>
 <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f/eKwl5uGhF2Mfol"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--f/eKwl5uGhF2Mfol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 04:27:06PM +0100, Martin Sperl wrote:

> As mentioned before I will take the opportunity to move the flags into
> spi_transfer for optimization hints, because there is where the change=20
> really happens...

These are set by the caller?

> The current bits come to my mind:
> #define SPI_OPTIMIZE_FIXED_TX_BUF	(1<<0)
> #define SPI_OPTIMIZE_FIXED_TX_DMA	((1<<1)|(1<<0))
> #define SPI_OPTIMIZE_FIXED_RX_BUF	(1<<2)
> #define SPI_OPTIMIZE_FIXED_RX_DMA	((1<<3)|(1<<2))
> #define SPI_OPTIMIZE_FIXED_LEN		(1<<4)
> #define SPI_OPTIMIZE_FIXED_DELAY	(1<<5)
> #define SPI_OPTIMIZE_FIXED_SPEED	(1<<6)
> #define SPI_OPTIMIZE_FIXED_BITS		(1<<7)
> #define SPI_OPTIMIZE_FIXED_ALL		(-1)

> The flags argument now is of type gfp_t to allow for memory allocation
> policies.

I'd be tempted to start with assuming everything is fixed and then add
flags to mark things as variable rather than the other way around since
that's the most conservative option and should permit the greatest level
of optimisation.

> I will provide the patches as soon as I have pulled your tree - only
> problem is that I can not really compile it on this tree on my RPI...

You should at least be able to do build tests, it's OK if you can't do
runtime tests - I can do validation myself, as can other people working
with -next.

> Each of those unfortunately would require a separate create/free function
> to populate the caches. So generalizing this into spi_master would blow up
> this structure... But then these cache structures would need to sit=20
> somewhere anyway, so adding them to the master would need to happen
> one way or another... But then maybe there are different ideas for someth=
ing
> like this (but I assume a driver making use of this would be required fir=
st)

Yes, there's some tricky issues here...  let's have a think about it and
try to do this incrementally.

--f/eKwl5uGhF2Mfol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjOJOAAoJELSic+t+oim9RAEP/A3t3TSh75WUBa096PqluQh0
YHiryOjhBQIuG/goD1z/sZSiU/LdcrH0ANPrLVLKqQ1ocRHF/CGre2gZB/qjCCuN
UWljgdz/AzKlc2rBveAFCXU8fCAiUs5hJhOXWUtftztxX0lWm9Q7Kx0zslX2FeR1
sDo9UBY0z7UzAUJF1soc/+UCdo2WB0BKE+GZ0S9AJo5W1SpE8xLc4RpM5FE2a3SJ
y1LU2BafNxDZgG6tCsSfraTYsCxmzj8NVUaRU6DB5Y4QWbYHKpfBIMYkQJTYmEqE
3gMYcb5NeWuznJK+HrSD3Cem+fGfVYqRJ8UUbUqZ9iIBShDITMsL0dpHeDcY24YL
rsRc8pFqL3oqsI/qMutTalS2y17Sf6DQjryHE+wKfjF332CS3++08fKD8AcaVAOU
3Ych3d1/55J+LNPN5bSKOaREdxJefu9t++mw7P1DXDdaFPl8DICEXgHQA8BVbqEY
LBf/1gpJfld0suxKcji8vUgbJG+/OEInajHp95RWnGzoAh8vmpPlPCrI9bgdYXE+
2vtffUaC3VjzNMcbMHFHaFEFmRHcc9KrxSWpJe/Q2+yw/YyC2M6SKn5TIS6CzgaT
1HYX83QA6NrdLYiUR3tQTHyMD1e8Bm+zZNpgXy5cOVIXUsxhpV7mTUPvvzX85yj0
I4UTRPbK4YoqMG/F154W
=BW/S
-----END PGP SIGNATURE-----

--f/eKwl5uGhF2Mfol--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
