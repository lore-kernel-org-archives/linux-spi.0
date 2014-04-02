From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Always check complete callback before calling it
Date: Wed, 2 Apr 2014 20:30:55 +0100
Message-ID: <20140402193055.GF14763@sirena.org.uk>
References: <1396448464.8891.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Cc: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396448464.8891.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2014 at 10:21:04PM +0800, Axel Lin wrote:
> Since commit 1e25cd4729bd "spi: Do not require a completion", this checking is
> required to prevent NULL pointer dereference.

Applied, thanks.

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPGVsAAoJELSic+t+oim94C4P/itncs0ncw0NIRJSoHQiBvtx
QYjmRyCsfUBFqvDtnCQZ2RmYxH4X0WlW4xUDj1IWmHDwu1Cn3MoZQGj+GOYSmkdD
4YbTjrhQpSm0nKK6bsH0m4KI3KFUOkMFS62CF7UqSFNMpEpyP4gImuGJ5bulSwKk
fQLBEyeqX3UNShX7cjH46YN4b6hHNZ5i0JyoLrrwVvXSCyAtHk7D0Bx38ENOhDhm
094ZlvGrWAYZ178NPuiqv0WRVaCttIvfoOpWSuPSWCoWH0KXdDtijFmOVeXRW6jb
38dW7IyTuiWGbXkYTGl4Ok8nf8pZhTeyVeYzrmKcVH7QyIbQpuWCgSchhzVayBff
QohwyuKcrkud5F8HiYPrHWb6SOR6n9GI1g/x23IUpY0o74oBx86BhPslW9uayoEm
5LJKuAICINRDbY6Q+6VP0RMaJG/bPEv/VmofMLgqeNdtpB6JIMQM6V9Elmfx5pqk
vtjiFbA6kT6WQrzwoFeSf7CIgvLX48a/X8ZtpMXZPlF6BP45ufafzy7EHfX6/9vp
WhdASjhT1QrPrr6YSkCPnhCSJRZyHtqZ0p3yisaoFSkCSNecWFEh315HC0pC3xCM
glFjv0fhpolIujILE9bjQCZOZ7b/iRZVMTNU6YkgLJPrLC90KFHmS0ulb6O0Agxu
XSILWf7RlBo2PN7OTO2x
=cIci
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
