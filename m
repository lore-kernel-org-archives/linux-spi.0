From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: psdev: add passive serial driver
Date: Fri, 14 Mar 2014 10:22:23 +0000
Message-ID: <20140314102223.GR366@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
 <20140312163427.GV28112@sirena.org.uk>
 <20140314101907.GF4234@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEMZpvf/LsJ++1SB"
Cc: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140314101907.GF4234-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CEMZpvf/LsJ++1SB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 11:19:07AM +0100, Michael Grzeschik wrote:

> Second, the driver has "per se" nothing to do with SPI, beside it needs
> a clock and data line to transfer an image to the FPGA. (One way,
> therefor: passive). It needs to use some SPI controller to do that. Even
> the SPI Bitbang driver. Because of this, it depends on the SPI
> framework.

Lots of drivers use SPI but they sit in the relevant frameworks rather
than in the SPI framework.

> It is actually not more than that. I took the spidev character device
> driver as reference implementation. Any Idea where to put this driver
> instead.

Like I say somewhere where it sits with other FPGA programming stuff (if
that's what it does) would be my first thought.

--CEMZpvf/LsJ++1SB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIthcAAoJELSic+t+oim9YfQP/06RiqX+Dx9a7FoZmSdoiBZn
PCDH/8AvTJPnBHqJrycQLKRifMGRyIQNGhSxvAnZhI0u2Z13oqNoLKwG+2rHWhP+
wuW3kuhKHo869HE8e8ofre5Mo2hMDHSjl7xSp3lMVNz3ymcxwMZQMnIdmcLskjGr
gNyG793+0jjrH78K7vjasoF3zmXFllM6QFm7kc4m290Bfn28y1vgMotT2/N8OZ1G
CX75IbA9b5RsgrtyhvKS1YO9pyEVRjqWZaicvmkouYOUhECh271HKJrPulRJXonD
77F4htaqPkx4KarmsXL+UJOQYMjTBeu6EEJUwFf+GcYu+QdyJPLsZ489M1qYMaS2
TjY4yTu8mPiFXHoBVbb+fUCLXSSwW3L5Mu0i6BFbQ9+nmtHZsXHHDRMtkkUGztyT
fgsJI3e//3fHht2wg6WtKznoGxXanyLVb6lOjFMXN5rqU1J0vHi0JhclFUGCj4Wm
mm0sx16nRW01eg3k7BUegSV/hBXltvvLTR6VNmX0dIL9HwYksGgJr8k9xZadJAsE
6Q/r4/5H9c81tpUaHY6BIgN/Fd/WfBdDHC8DcV8K5HE/F3MEbQup0/ePw1LtKxd5
Wz5raHAfreelghibWXI2QYbuh3rttYUA4M0NJvUpOuldtMnN5aoMBVLjVXdHtT1F
8qRlBzYLlnC3nF6eCQsC
=+VtF
-----END PGP SIGNATURE-----

--CEMZpvf/LsJ++1SB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
