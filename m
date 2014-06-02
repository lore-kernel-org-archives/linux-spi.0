From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/pxa2xx-pci: Add common clock framework support
 in PCI glue layer
Date: Mon, 2 Jun 2014 13:46:38 +0100
Message-ID: <20140602124638.GD31751@sirena.org.uk>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
 <1401738379-4107-2-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401738379-4107-2-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 03:46:18AM +0800, Chew Chiau Ee wrote:

> ---
>  drivers/spi/spi-pxa2xx-pci.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)

> +	clk = clk_register_fixed_rate(&dev->dev, "spi_pxa2xx_clk", NULL,
> +					CLK_IS_ROOT, c->max_clk_rate);
> +	 if (IS_ERR(clk))
> +		return PTR_ERR(clk);

This is pretty much fine code wise but I'd expect to see some Kconfig
updates adding dependencies on the clock API - clk_register_fixed_rate()
is only provided if the fixed rate driver is present.  I'm also not
seeing any changes to unregister the fixed rate clock as the device is
removed.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjHIrAAoJELSic+t+oim9/7EP/1Pbt4XAJ5TpW6TYrXPk+sMS
NZftP4t9eQPYSH46P8RRpqilmZ2dFOQZwKoDgmAFVt/tKJx34Vdmr5ZUE0FVn+TV
ud/YKjTN6fvDd38ESKstpKpYE8Qg/oAWosoLsAWGRj+2smU1k6ezQVLM69Q1D3y5
2gP0QR3XQw7MGYZ9k1BXVCjvTZbSdyHCqVJ8/hvjpJ2MZAfSqmvIeiHFF2weCnea
ty9jis54P5HqCjnL76UpnruiJKZNB7+ZmfajuHCBJxfgiOGqYlsfIihH1I6aunYo
t6l66UUdQjamjEsBlyWkFRBS6HgjIuOiCAb7QUGzFyK/yhAsWe5zgM59eCNSjBiH
NgChnAml7Phl2gPisMg0Rl5CfzB4fA1zd3aq9FsZ+7FL3GsReJAlQCOWYNGe5LBK
nmd47AcgIndDTgeNPGQImraspBSxnYs4dC1UgBY2s3OLvvhZV+E3sNWmtIkPvYvE
huKeIh9Ey8RqJjFR+TVn2K+EEfJm20QSQeD5et2SLKxMQ/suSUKdFvgoB+sB2JKX
reGSMxsQc97iWA4r2VlOljWsYe0nze+umBvgpT0dTug+yzHdpsMHUhWEEwoGQ6sL
YVYvmpuK7jvYuZfzX12w4Oct3zk2dMziECg0Tz5/gBWSagUBL3MWYm7PZR8JLo+X
ZWhJtknrJDlTIYDdMEX0
=/dfd
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
