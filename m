From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of: add bus-number specification to spi_mpc8xxx
Date: Tue, 16 Feb 2010 08:18:02 -0700
Message-ID: <fa686aa41002160718u36fe6f7ey7be83ab69317ec76@mail.gmail.com>
References: <20100216150850.d966cd79.eschwab@online.de>
	<fa686aa41002160628g62bd6564h50e712e8fb9c384d@mail.gmail.com>
	<20100216160832.730cb00b.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100216160832.730cb00b.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
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

[cc'd spi-devel-generial too]

On Tue, Feb 16, 2010 at 8:08 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>
>> No, unless you can provide a really compelling reason to do so, the
>> goal is to *not* specify Linux implementation detail things like bus
>> numbers in the device tree.
>>
>> Instead, your code should be using spi device child nodes from the
>> bus, or finding the spi bus node and decoding the dynamically assigned
>> bus number from there. =A0Don't hard code spi bus numbers.
>
> Ok, I understand that no operating system specific stuff should be
> specified in the device tree. But: the bus numbers may be specified
> by the hardware design or the used microcontroller, and I think
> there should be a way to propagate the bus name/number present in
> the hardware design to the operating system. Maybe by adding a
> 'label' property, or by parsing the node name?

Add a property to the /chosen node to assign short labels to devices.

> Documentation/spi/spi-summary tells us to use fixed numbers for SOC
> systems, but unfortunately, we have no method to specify them with
> the device tree:

That document predates SPI device tree bindings, and assumes that
platform data structures will be used to populate SPI busses.
Platform data structures require fixed numbers to line up data with
bus instances.  That problem doesn't exist when using the device tree.

Unless you're trying to line up disparate data structure, the actually
number assigned to a bus really doesn't matter.  It is better to let
Linux dynamically assign than to manually maintain the assigned bus
numbers for each machine.  Assuming dynamic assignment also protects
against breaking userspace applications when, for whatever reason, the
bus numbers get shuffled on a platform.

g.

>
> "
> Bus numbering is important, since that's how Linux identifies a given
> SPI bus (shared SCK, MOSI, MISO). =A0Valid bus numbers start at zero. =A0=
On
> SOC systems, the bus numbers should match the numbers defined by the chip
> manufacturer. =A0For example, hardware controller SPI2 would be bus numbe=
r 2,
> and spi_board_info for devices connected to it would use that number.
>
> If you don't have such hardware-assigned bus number, and for some reason
> you can't just assign them, then provide a negative bus number. =A0That w=
ill
> then be replaced by a dynamically assigned number. You'd then need to tre=
at
> this as a non-static configuration (see above).
> "
>
> Ernst
>
> P.S:
> Unfortunately, the proposed patch wasn't sent to the mailing list by mist=
ake,
> so here it is again for reference.
>
> ---
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>
> Added devicetree parsing for SPI bus number. If no bus number is specifie=
d,
> a dynamically assigned bus number will be used (typically 32766).
>
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
> ---
> diff -upr a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentatio=
n/powerpc/dts-bindings/fsl/spi.txt
> --- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> @@ -4,6 +4,8 @@ Required properties:
> =A0- cell-index : SPI controller index.
> =A0- compatible : should be "fsl,spi".
> =A0- mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
> +- bus-number : number of the SPI bus. If unspecified, a dynamically
> + =A0assigned bus number will be used.
> =A0- reg : Offset and length of the register set for the device
> =A0- interrupts : <a b> where a is the interrupt number and b is a
> =A0 field that represents an encoding of the sense and level
> @@ -21,4 +23,5 @@ Example:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <82 0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <700>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-number =3D <0>;
> =A0 =A0 =A0 =A0};
> diff -upr a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -1230,6 +1230,8 @@ static int __devinit of_mpc8xxx_spi_prob
> =A0 =A0 =A0 =A0struct resource mem;
> =A0 =A0 =A0 =A0struct resource irq;
> =A0 =A0 =A0 =A0const void *prop;
> + =A0 =A0 =A0 const int *bus_num;
> + =A0 =A0 =A0 int len;
> =A0 =A0 =A0 =A0int ret =3D -ENOMEM;
>
> =A0 =A0 =A0 =A0pinfo =3D kzalloc(sizeof(*pinfo), GFP_KERNEL);
> @@ -1239,8 +1241,16 @@ static int __devinit of_mpc8xxx_spi_prob
> =A0 =A0 =A0 =A0pdata =3D &pinfo->pdata;
> =A0 =A0 =A0 =A0dev->platform_data =3D pdata;
>
> - =A0 =A0 =A0 /* Allocate bus num dynamically. */
> - =A0 =A0 =A0 pdata->bus_num =3D -1;
> +
> + =A0 =A0 =A0 bus_num =3D of_get_property(np, "bus-number", &len);
> + =A0 =A0 =A0 if (bus_num && len =3D=3D sizeof(*bus_num)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* bus number is specified in node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bus_num =3D *bus_num;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allocate bus num dynamically. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bus_num =3D -1;
> + =A0 =A0 =A0 }
> +
>
> =A0 =A0 =A0 =A0/* SPI controller is either clocked from QE or SoC clock. =
*/
> =A0 =A0 =A0 =A0pdata->sysclk =3D get_brgfreq();
>
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
