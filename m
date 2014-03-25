From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Remove <mach/hardware.h> dependency
Date: Tue, 25 Mar 2014 13:03:47 +0000
Message-ID: <20140325130347.GV2269@sirena.org.uk>
References: <1395471455-10576-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+VeMz1SRxFChf6vr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395471455-10576-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+VeMz1SRxFChf6vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 22, 2014 at 10:57:35AM +0400, Alexander Shiyan wrote:
> This patch removes <mach/hardware.h> dependency. This is performed
> by replace hard coded used memory regions and interrupt to getting
> these values from resources passed to the driver. For the system-wide
> registers we now able to use SYSCON driver.

Applied, thanks.

--+VeMz1SRxFChf6vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMX6wAAoJELSic+t+oim9QWIP/Rm/YKrN+9k89UBZD2vHmUEQ
8K7Whzi1aTSPpz97mPmcUTOF8wkiNqF+TDRuJfQfS2ULlbUBEXIMJ4oLg2ok53xV
hitoMVTpKOVF+okfDJCgxPMwhqaJq4Gyr9NwRQrG83M5EHDD7jQ6CVds7MOf3+c5
RYaaRLyZAMdKMGOPdaYOvGKfC7Hd9RE1Ai8xuj89Cf6WzIX7cE/ltk1GYqAYzF9e
5zfmFnbMER87feVmjF/mM1Kx7pSp18JK6xnFH1YehRWuCn8M/cZfebE+fapqnuqZ
NFmicRDi1DLby9C/6nM70B8UY0m6sJZCuszGmdUABPwL0PUmpdk7J+5p72FT/bN3
5sQpeMv4HBSkyJJUn6YJOg3PI1c4ZwLN/Ex+xDBlbKEH9buVJrmWIXCrLaml4h5Z
mC3pEx6AIJT3vMIZyHkvcwReJj0AgS0gtnPzpaH0ars+8w718uFtYvCX/GjNfO2t
t9PAGwGh/j/Py7WYg+WkjhkcPQQ8riLukpidD/t5D+AJtd38Vg0C939mYHlOF3k5
2dYWM4cx0lOENWPa2pP6OLppIxmH8L8c6rj9+kxJIQubQonzx41Bc4dZyoAdDPyi
sCOGbmjDfQ48ojsXguyTwR2eATNUKwdpGtLnllS/FFGStU/4zs5Agx8zqmnG8x56
uOZJb1VA50cil1axizB6
=+q2D
-----END PGP SIGNATURE-----

--+VeMz1SRxFChf6vr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
