From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 18:43:08 +0100
Message-ID: <20150513174308.GG2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513125102.GA2628@lukather>
 <20150513143610.GT2761@sirena.org.uk>
 <CAOMqctTd7xG6mwX9AojTH4uaGDY06xOgDFUP437VDiE0rp0sXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/8Xxy37xq6kDVsli"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTd7xG6mwX9AojTH4uaGDY06xOgDFUP437VDiE0rp0sXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/8Xxy37xq6kDVsli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 05:31:05PM +0200, Michal Suchanek wrote:

> But you know, unused i2c bus can be also connected to "make the board
> catch fire" trace and nobody would notice until somebody has the great
> idea to probe it. Incidentally, both i2c and spi cs are active-low
> iirc.

Someone would need to go and explicitly mark an I2C controller as
enabled on a board for that to happen.

--/8Xxy37xq6kDVsli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU40sAAoJECTWi3JdVIfQulgH/R8C8yY6rOCF8voiTbCVwjLW
EBFsB6NtlTQOoGk7S5GwPb6Ks0twE9HnQmje61dzEJM12/oxlBNRrT0RlmV8w8pz
qF33ciaXvJF9c/Cw+kmcaVhNE0TxDUcCPkVDveyJXYZQbi0twa3Ijxgj9vCmMCaG
Mr5GvMj2y5XG03ihr5DOYyZJPVX3D+2OlsFHLW7NgaBDixibl5ZYoBxAW4n4Sonc
L+lrUVjYXYvnxaM8VyD6fz5R3vLbl+OH+MNX80vst2X5h98AUhuiSB8Cqu2ClHTL
JEG/lGHe5bp99CvNBn+qphGd7OPTaR3ka4+170bivmhgGXGTd6vEbFawPnBYhiE=
=O1yP
-----END PGP SIGNATURE-----

--/8Xxy37xq6kDVsli--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
