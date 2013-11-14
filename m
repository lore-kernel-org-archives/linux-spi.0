From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv4 2/3] i2c: Use stable dev_name for ACPI enumerated I2C
 slaves
Date: Thu, 14 Nov 2013 18:22:48 +0100
Message-ID: <20131114172248.GD11022@katana>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384430633-23426-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384430633-23426-3-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2013 at 02:03:52PM +0200, Jarkko Nikula wrote:
> Current I2C adapter id - client address "x-00yy" based device naming sche=
me
> is not always stable enough to be used in name based matching, for instan=
ce
> within ALSA SoC subsystem.
>=20
> This is problematic in PC kind of platforms where I2C adapter numbers can
> change due variable amount of bus controllers, probe order, add-on cards =
or
> just because of BIOS settings.
>=20
> This patch addresses the problem by using the ACPI device name with
> "i2c-" prefix for ACPI enumerated I2C slaves. For them device name
> "x-00yz" becomes "i2c-INTABCD:ij" after this patch.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShQboAAoJEBQN5MwUoCm29Q8P/AjYhiVSPIaUVG5QnJjFqj22
IgFGUHSzXnqs9AiPrPkub1IxsuNL0EzXBOidS2C21GsX4PRXbuheaGYuEfPAbBBJ
/jTogVmd7wwn7UtQ1IaJLr/hUCl0S5Db0kdVStPt7AuOqljfrK+9qEAYQ1oV2VDp
rmPg9OKsKXGDethhnW1TKSRjCECXNm6ll+zof9pNAQnwPVpXtIzZofwmWq/x0s/c
3amFA2Kb6PQ+KToXjOTNmSncCjaP8A4c/GtufiF5BfZU2RmaK5n+l40fmsWNGmuL
9Kn0Y0givkxn6dURndq5y8WsyYgf6URkT1/mpfv4ccdY5aYMJboGMEM3OdI8JVNu
1nOfjT8KzPzWCpA4c5+DXMj5xqxKSvBBlgFj2gJvrG4KxbqXdPmp6FC5FgZUUBeo
yYZt+aPEamuwnZNixxFFc0EqkNKIWJ3idbZM1bmrvGPLVfD9T/V5JO/hccORZuVM
gsvr6swKUALEu28xDPsfKn3gj1qSsGXt+01FQcPoAMF69NVxS8BC1WNr78JXhjZ9
8StP4S4MJYnrzFhk3/bQBcHto36Lp+sJNzeb7CGa4hXR73NXdw5/lfOjSK+kf+OU
OavPIeLYVOBtrd+GggkE8TrbO9TJiEJ9nFP0/NWocFrejvbAmP86Cj/rEZNRCL9S
tH9JDHxOg2WviCE8zbRE
=uH9z
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
