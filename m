From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Fri, 17 Jan 2014 15:57:08 +0000
Message-ID: <20140117155708.GS17314@sirena.org.uk>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
 <20140116122704.GD2617@katana>
 <1389877509.3010.15.camel@rzhang1-mobl4>
 <20140116194651.GO17314@sirena.org.uk>
 <52D8DDD4.10704@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmeoGP/RI+eIV+cU"
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52D8DDD4.10704-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--ZmeoGP/RI+eIV+cU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2014 at 09:37:56AM +0200, Jarkko Nikula wrote:
> On 01/16/2014 09:46 PM, Mark Brown wrote:

> >This is needed for ACPI because we rewrite the device names to give us
> >stable names.  With OF for I2C and SPI nothing bus specific is done that
> >affects this stuff so the default behaviour works.

> Sidenote: actually this modalias/module loading issue is different
> and not related to stable ACPI i2c/spi slave device names.

Oh, I'd been under the impression that it was the rewrite that was
triggering this?

--ZmeoGP/RI+eIV+cU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2VLQAAoJELSic+t+oim9/IoP/jwV9eQlcNzANS8xR3W2qTzP
F44eYYTUYbgUffFQkSi1KrJZrCgn6x9/tqBj8+fwUMuahcIy+PIQX4GoPvvcpSh7
6lZZF6av22aPhecIkYN+NA/MdDS1WB8EJzWULruq8G7nCpiywTcZRkQDk295m/oR
cFMCpYq0PbqqXPrLWbsL+cCPuA4wv4vYwVHyIPTj5DKc66nFl6TOXOJxeL4V3ZMR
sdaYUudgn4YOxxVSeb6wS72EehecyXaP0ufOCgTyMpUzx7DF4icmhqkBrrfzuGqC
4R6Tojn+SJlZG9AN8iLFpsXyizGS2tnViPewN7ilgletimPelAnPisdwHI7ujPUp
mUbp8pSVW0DEJ6omD6tZo/UECfaWFpmlgJga+t+nzr6sq/KMcycxC2hl3f7HdSFI
Dzt8VZd4TAfA586nDTwJUaRsmLYv7oNJYeth+y0TodUWXLHmA7K6jbiJ0U1xp3r6
V9+zFnz3DFo0lFu35i3Cn7BZlmg3BVdz/aSFv+8jCHiNSamkQ47OrZNW96BTjLEh
5XZdm102m/l7of3WUV0UHxUkAk3kI7KkA3JzFvtOw0kEIi4hX2OVmIvvt7ucexhT
kPeiUXjbTXcnVXe9VdNk3+W4PL/c8pZd7vSveUeaoU6BhR2gqcJKVp+Vgavl6EsY
mxuJhPk0NehTlEiyVzjo
=FIsn
-----END PGP SIGNATURE-----

--ZmeoGP/RI+eIV+cU--
