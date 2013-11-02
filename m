From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 2/3] i2c: Use stable dev_name for ACPI enumerated I2C
 slaves
Date: Sat, 2 Nov 2013 01:15:33 +0100
Message-ID: <20131102001533.GB2633@katana>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383309356-25430-3-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 02:35:55PM +0200, Jarkko Nikula wrote:
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


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSdEQlAAoJEBQN5MwUoCm29boP/iSQ7kOx/lPxOUtB6owqtJB9
5Rb4lNSRvZpY1fCMGmhOgPqja6+zL7W/AKWdn0oERXZwbiG88cVoE6Gwu1FKQjWm
XJqczleIOE4j4HGE88VdDViZn2M5zdlliMR2csSyR7S84TsO8K3XrfJHsesigKAs
NkzrznipksfjpaEp0htggJMqqD5Z2Lb/eAPUglFtZBRVCkMHgUAmTwfb9XIUfFzE
vH3pNWx5ghJL//gDlW9qsglyiX3d7cDhUSaNe0mPh71N3BJ7HIOt40qZFjoSg7X2
Btc9C1lZicR1YyRp42xCPp1YGAsqrOFW6qipqhup05nfkvqVK5aQYpSd8OHoo3e7
gx1M8gyRy8DlfDhRWXa6MYDtP0I/T3HjA9Rm38vR7rKcPlcmmDXzZ8ofIOl6ODVM
RrZPwfVHJYQMy2hRkfiNuDo2BY5WvoCFl0eEE19wDQocjcAk2VnvMiXZGzt92kzs
pXrJruzBf5W5LQzF3aPvnnbEzNZRiAxD+K3zSvZLmKde4TZKw71slIjLOrjB0G91
fAhYtdCZrLZ60fFcqVRqSqzOEK74EWqTJX+u4oj+Ifbgf4FBSjL+nEXhYscP8uRo
qHwCyS6uVO0TBZWvbeBbTeEE/TFWRdtU4aPFIzCtu9ofy8jM7Hgg1FgszDgqA2Nf
4E4uZjBYwL8n5MhB7ixT
=7Vkr
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
