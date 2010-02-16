From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of: added documentation for spi chipselects
Date: Tue, 16 Feb 2010 12:00:12 -0700
Message-ID: <fa686aa41002161100j45c97bb7w1788140d3fcf981f@mail.gmail.com>
References: <20100216193957.ccdffee2.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 16, 2010 at 11:39 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>
> Added devicetree binding documentation for gpios used as chipselect. The
> code to evaluate these is already present in spi_mpc8xxx.c.
>
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Merged, thanks.


> ---
> diff -upr a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentatio=
n/powerpc/dts-bindings/fsl/spi.txt
> --- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> @@ -13,6 +13,11 @@ Required properties:
> =A0- interrupt-parent : the phandle for the interrupt controller that
> =A0 services interrupts for this device.
>
> +Optional properties:
> +- gpios : specifies the gpio pins to be used for chipselects.
> + =A0The gpios will be referred to as reg=3D<index> in the SPI child node=
s.
> + =A0If unspecified, a single SPI device without a chip select can be use=
d.
> +
> =A0Example:
> =A0 =A0 =A0 =A0spi@4c0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cell-index =3D <0>;
> @@ -21,4 +26,6 @@ Example:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <82 0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <700>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpio 18 1 =A0 =A0 // device reg=
=3D<0>, low-active
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio 19 1>; =A0 // devi=
ce reg=3D<1>, low-active
> =A0 =A0 =A0 =A0};
>
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
