From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/fsl-espi: Add Power Management support for eSPI
 controller
Date: Thu, 12 Dec 2013 11:56:37 +0000
Message-ID: <20131212115637.GA5367@sirena.org.uk>
References: <1386824032-19198-1-git-send-email-b48286@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386824032-19198-1-git-send-email-b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2013 at 12:53:52PM +0800, Hou Zhiqiang wrote:
> Add PM support for eSPI controller using callback function suspend
> and resume in .driver.pm of platform_driver.

Applied, thanks.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqaRyAAoJELSic+t+oim9P+gP/1stgYXOpSesza6URhgW++k4
qJlqYRIHr5xi20likZ6rbFX+Yib3PG3/E5gvHW0iWbzfIyezBFG4UP4iV+VkJ/0v
vymNVMowXa0NbS6XbQZZuFdRMeXCUpJVCqrTzfDgF7gpv3ZS+j3jHgmjUjPBr8Ce
3VeQ4pO0SsNuButdiW67rt0vJ6dbYU10TfcnIkpK00xcmWcDgs65SJz7MjsOWxY8
ZOYd/l9PPuCIVDFnCrI2qt0t04+EqW9lDfSOvbx+Sc8W/8GtU00kkQEdXMbGHQFT
xjNPrjIg9TGwIZO1WAn8A7m/TYVb4+AhgrD1X9vOgVT+PDax7uhZ8ZoNDWv6LuGW
i8Hx2LIzhLFOHWRFG8aOuE89suADBPXlWCOpiSXSGtk0mmQCl7BCYjZ17SDPJD3j
gfqwSoOQqt2qspYXJZH3TwvL+cKNbhGLXK18P3t5kQql8cQR16d/EV109meMfz8g
g6nDbTXuSXVu31hE9lPiAreKuryaTD4Hzpip+R4UzXFxgLdDXil+el2fhKOpWnJr
evzOra9SAoSurUYBi3NlHRyjQH1kARNOorkthPj9htCdklt5FJKaGyFS3NpC0XHd
bH1keV8qXb+lKb2NFahRZxt4t1tBQKKsIPSvh6RzvHT873auWiQ5cLOEgTwsSC71
rxLdIvg3qgsLvpFqCXJT
=l6kK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
