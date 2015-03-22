From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Sun, 22 Mar 2015 16:17:37 +0000
Message-ID: <20150322161737.GE6643@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-2-git-send-email-bert@biot.com>
 <20150320125139.GJ2869@sirena.org.uk>
 <550EA6A4.6010206@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550EA6A4.6010206-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2015 at 12:25:24PM +0100, Bert Vermeulen wrote:

> It is bitbanging, at least on write. The hardware has a shift register that
> is uses for reads. The generic spi for this board's architecture (ath79)
> indeed uses spi-bitbang.

> This "fast SPI" thing is what makes this one different: the boot flash and
> MMC use regular SPI on the same bus as the CPLD. This CPLD needs this fast
> SPI: a mode where it shifts in two bits per clock. The second bit is
> apparently sent via the CS2 pin.

Please make sure that all this is visible to someone looking at the
driver, it's really not at all clear what's going on just from reading
the code.

> So I don't think spi-bitbang will do. I need to see about reworking things
> to use less custom queueing -- I'm not that familiar with this yet.

Mostly it's just a case of deleting the loops and using the core ones
instead.

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDusgAAoJECTWi3JdVIfQF00H/1CX4uVd9kD+thBosHoEGVPU
vDmCiJ7Ctm1baIBF3I1zqC7IOSxuJC4oHiIK+I5FnEfnlZuToIC2IbBIFRRou1G/
z1AE2HX5lwIj1HgsdhOxzkmS9XszIE4jI4yvA7POlk4u0+mhn8mGwKwDLZQ3NGBF
9nmFp2RRXMeg1wM9139kfTPcfPlPG7rDLKin4LRBTBQd8gllZ8bv4xjForq5ewU3
AKrb00Mj3bfm4ia5Ai9zQKFa3oKdHWWP+HHGmS29Wgk3ICeGbxl3FRukiKPFrLmk
s/ljtrc6Jjst/WZaBSfsJ6IoXWE1Qg6o6DchokmKvvqCKqyrpjyIJ69T6JdxuM8=
=sXDW
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
