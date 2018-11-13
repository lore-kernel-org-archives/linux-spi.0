From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 15/17] spi: bcm2835: Switch to SPDX identifier
Date: Tue, 13 Nov 2018 10:02:51 -0800
Message-ID: <20181113180251.GD2089@sirena.org.uk>
References: <1541868612-8268-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2594677996197233552=="
Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1541868612-8268-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============2594677996197233552==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2018 at 05:50:12PM +0100, Stefan Wahren wrote:

> index b0b87ff..a418683 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Driver for Broadcom BCM2835 SPI Controllers
>   *

Please convert the entire comment to a C++ one so it looks more
intentional.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrEcsACgkQJNaLcl1U
h9CpvAf/TpI2h2buVNpo8TANxwOC9Cr48YWTxToUEL+oTPBMVNwZN3w6z9NLVRYQ
xZambESLA+ABa9q15Hs8VDbwje+xUSD7Z3IVlAhEaTKwHWZ3afi9Xc/+wBBHkHOU
7z0GCRugivWVN4Z4/1Ya12eecmBfinYw06fptf9vcbXNUGg0DDrzBzsm1lNqSUfG
91Odgp9FXhJLrPkTIFjjaH7bnz1MujBQBIQdN0nbRUavVKhQsbd+8HH1bf64ICFa
6CORgTV8Y1JPeWYnLl7kcpazk7dyTEtd6kAOozXbx+1F3YUETJoRH9WVlgJpkalZ
VoifJduJRXgz5Ap6eiJOI9EQjAH0EQ==
=9fMB
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--


--===============2594677996197233552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============2594677996197233552==--
