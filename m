From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] of: added documentation for spi chipselects
Date: Wed, 17 Feb 2010 14:41:38 +0100
Message-ID: <20100217134138.GC26125@pengutronix.de>
References: <20100216193957.ccdffee2.eschwab@online.de>
	<20100216201459.GA17428@pengutronix.de>
	<20100217132322.76cea805.eschwab@online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8596913833278886721=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100217132322.76cea805.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============8596913833278886721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2010 at 01:23:22PM +0100, Ernst Schwab wrote:
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>=20
> Added devicetree binding documentation for gpios used as chipselect. The
> code to evaluate these is already present in spi_mpc8xxx.c.
>=20
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Hmm, as Grant merged the original patch already, it might be necessary to
convert this into a follow-up patch. He will surely tell you. For both
versions, you can add my

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

=2E..

> ---
> diff -upr a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentatio=
n/powerpc/dts-bindings/fsl/spi.txt
> --- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> @@ -13,6 +13,11 @@ Required properties:
>  - interrupt-parent : the phandle for the interrupt controller that
>    services interrupts for this device.
> =20
> +Optional properties:
> +- gpios : specifies the gpio pins to be used for chipselects.=20

=2E..and perhaps remove the trailing white space here.

> +  The gpios will be referred to as reg =3D <index> in the SPI child node=
s.
> +  If unspecified, a single SPI device without a chip select can be used.
> +
>  Example:
>  	spi@4c0 {
>  		cell-index =3D <0>;
> @@ -21,4 +26,6 @@ Example:
>  		interrupts =3D <82 0>;
>  		interrupt-parent =3D <700>;
>  		mode =3D "cpu";
> +		gpios =3D <&gpio 18 1	// device reg =3D <0>
> +			 &gpio 19 1>;	// device reg =3D <1>
>  	};
>=20
>=20
>=20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkt78hIACgkQD27XaX1/VRvGkACgphDLBpX4WLu/cApZ+Vvm4slK
tXsAoJaiSDt//kUBUCw8MDPEHXaJs6Hl
=nHi3
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--===============8596913833278886721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8596913833278886721==--
