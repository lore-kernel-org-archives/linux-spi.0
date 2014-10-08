From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
Date: Wed, 8 Oct 2014 11:30:27 -0500
Message-ID: <1412785827.13320.532.camel@snotra.buserror.net>
References: <20141003164916.DBD631AAFA2@localhost.localdomain>
	 <1412368198.13320.434.camel@snotra.buserror.net> <542FE1C4.7000403@c-s.fr>
	 <1412640953.13320.502.camel@snotra.buserror.net> <5435649F.5070908@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5435649F.5070908@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2014-10-08 at 18:21 +0200, leroy christophe wrote:
> Le 07/10/2014 02:15, Scott Wood a =C3=A9crit :
> > On Sat, 2014-10-04 at 14:02 +0200, christophe leroy wrote:
> >> What should it look like if that offset had to be in the device tr=
ee ?
> > If the offset is not relocatable or discoverable, it should stay in=
 the
> > device tree.  If you have an old chip you wouldn't have
> > fsl,cpm1-spi-reloc and thus you'd still have "0x3d80 0x30" in reg.
> This index is from the start of the dual port RAM. It is 0x2000 above=
=20
> the start of the CPM area.
> In the DTS, we have:
>=20
>      soc@ff000000 {
>          compatible =3D "fsl,mpc885", "fsl,pq1-soc";
>          #address-cells =3D <1>;
>          #size-cells =3D <1>;
>          device_type =3D "soc";
>          ranges =3D <0x0 0xff000000 0x28000>;
>          bus-frequency =3D <0>;
>          clock-frequency =3D <0>;
>=20
>          cpm@9c0 {
>              #address-cells =3D <1>;
>              #size-cells =3D <1>;
>              compatible =3D "fsl,mpc885-cpm", "fsl,cpm1";
>              ranges;
>              reg =3D <0x9c0 0x40>;
>              brg-frequency =3D <0>;
>              interrupts =3D <0>;    // cpm error interrupt
>              interrupt-parent =3D <&CPM_PIC>;
>=20
>              muram@2000 {
>                  #address-cells =3D <1>;
>                  #size-cells =3D <1>;
>                  ranges =3D <0x0 0x2000 0x2000>;
>=20
>                  data@0 {
>                      compatible =3D "fsl,cpm-muram-data";
>                      reg =3D <0x0 0x1c00>;
>                  };
>              };
>=20
>              spi: spi@a80 {
>                  #address-cells =3D <1>;
>                  #size-cells =3D <0>;
>                  cell-index =3D <0>;
>                  compatible =3D "fsl,spi", "fsl,cpm1-spi";
>                  reg =3D <0xa80 0x30 0x3d80 0x30>;
>                  interrupts =3D <5>;
>                  interrupt-parent =3D <&CPM_PIC>;
>                  mode =3D "cpu";
>=20
>=20
> The binding allows me to do an of_iomap() on the parameter RAM, hence=
 to=20
> get access to the relocation index which is inside it.
> But if the relocation index is 0, I have to calculate it by myself=20
> because the calling function expects it in return.
> The binding is also supposed to tell that the muram is at 0xff002000.=
=20
> But I don't know how I can get this info and use it to calculate the=20
> index of my param RAM ? I need to calculate the index which is 1d80=20
> (0x3d80 - 0x2000)

What binding are you talking about?  There is no published binding for
this yet.

As for what the driver should do, it should do an of_iomap(), but what
it does with the resulting memory depends on the compatible.  For
fsl,cpm1-spi, the result would be the parameter RAM for the device.  Fo=
r
fsl,cpm1-spi-reloc and fsl,cpm2-spi, it would be the relocation
register.  The driver would either read the contents of the register, o=
r
write a different offset.

My understanding is that the relocation register would only be zero on
the chips where we'd use fsl,cpm1-spi, not fsl,cpm1-spi-reloc.

-Scott
