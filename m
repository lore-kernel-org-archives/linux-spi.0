From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Thu, 16 Jan 2014 20:24:40 +0100
Message-ID: <20140116192440.GA4127@katana>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
 <20140116122819.GO15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140116122819.GO15567-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 12:28:19PM +0000, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 04:46:37PM +0800, Zhang Rui wrote:
> > ACPI enumerated devices has ACPI style _HID and _CID strings,
> > all of these strings can be used for both driver loading and matching.
> >=20
> > Currently, in Platform, I2C and SPI bus, the ACPI style driver matching
> > is supported by invoking acpi_driver_match_device() in bus .match() cal=
lback.
> > But, the module autoloading is still broken.
>=20
> Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> modulo the PAGE_SIZE stuff Mika noted - unless this changes radically
> please just assume I'm OK with it.

Ditto

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS2DH4AAoJEBQN5MwUoCm2zsIP/iesTC0J7+9BH9yhobIeHxaG
SSxm8jK+938hUgdZcTuZwS5+HKxWNzydkK7vop0xRDjIAHBs+WX6nDrKiq7WDQJ1
H74j/z4T2T5l/3TeAu26/DtoN25wjU3T0NYpKkx6Dw6+02V+LZ5a1i+VWFfsYfcG
uiTjBR6wHvIMnZ31CpU9gf1NZ/9NueIkXQxGKfDNucJZLltL4V9DNyCIhzCcR0an
R3C/mG9iiYMbIgb3RNcZZObxerB1sADQL/srEoLHZ/+fMmhT1M4sIZ26B1I0dP6m
OxuxAFfQ1xr+uKUBDxlqWX9CyMs9wWaQosQliMB8FKttLUrL5Cpica8WB3aTFl2M
TwwV30DzDDNXbGyJ4n7MDqD2Zu5rTqMkdduLMvOq/siQlw9PbeKvH9w0k8bdKd2y
iYrcLJv9wGDT73fGj4PMXlNQQ0H5u3JTAH4cg/upWzYH14E5lWouZc0ecrospFHv
/3MndevF7eoXfao8D574QNVsMqNkcZanZb5HTuWhTPL/V0E345uv4hvLuqBjSA+n
BqIoyH/YjmWzv1dpoimBI0NaR+g9rCs4DrJSg0+JYwRdXLlxzJkNKOWZ5XcDxpah
KQi0++0gGviIS5UOeCEoLyTyMr9zwsTKjcjIH5wI1RpOkYsMqvt9hjuPkg7Tu4LN
zM+uGCgxM7hBg8AogV7A
=Mp55
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
