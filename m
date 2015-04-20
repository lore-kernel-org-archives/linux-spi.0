From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rb4xx: Fix set_cs logic.
Date: Mon, 20 Apr 2015 21:37:03 +0100
Message-ID: <20150420203703.GG14892@sirena.org.uk>
References: <1429538005-1985-1-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429538005-1985-1-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 03:53:25PM +0200, Bert Vermeulen wrote:
> As it turns out, the set_cs() enable parameter refers to the logic level
> on the CS pin, not the state of chip selection.

> This broke functionality of the LEDs behind the CPLD, or at least delayed
> the commands until another one came in to toggle CS.

No, the enable parameter *should* refer to chip select assertion (see
how we handle GPIO chip selects).  However it's possible that this
device has an inverted chip select and should be registered with the
SPI_CS_HIGH flag?

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWNvAAoJECTWi3JdVIfQEQYH/1bvHp22WPxaKrrlichE86xh
tVCjq06vdcygcenPKgKwvyMCdjpZN/67x2rET8He8Vxl29C1Ax/1f477WM7miI8Y
XLdaMb73dWFnw45xYp65eEytuxz3x+ig0+T5BCJDzG9hAHP88SO7ksGMeI9G2Dzk
oKmDawvM18RD4f3h5m4ttn+joUa/iT/Rnol5TlNzN3wP57LBYGOprqdFjDwuTp5y
LsLzDVWSojCyJn/SAMtyNMWjLRkyvMiAN5PN0IRW7qLvf/yuWEpR5QXVaM7LFm2Z
joozo0/bPssxqV82aLzVbnCf1fESSIkEvEbGgPCI7c4vH6QCBSHA4rsAi/d/XGU=
=U9E6
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
