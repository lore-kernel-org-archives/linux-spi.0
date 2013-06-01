From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/11] spi: omap2-mcspi: enhance pinctrl support
Date: Sat, 1 Jun 2013 20:27:26 +0100
Message-ID: <20130601192726.GS16790@sirena.org.uk>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-6-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4266163419943717960=="
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
 linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 sudhakar.raj-l0cyMroinI0@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369995191-20855-6-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============4266163419943717960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jesV4P1FjH8FXPjZ"
Content-Disposition: inline


--jesV4P1FjH8FXPjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2013 at 03:43:05PM +0530, Hebbar Gururaja wrote:
> Amend the spi omap controller to optionally take a pin control
> handle and set the state of the pins to:
>=20
> - "default" on boot, resume and before performing an spi transfer
> - "idle" after initial default, after resume default, and after each
> spi xfer
> - "sleep" on suspend()

Looking at this code I can't really see what's OMAP-specific about it -
exactly the same flow should apply to pretty much any SPI controller,
especially given that the code will happily ignore missing states.
We're just setting the idle state when not actively transferring data
which seems sensible and generic.

This suggests to me that we should be adding this code into the core,
probably joined up with the transfer_one_message stuff, so that any
hardware which has an idle state will be able to get the benefit.  Can
anyone think of a reason why we shouldn't do that?

--jesV4P1FjH8FXPjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqksbAAoJELSic+t+oim9YPkP/2Mh8qGtSUuoR0QFZSiQ4T0V
1Dw8LcOQ6mUYD9jvhF/pQDV92oLx3nTHJc/Nj0uJ4dk5gxDgVe8ubndW6xAS1ICs
GbbN5y72QjzUwi3S2EI3Ucfe0M9TlvUIRKzgdox8rBIm3BS+JSNj4r+UYu++o+7G
qvzyURyiwvje/9/BBcAo8iGlzVOq/QIvKog5lxZPZX64wXjNgINoZ4dMRU8c8FM3
dlPRkab1PpIlTUGZ9FdTUKdLwe4/NZ3TwVEQsyrU1/zcssNsW4t++ihObZpyz9nS
74VSBvbnOdqxFTUOUQ9y54uGjET8PwJ7DBK+Kx9o8/IRg00X15JCbsU2lh2ddqly
flQ9IWz5il0e9B9O9zz6bjOOQAXUWeeuf2ss9Y1CGXHHfLANLHIJPD66hvwPfwUu
2GZPEE+njNWVJK2UKXmtCXHZ6j27n6ce2vJWYm01uQgEfkwb+CO/MgGn/h4b7EdT
d9LSK4INXQXtLhrpJ2G4BovRAuz426EjGe5dDYZPwc/NEuASRNEEIKnkP7fZ4wrj
sYUVIK3aO+T+z7Mi51IGN4OFdfC0iyDOCwCvRjL1fJOl58lzA5gFOimI38mvdvq6
moZpOV4sXJ/rNIR7px23rFvA5w08DgJhzOEleHN9fSqek4jnpx10veTRhj4Oo06o
l33gdt855JQlLuOqEa7m
=IGvf
-----END PGP SIGNATURE-----

--jesV4P1FjH8FXPjZ--

--===============4266163419943717960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4266163419943717960==--
