From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC, PATCH, RESEND] spi, spidev: Add support for long SPI
 transfers
Date: Tue, 25 Nov 2014 12:42:29 +0000
Message-ID: <20141125124229.GY7712@sirena.org.uk>
References: <1416853893-1993-1-git-send-email-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y9MYNmSb6ticsAhO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yurovsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416853893-1993-1-git-send-email-andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y9MYNmSb6ticsAhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 10:31:33AM -0800, Andrey Smirnov wrote:

> SPI controllers found on modern SoCs have rather large SPI FIFOs and
> allow for uninterrupted SPI transaction that are more then 255 bits
> long. This commit adds necessary plumbing for such SPI transfers.

I really don't follow how this change is connected to the changelog...

> As things are right now both SPI subsystem and SPIDEV driver are
> limited by their APIs to SPI transactions that are no longer than 255
> bits and that problem is exacerbated by the fact that transction
> length validity verification code does not have provisions for
> anything bigger than 32 bits.

No, that's not the case at all.  A spi_transfer can have a length that's
an unsigned integer number of bytes which is much larger than 255 bits.
What is the actual problem you're trying to solve here?  I suspect the
driver you are using is just badly implemented...

> +		if (!u_tmp->bits_per_word && u_tmp->bits_per_burst)
> +			k_tmp->bits_per_word = u_tmp->bits_per_burst;
> +		else
> +			k_tmp->bits_per_word = u_tmp->bits_per_word;

This is setting the number of bits per word which is nothing to do with
FIFOs or the lengths of transfers but instead concerns the formatting of
data onto the bus.

--Y9MYNmSb6ticsAhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHk0AAoJECTWi3JdVIfQfFQH/2Nmh10QRvAVTDohT6iERydQ
vA4Q3BMSxI41l3W739x2QToTzA61NCg6JjyvyDtkCtnpZrZ8+0zunJ68h9tF5g5o
0Izd3qMJ9/o1/DPf/yUkdAbxc3ekPHPLt+iOVOwFgk4a/dTpv8ZYQBXODZiP+4pU
2OJCTHMLy15FLgn77XoOdEFSoPFASN8ZEIUNufps15JnqTDOsotrgxbxOlsHzo3t
DX+UM0J7rSps2/E7Mltma+Bm/KtcW4sMX/cqSxsYxxZv/isMky6Seebeo2GMTz2O
6kKFR4ds6HyTf19UYJm+s97JmfXKcNJg6JHDnSrvhsnu8Ej+HOXQW7gN6v5oBH0=
=gFan
-----END PGP SIGNATURE-----

--Y9MYNmSb6ticsAhO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
