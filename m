From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/rockchip: Make sure spi clk is on in
 rockchip_spi_set_cs
Date: Sat, 5 Mar 2016 13:45:31 +0900
Message-ID: <20160305044531.GB18327@sirena.org.uk>
References: <1456308004-29102-1-git-send-email-huibin.hong@rock-chips.com>
 <56CD8F85.2090204@rock-chips.com>
 <20160226015829.GC18327@sirena.org.uk>
 <56CFB916.5010403@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YTJxIO/azM2K2lD0"
Cc: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"shawn.lin" <shawn.lin-NgiFYW8Wbx6Ta72+1OMJgUB+6BGkLq7r@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: "Huang, Tao" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CFB916.5010403-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YTJxIO/azM2K2lD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 10:31:50AM +0800, Huang, Tao wrote:

> You misunderstand me. I talk about spi_setup, as
> Documentation/spi/spi-summary, which would normally be called from
> probe() before the first I/O is done to the device.
> spi_setup will call spi_set_cs(spi, false), which introduced with commit
> 1a7b7ee72c21 ("spi: Ensure that CS line is in non-active state after
> spi_setup()"). And spi_set_cs will call spi->master->set_cs, and set_cs
> callback will access register. Without clk enable, I believe some
> drivers will failed to run.

That's definitely very driver specific, a large proportion of devices
don't manage their chip selects via the SPI controller at all.

--YTJxIO/azM2K2lD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2mRqAAoJECTWi3JdVIfQZt8H+gOI5ydHv+WUOYUgx906u8ur
jSrNy4ntmcmu/rma0sMnm5XplfSjfcjpyZAf1drVRii0K6jWsyuriMXimS2J2kPc
ZHYyEg9E/tbMcLB0xvo855YUIRz269QK0cX0j0VbA5qnikyNfBogqLCaVPK/Hgx4
gXDL4ye0c/vIIRExgWjIUezBIwsQP5tKlccsS516WxvNk3SQFnn+ZtgLXNSVlKh2
cWiF1gg80fncvS4IsQbv3PyTNg7ws8woYZv39df/ksYnNrGMSwWUz3u/9uvq75/w
S4xT9agud1xWzlWeoZ/RyW8/jD+gjjaQytaAC9lY7u141Uuho9S1dEVk48SHo3o=
=ZuRK
-----END PGP SIGNATURE-----

--YTJxIO/azM2K2lD0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
