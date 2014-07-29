From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
Date: Tue, 29 Jul 2014 19:55:29 +0100
Message-ID: <20140729185529.GG17528@sirena.org.uk>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
 <20140725053230.GT1857@lahna.fi.intel.com>
 <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nOmHLaPfT8qBXnP"
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2nOmHLaPfT8qBXnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 06:13:06PM +0200, Andrea Adami wrote:

> note that a previous version of the patch breaks spi on pxa machines:
> tested on pxa250 poodle and pxa255 corgi.
> The patch is included in linux-Yocto since 3.14.

The interesting question is if this version works...

--2nOmHLaPfT8qBXnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1+4eAAoJELSic+t+oim9S5IP/jAaQN7VwVpQdUASIZ0FSriR
KHUqozON8uhXNUojcpy4PbLiXe5q0xyVYkv2Cucm+s0DDXl8xBOOVgg56LjLBgdZ
HM/zuGRJ3ziRm4XeemPRm8F+YTBm4cYz1wzgJDCWjiGa8xM96u0OVKztIGKdMLbF
lDqO1rFSOs3TCIPG74MPKiVTlyj5lkf6djU0Ced48ScLFeHYYNsGMJSVi2rS8MTo
UMdhlZInLpmYZ6X0rVXZH9yNZ0/AS9UKUuq/48rQidW3xiiYLm0FiaZEHKV2v4mU
btbQlD+kBCltyfMeZi6Ne4x3OpIgPZpSawSM6Fx75xDxx+6OweI5TIbuZ5TxzbrY
B2N2LblzHA4vL14Y6zVFKVPLUvqGMXjsG1rWafvUGFQcV8drUeLWRextVzD7Aur4
E667hUMQLLSWt8bnO6OKFOSD1869ZkIUgoG4BhOI1FlX8Oms2ZcUpUbJaJ0e/Iph
1KQCpDuQU6gP3gNe6QDJ7CJZq/80FxfYXHGgBHVQtWH9KhnL2+wft2vuBrF+dSxl
QENDFJpl+JTAzE3MlBt7AlaRNMd/2pvGGY5X7ApiAaE+4j3ZLcVUsRv8g4Rn0wDb
WwhXKFMUrAEN7kPRV+1TlndRgPU9vA24DVpibDhG1w0/f5qTjculpIqSOvmMAw8o
l7CeaMXCVDJXwO6/S7HU
=H/Cm
-----END PGP SIGNATURE-----

--2nOmHLaPfT8qBXnP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
