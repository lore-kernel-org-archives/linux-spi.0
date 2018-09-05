From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
Date: Wed, 5 Sep 2018 10:07:10 +0000
Message-ID: <VI1PR04MB1038CE65EF4E98ACBEA9990B99020@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180904165842.774ed960@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904165842.774ed960@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, September 4, 2018 8:29 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI contr=
oller
>=20
> Hi Yogesh,
>=20
> On Fri, 31 Aug 2018 16:00:00 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > - Add a driver for NXP FlexSPI host controller
> >
> > (0) What is the FlexSPI controller?
> >  FlexSPI is a flexsible SPI host controller which supports two SPI
> > channels and up to 4 external devices.
> >  Each channel supports Single/Dual/Quad/Octal mode data  transfer
> > (1/2/4/8 bidirectional data lines)  i.e. FlexSPI acts as an interface
> > to external devices,  maximum 4, each with up to 8 bidirectional data
> > lines.
> >
> >  It uses new SPI memory interface of the SPI framework to issue flash
> > memory operations to up to four connected flash chips (2 buses with
> >  2 CS each).
> >  Chipselect for each flash can be selected as per address assigned in
> > controller specific registers.
> >
> >  FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
> > controller with advanced features.
>=20
> Yep, I had a quick look at the code and they really look similar. Why not
> extending the existing driver instead of creating a new one from scratch?
>=20

FlexSPI is different controller not related to the QuadSPI controller in it=
s working behavior
Both these controller are having
* Different registers name, registers address, registers functionality etc,=
 section 30.5.2[1]
* Different programming sequence for initialization of the controller, sect=
ion 30.8.1[1]
* Different programming sequence for performing Read and Write operation us=
ing IP, section 30.7.9[1] and AHB mode
* Different programming sequence for checking controller current state like=
 busy or not=20
* New mechanism to program for the connected slave device i.e. flash access=
 mode and flash memory map 30.7.4[1] and 30.7.5[1]
* New entries added for FlexSPI controller for LUT_XX mode for various comm=
ands, section 30.7.8[1]

There are few similarities between these two like LUT programming logic is =
same
i.e. LUT needs to be programmed in same sequence of 'INSTR  PAD  OPCODE', b=
ut again LUT register address and LUT command mode values are different.

Creating common driver for both FlexSPI and QuadSPI controller, would invol=
ve creation of one more layer between driver/spi/spi-xxx and the actual con=
troller driver, this layer would going to have less functionality like doin=
g LUT creation programming and then would re-direct calls to the respective=
 controller driver functionality to perform desired programming sequence.

> >
> > (1) The FlexSPI controller is driven by the LUT(Look-up Table)
> > registers.
> >  The LUT registers are a look-up-table for sequences of instructions.
> >  A valid sequence consists of four LUT registers.
> >  Maximum 32 LUT sequences can be programmed simultaneously.
> >
> > (2) The definition of the LUT register shows below:
> >  ---------------------------------------------------
> >  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> >  ---------------------------------------------------
> >
> >  There are several types of INSTRx, such as:
> >  CMD     : the SPI NOR command.
> >  ADDR    : the address for the SPI NOR command.
> >  DUMMY   : the dummy cycles needed by the SPI NOR command.
> >  ....
> >
> >  There are several types of PADx, such as:
> >  PAD1    : use a singe I/O line.
> >  PAD2    : use two I/O lines.
> >  PAD4    : use quad I/O lines.
> >  PAD8    : use octal I/O lines.
> >  ....
> >
> > (3) LUTs are being created at run-time based on the commands passed
> > from the spi-mem framework. Thus, using single LUT index.
> >
> > (4) Software triggered Flash read/write access by IP Bus.
> >
> > (5) Memory mapped read access by AHB Bus.
>=20
> Do we really want to have this level of details in the commit message?
> I mean, this is something you can document in the driver, but not here.
>=20
> BTW, you might want to have a look at [1]. I think we can get rid of the =
->size
> field you're adding if this driver implements the dirmap hooks.
>=20

I need size information for the connected device to program the controller =
register FLSHXXCRO as Flash Chip select is determined by flash access addre=
ss and Flash size setting in register FLSHXXCR0[FLSHz], section 30.7.9[1].

Link for reference of the driver implementing dirmap hooks was missing in m=
ail, please share.

> >
> > (6) Tested this driver with the mtd_debug and JFFS2 filesystem utility
> > on NXP LX2160ARDB and LX2160AQDS targets.
> >  LX2160ARDB is having two NOR slave device connected on single bus A
> > i.e. A0 and A1 (CS0 and CS1).
> >  LX2160AQDS is having two NOR slave device connected on separate buses
> > one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >  Verified this driver on following SPI NOR flashes:
> >     Micron, mt35xu512ab, [Read - 1 bit mode]
> >     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
>=20
> Ok, that's good to have in the commit message.
>=20
> >
> > - Add config option entry in 'spi-nor/Kconfig' for FlexSPI driver.
>=20
> But this one is useless. If you add a new driver, you have no other choic=
e but to
> add a new entry in the Kconfig file.
>=20
> >
> > - Add entry in the 'spi-nor/Makefile'.
> >
>=20
> Ditto.
>=20
> Before you re-send a new version, I'd like to understand why you think yo=
u need
> to create a new driver, and I want you to try to implement the dirmap hoo=
k and
> check if you can get rid of the ->size field when doing that.
>=20
> I also seem one extra benefit to having a single driver for both FlexSPI =
and
> QuadSPI IPs: you'll help Frieder debug the last remaining problems you re=
ported
> on the new QuadSPI driver :-P.

Regarding testing of the QuadSPI driver on spi-mem framework, I have alread=
y given suggestions to the Frieder and my local changes using which flash c=
onnected at CS0 and CS1 starts working for read/write/erase commands on ls1=
088ardb target.

Current v2 which has been shared, data operation for the slave flash device=
 connected at CS1 is not working.
I have to make changes for the calculation of flash base address for the re=
quested chip select and changes in address remapping the buffer in AHB read=
 case for CS1 access to work.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf

--
Regards
Yogesh Gaur

>=20
> Thanks,
>=20
> Boris
