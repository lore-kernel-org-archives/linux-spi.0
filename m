From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] of: added documentation for spi chipselects
Date: Tue, 16 Feb 2010 21:14:59 +0100
Message-ID: <20100216201459.GA17428@pengutronix.de>
References: <20100216193957.ccdffee2.eschwab@online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8978198028554060750=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100216193957.ccdffee2.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
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


--===============8978198028554060750==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2010 at 07:39:57PM +0100, Ernst Schwab wrote:
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>=20
> Added devicetree binding documentation for gpios used as chipselect. The
> code to evaluate these is already present in spi_mpc8xxx.c.
>=20
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
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
> +  The gpios will be referred to as reg=3D<index> in the SPI child nodes.
> +  If unspecified, a single SPI device without a chip select can be used.

Minor: I'd prefer spaces around the '=3D'.

> +
>  Example:
>  	spi@4c0 {
>  		cell-index =3D <0>;
> @@ -21,4 +26,6 @@ Example:
>  		interrupts =3D <82 0>;
>  		interrupt-parent =3D <700>;
>  		mode =3D "cpu";
> +		gpios =3D <&gpio 18 1	// device reg=3D<0>, low-active
> +			 &gpio 19 1>;	// device reg=3D<1>, low-active

I'd drop the comments. GPIO controllers may have private xlate-functions, so
'1' could theoretically mean something else than "low-active" (although in
practice it hopefully won't).

>  	};
>=20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkt6/MMACgkQD27XaX1/VRssDQCfVnAy5zowoJyY+1gVjQSPtfEF
w6sAnROre2A4KhwGGRlsvQe7vRHoMeph
=woy4
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============8978198028554060750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8978198028554060750==--
