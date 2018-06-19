From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 19 Jun 2018 08:31:25 +0000
Message-ID: <DB6PR0402MB2838FAF5CF0B0883EFAA3A9B99700@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615155541.4f43e9bb@bbrezillon>
        <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180618211536.0bf44f55@bbrezillon>
        <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
 <20180619092832.3b6c8f22@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619092832.3b6c8f22@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, June 19, 2018 12:59 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>;
> broonie@kernel.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; David Wolfe
> <david.wolfe@nxp.com>; dwmw2@infradead.org; richard@nod.at; Prabhakar
> Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu <han.xu@nxp.com>; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
> mtd@lists.infradead.org; miquel.raynal@bootlin.com;
> computersforpeace@gmail.com
> Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSP=
I
> controller
>=20
> Hi Yogesh,
>=20
> Could you please use a mailer that is quoting things correctly. I have a =
hard time
> differentiating your replies from mine.

Sorry for this, have changed my mailer settings.

>=20
> On Tue, 19 Jun 2018 07:10:37 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Let us take below layout of memory address space map.
> > QuadSPI Controller can access range from 0x2000_0000 - 0x2FFF_FFFF i.e.=
 256
> MB address space reserved and it is having 4 slave devices connected.
> > These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are connected
> > at below address 0x2000_0000, 0x2400_0000, 0x2A00_0000, 0x2C00_0000
> > i.e. there is gap of 32MB from 0x2800_0000 to 0x29FF_FFFF.
>=20
> Okay, I'm fine with pre-reserving 32MB per chip select.
>=20
> >
> > As per my understanding of the controller, flash XX top address, regist=
er should
> have below values:
> >   QUADSPI_SFA1AD - 0x0
> >   QUADSPI_SFA2AD - 0x400_0000
> >   QUADSPI_SFB1AD - 0xA00_0000
> >   QUADSPI_SFB2AD - 0xC00_0000
> > And Register QUADSPI_SFAR should point to the range for the flash in wh=
ich
> operation is happening.

My mistake values of these register would be for said case are:
QUADSPI_SFA1AD - 0x400_0000
QUADSPI_SFA2AD - 0x800_0000
QUADSPI_SFB1AD - 0xC00_0000
QUADSPI_SFB2AD - 0x1000_0000

i.e. as per controller each register is having the Top address for serial f=
lash connected at A1/A2/B1/B2 respectively.

>=20
> Wait, I thought it was supposed to be an absolute address, not one relati=
ve to
> the 0x20000000 offset.
>=20
> >
> > Please check Table10-32, page 1657, in [1] for more details on flash ad=
dress
> assignment.
>=20
> Yes, I still don't see where it says that having one of the range with a =
zero size is
> forbidden, or anything mentioning a required alignment.
>=20
> >
> > But say if I assign address to register QUADSPI_SFA2AD as "0 + 2 * -
> >ahb_buf_size" then this address value is not correct as per the value ra=
nge
> explained in above mentioned table.
>=20
> Why? If the SFA1AD is set to zero, that should not, right?
What this table says that for TOP_ADDR_MEMA1 defines the top address for fl=
ash connected at A1 and any address space between TOP_ADDR_MEMA1 and QSPI_A=
MBA_BASE will be routed to Serial Flash A1.
In my example case TOP_ADDR_MEMA1 is 0x400_0000
If assign value to SFAR register is "0 + 2 * ->ahb_buf_size", then this wou=
ld lie in access range of Serial Flash A1 and access happens to A1 flash wh=
ereas we want access to A2 flash.

For access of serial flash A2, any address space access between TOP_ADDR_ME=
MA2 and TOP_ADDR_MEMA1 would be routed to serial flash A2.
Thus to access A2 flash, SFAR would be in range from 0x400_0000 and 0x800_0=
000

--
Regards
Yogesh Gaur
