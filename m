From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX RFC 1/2] mtd: spi-nor: add dual parallel mode support
Date: Mon, 3 Aug 2015 17:08:29 +0100
Message-ID: <20150803160829.GX20873@sirena.org.uk>
References: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1438592707-30713-2-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0k4Rxg87Lb8yV0u3"
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
	b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ranjitw-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438592707-30713-2-git-send-email-ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0k4Rxg87Lb8yV0u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 02:35:06PM +0530, Ranjit Waghmode wrote:

>  drivers/mtd/devices/m25p80.c  |  1 +
>  drivers/mtd/spi-nor/spi-nor.c | 92 ++++++++++++++++++++++++++++++++++---------
>  include/linux/mtd/spi-nor.h   |  3 ++
>  include/linux/spi/spi.h       |  2 +
>  4 files changed, 79 insertions(+), 19 deletions(-)

You need to at least split this into two patches, one adding a new SPI
interface and another using it in MTD.  Probably the MTD core and driver
changes need splitting too.  Please see SubmittingPatches for discussion
of splitting things.

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d673072..8dec349 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -355,6 +355,8 @@ struct spi_master {
>  #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
>  #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
>  #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
> +#define SPI_MASTER_DATA_STRIPE		BIT(7)		/* support data stripe */
> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */

This is really not adequate description for a new API, I can't tell what
"data stripe" is supposed to mean at all and I've got at best a vague
idea what "both chips" really means.  This means other developers won't
be able to tell how to use or implement these flags either, and it means
I can't really review this.  You need to provide more information here,
both in the code and in the commit message.

I'd also expect some handling in the core for these, for example error
handling if they can't be supported.

--0k4Rxg87Lb8yV0u3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVv5H8AAoJECTWi3JdVIfQTmgH/ieu6GnPLRFpaqnj5Qoz3+fq
HkuL/5L1vCeMw8cSWTr81ZAMDTsrHIxx/ZlmZ4CtdNYg7b2cigZ0uGUxzMAucRH/
wZhapvEspmuxL1uy2r37bxUH6BCo7e8Z2aX/0ssusVH8GWw44v81VfNg3k2/8Oaw
nnpQ4iOiyQ3ggIR0M5vh3mnRLErGcV5G3mKm6//jeJCpE0ugFIUdTtE60Ye/8fxO
F6TSxfpeZwWESgDAIdRTEFJodjNrwAHbwZA7Ih+BvZ7HJ1RZPH297mpDMd/SErFW
ZxP2CDLk+X8Qhy168x9kS3t0RGy6YA5Gp3ikKwmjl6MyVTeC5T5L8TDe+X5w++A=
=Xowj
-----END PGP SIGNATURE-----

--0k4Rxg87Lb8yV0u3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
