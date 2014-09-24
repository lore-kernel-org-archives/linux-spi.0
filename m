From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: clps711x: Migrate to the new clk subsystem
Date: Wed, 24 Sep 2014 09:40:33 +0100
Message-ID: <20140924084033.GE4015@sirena.org.uk>
References: <1411196710-4961-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4D0iojmU0rbTyz/6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411196710-4961-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4D0iojmU0rbTyz/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 20, 2014 at 11:05:09AM +0400, Alexander Shiyan wrote:
> Currently clps711x arch have a fully functional CLK driver.
> This patch migrates clps711x-spi driver to use the new CLK subsystem.

Applied, thanks.

--4D0iojmU0rbTyz/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoOAAAoJECTWi3JdVIfQjN0H/iGNAMubtfAztb6Dc+BTmPtc
7kCTWqBU/8Lml7xLg7n7y/CEI7YSUqj6IVr+p/2CmSF064c1VBXTYCCSZKIYALVB
W5j/Vtg2fTFNg4W4VLo0qNpcKTZ7CHNWabfgNTgpxyepKet7k9vqqN2z/vKMXMbM
gCY7l0UWhD63E552Ur1mNFhhj5dG2n1Jo+BOdeddaUVafka/v1st7iZ8PlwzaHrO
nF0zrggCElDg++fC+djigm2azPVeXDNEqq2XqkB0pdaQ70rca4gN1UOMlgbwp+n/
leJ1yFG9P9m99/MxEL8lOCdCSpS8k0QeczPIGR54HCcwWQVAZnmtZbiqfV/Gt4s=
=PZRX
-----END PGP SIGNATURE-----

--4D0iojmU0rbTyz/6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
