From: <Tudor.Ambarus@microchip.com>
Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
Date: Thu, 18 Apr 2019 14:11:10 +0000
Message-ID: <dd6cc84d-7dc3-af55-9177-7930544f0dcf@microchip.com>
References: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <e1e2f867-8a28-c74b-7f01-5f798e37c81d@microchip.com>
 <MWHPR02MB2623D039832785A980B3B8EFAF400@MWHPR02MB2623.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <bbrezillon@kernel.org>, <broonie@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <nagasuresh12@gmail.com>, <dwmw2@infradead.org>,
        <michals@xilinx.com>
To: <nagasure@xilinx.com>, <liu.xiang6@zte.com.cn>, <vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR02MB2623D039832785A980B3B8EFAF400@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <411DC5CF29459A49976FEDCFCF984DA6@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi, Naga,

On 03/19/2019 03:57 PM, Naga Sureshkumar Relli wrote:
> *External E-Mail*
>=20
> *
> *
>=20
> Hi Tudor,
>=20
> =A0
>=20
>> -----Original Message-----
>=20
>> From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
>=20
>> Sent: Monday, March 18, 2019 11:05 AM
>=20
>> To: Naga Sureshkumar Relli <nagasure@xilinx.com>; bbrezillon@kernel.org;
>=20
>> broonie@kernel.org
>=20
>> Cc: richard@nod.at; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.=
org;
>=20
>> marek.vasut@gmail.com; linux-mtd@lists.infradead.org; nagasuresh12@gmail=
.com;
>=20
>> dwmw2@infradead.org; Michal Simek <michals@xilinx.com>; liu.xiang6@zte.c=
om.cn
>=20
>> Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
>=20
>>
>=20
>> Hi, Naga,
>=20
>>
>=20
>> On 03/13/2019 12:30 PM, Naga Sureshkumar Relli wrote:
>=20
>> > Hi,
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > Currently I am facing an issue with is25wp256d part.
>=20
>> >
>=20
>> >=A0 1. With u-boot the data integrity is working(erase, write, read and=
 verify)
>=20
>> >=A0=A0=A0=A0 with out any issues
>=20
>> >=A0 2. Don=92t probe the qspi at u-boot, and boot Linux and do data int=
egrity
>=20
>> >=A0=A0=A0=A0 (erase, write, read and verify) =A0and verification done s=
uccessfully.
>=20
>> >=A0 3. At u-boot, do sf probe and after booting Linux, check for data
>=20
>> > integrity
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0 (erase, write, read and verify) and verify is failing.
>=20
>> >
>=20
>> > And here are my observations.
>=20
>> >
>=20
>> > When we do sf probe at u-boot, as per the device size, u-boot is
>=20
>> > changing
>=20
>> >
>=20
>> > The flash device addressing mode from 3 byte to 4 byte
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > But Linux spi-nor frame work is using 3 byte commands with 3 Byte
>=20
>> > addressing(because
>=20
>> >
>=20
>> > Of wrong sfdp information from the is25wp256d part). Hence data verifi=
cation is failing.
>=20
>> >
>=20
>> > i.e. sfdp information is saying that it supports only 3-Byte addressin=
g.
>=20
>> >
>=20
>> > that means, sfdp table for is25wp256d is wrong.
>=20
>> >
>=20
>>
>=20
>> I couldn't find the sfdp table described in the datasheet. I would like =
to check if bfpt is not
>=20
>> entirely wrong. Can you please hexdump the entire sfdp table?
>=20
> sfdp header:
>=20
> 0x53, 0x46, 0x44, 0x50,
SFDP Header: 1st DWORD

>0x6, 0x1,0x1, 0xff,
SFDP Header: 2nd DWORD
Number of Parameter Headers (NPH)=3D2

>0x0, 0x6, 0x1, 0x10,
JEDEC Flash Parameter Header: 1st DWORD
Parameter Table length: 0x10

>0x30, 0x0, 0x0, 0xff
JEDEC Flash Parameter Header: 2nd DWORD
Parameter Table Pointer

> =A0
>=20
> Parameter table header
>=20
> 0x9d, 0x5, 0x1, 0x3, 0x80, 0x0, 0x0, 0x2

is this a vendor table?

> Parameter Table data:
>=20
dword[1]:
> 0xe5, 0x20, *0xf9*, 0xff,

indeed, A18:A17 is 00b, 3-byte only addressing. A18:A17 should have been of
value 01b.

dword[2]:
> 0xff, 0xff, 0xff, 0xf,
dword[3]:
> 0x44, 0xeb, 0x8, 0x6b,
dword[4]:
>  0x8, 0x3b, 0x80, 0xbb,
dword[5]:
> 0xfe, 0xff, 0xff, 0xff,
dword[6]:
> 0xff, 0xff,  0x0, 0xff,
dword[7]:
> 0xff, 0xff, 0x44, 0xeb,dword[8]:
>  0xc, 0x20,  0xf, 0x52,
   ^4KB erase  ^32KB erase
dword[9]:
> 0x10, 0xd8,  0x0, 0xff,
   ^64KB erase
dword[10]:
> 0x23, 0x4a, 0xc9, 0x0,
dword[11]:
> 0x82, 0xd8, 0x11, 0xce,
dword[12]:
> 0xcc, 0xcd, 0x68, 0x46,
dword[13]:
> 0x7a, 0x75, 0x7a, 0x75,
dword[14]:
> 0xf7, 0xae, 0xd5, 0x5c,
dword[15]:
> 0x4a, 0x42, 0x2c, 0xff,
dword[16]:
> 0xf0, 0x30, 0xf2, 0xa9
                     ^ xx1x_xxxxb is set, and confirms that the flash suppo=
rts
dedicated 4-Byte address instruction set.

BFPT looks sane, with the exception of the 3-byte only addressing.

You have the same problem as Liu. Check Liu's patch at
https://patchwork.ozlabs.org/patch/1071453/. Ideally would be to know if th=
ese 2
parts are the only ones that have this bug or if there are more. Can you co=
ntact
ISSI and ask them which parts are affected? If ISSI will not respond in a
reasonable amount of time, we can update Liu's patch to have a single post_=
bfpt
function that checks if the flash id corresponds to IS25(WP/LP)256D before
setting addr_width to 4.

Cheers,
ta

>> > Here are the steps that I am running.
>=20
>> >
>=20
>> > Write data using u-boot =A0like below
>=20
>> >
>=20
>> > 1. sf probe 0 0 0
>=20
>> >
>=20
>> > 2. mw.b 0x100000 11 0x100
>=20
>> >
>=20
>> > 3. sf write 0x100000 0x0 0x100
>=20
>> >
>=20
>> > 4. sf read 0x200000 0x0 0x100
>=20
>> >
>=20
>> > 5. md.b 0x200000 0x100
>=20
>> >
>=20
>> > 00200000: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200010: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200020: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200030: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200040: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200050: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200060: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200070: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200080: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200090: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > And in Linux just try reading the data,
>=20
>> >
>=20
>> > root# mtd_debug read /dev/mtd0 0x0 0x100 test.bin
>=20
>> >
>=20
>> > root#hexdump -C -n 50 test.bin
>=20
>> >
>=20
>> > 0000000 ffff ffff =A01111 1111 1111 1111 1111 1111
>=20
>> >
>=20
>> > 0000010 1111 1111 1111 1111 1111 1111 1111
>=20
>> >
>=20
>> > *
>=20
>> >
>=20
>> > 0000100
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > I did the below change in spi-nor.c
>=20
>> >
>=20
>> > iff --git a/drivers/mtd/spi-nor/spi-nor.c
>=20
>> > b/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > index 4216ce0..f8603ff 100644
>=20
>> >
>=20
>> > --- a/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > +++ b/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > @@ -2890,6 +2890,11 @@ static int spi_nor_init_params(struct spi_nor
>=20
>> > *nor,
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
nor->addr_width =3D 0;
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
nor->mtd.erasesize =3D 0;
>=20
>> >
>=20
>> > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 ((JEDEC_MFR(info) =3D=3D SNOR_MFR_ISSI) &&
>=20
>> Does all issi flashes have this problem?
>=20
> No.
>=20
>>
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 params->size >=A0 OFFSET_16_MB) {
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 nor->addr_width =3D 4;
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 set_4byte(nor, info, 1);
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
memcpy(params, &sfdp_params, sizeof(*params));
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > Any further suggestions?
>=20
>>
>=20
>> We should implement this as a post_bfpt fixup hook.
>=20
> Ok
>=20
>>
>=20
>> >
>=20
>> > I have gone through https://lkml.org/lkml/2018/11/14/599.
>=20
>> >
>=20
>> > But I didn=92t see any further mails after that.
>=20
>>
>=20
>> Sorry, I forgot about it :(
>=20
> No problem and thanks for asking more information.
>=20
> =A0
>=20
> Thanks,
>=20
> Naga Sureshkumar Relli
>=20
>>
>=20
>> Cheers,
>=20
>> ta
>=20
