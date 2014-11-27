From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
Date: Thu, 27 Nov 2014 14:55:42 +0000
Message-ID: <20141127145542.GH4628@x1>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
 <20141127130053.GW7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141127130053.GW7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 27 Nov 2014, Mark Brown wrote:

> On Thu, Nov 27, 2014 at 11:43:54AM +0000, Lee Jones wrote:
>=20
> > +Required properties:
> > +- compatible	: "st,comms-ssc-spi" or "st,comms-ssc4-spi"
>=20
> What do the two different compatible strings mean (for example, shoul=
d
> ssc4 be used for version 4 and higher or is it just a quirk for that
> version)?

This appears to be historical.  There aren't any functional
differences i.e. we don't match on them.  I believe the former is a
more informal, generic name and the latter is the official name of the
IP block.  The I2C component already upstreamed has the same naming
conventions by the looks of it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
