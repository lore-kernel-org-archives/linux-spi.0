From: <Tudor.Ambarus@microchip.com>
Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
Date: Mon, 18 Mar 2019 05:34:38 +0000
Message-ID: <e1e2f867-8a28-c74b-7f01-5f798e37c81d@microchip.com>
References: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <nagasuresh12@gmail.com>,
        <dwmw2@infradead.org>, <michals@xilinx.com>,
        <liu.xiang6@zte.com.cn>
To: <nagasure@xilinx.com>, <bbrezillon@kernel.org>,
        <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <1E5CEF06750F3A46B3B3EBB9B732392A@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi, Naga,

On 03/13/2019 12:30 PM, Naga Sureshkumar Relli wrote:
> Hi,
>=20
> =A0
>=20
> Currently I am facing an issue with is25wp256d part.
>=20
>  1. With u-boot the data integrity is working(erase, write, read and veri=
fy)
>     with out any issues
>  2. Don=92t probe the qspi at u-boot, and boot Linux and do data integrit=
y
>     (erase, write, read and verify) =A0and verification done successfully=
.
>  3. At u-boot, do sf probe and after booting Linux, check for data integr=
ity
>=20
> =A0=A0=A0=A0=A0 (erase, write, read and verify) and verify is failing.
>=20
> And here are my observations.
>=20
> When we do sf probe at u-boot, as per the device size, u-boot is changing
>=20
> The flash device addressing mode from 3 byte to 4 byte
>=20
> =A0
>=20
> But Linux spi-nor frame work is using 3 byte commands with 3 Byte address=
ing(because
>=20
> Of wrong sfdp information from the is25wp256d part). Hence data verificat=
ion is failing.
>=20
> i.e. sfdp information is saying that it supports only 3-Byte addressing.
>=20
> that means, sfdp table for is25wp256d is wrong.
>=20

I couldn't find the sfdp table described in the datasheet. I would like to =
check
if bfpt is not entirely wrong. Can you please hexdump the entire sfdp table=
?

> =A0
>=20
> Here are the steps that I am running.
>=20
> Write data using u-boot =A0like below
>=20
> 1. sf probe 0 0 0
>=20
> 2. mw.b 0x100000 11 0x100
>=20
> 3. sf write 0x100000 0x0 0x100
>=20
> 4. sf read 0x200000 0x0 0x100
>=20
> 5. md.b 0x200000 0x100
>=20
> 00200000: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200010: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200020: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200030: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200040: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200050: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200060: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200070: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200080: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200090: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> And in Linux just try reading the data,
>=20
> root# mtd_debug read /dev/mtd0 0x0 0x100 test.bin
>=20
> root#hexdump -C -n 50 test.bin
>=20
> 0000000 ffff ffff =A01111 1111 1111 1111 1111 1111
>=20
> 0000010 1111 1111 1111 1111 1111 1111 1111
>=20
> *
>=20
> 0000100
>=20
> =A0
>=20
> I did the below change in spi-nor.c
>=20
> iff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>=20
> index 4216ce0..f8603ff 100644
>=20
> --- a/drivers/mtd/spi-nor/spi-nor.c
>=20
> +++ b/drivers/mtd/spi-nor/spi-nor.c
>=20
> @@ -2890,6 +2890,11 @@ static int spi_nor_init_params(struct spi_nor *nor=
,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor=
->addr_width =3D 0;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor=
->mtd.erasesize =3D 0;
>=20
> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((=
JEDEC_MFR(info) =3D=3D SNOR_MFR_ISSI) &&
Does all issi flashes have this problem?

>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 params->size >=A0 OFFSET_16_MB) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 nor->addr_width =3D 4;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 set_4byte(nor, info, 1);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mem=
cpy(params, &sfdp_params, sizeof(*params));
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0=A0=A0=A0=A0=A0=A0 }
>=20
> Any further suggestions?

We should implement this as a post_bfpt fixup hook.

>=20
> I have gone through https://lkml.org/lkml/2018/11/14/599.
>=20
> But I didn=92t see any further mails after that.

Sorry, I forgot about it :(

Cheers,
ta
