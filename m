From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Mon, 8 Oct 2018 11:21:13 +0000
Message-ID: <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180929174023.51b1e284@bbrezillon>
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
In-Reply-To: <20180929174023.51b1e284@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Saturday, September 29, 2018 9:10 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> Hi Yogesh,
>=20
> On Fri, 21 Sep 2018 15:51:59 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > +/* Registers used by the driver */
> > +#define FSPI_MCR0			0x00
> > +#define FSPI_MCR0_AHB_TIMEOUT_SHIFT	24
> > +#define FSPI_MCR0_AHB_TIMEOUT_MASK	(0xFF <<
> FSPI_MCR0_AHB_TIMEOUT_SHIFT)
> > +#define FSPI_MCR0_IP_TIMEOUT_SHIFT	16
> > +#define FSPI_MCR0_IP_TIMEOUT_MASK	(0xFF <<
> FSPI_MCR0_IP_TIMEOUT_SHIFT)
> > +#define FSPI_MCR0_LEARN_EN_SHIFT	15
> > +#define FSPI_MCR0_LEARN_EN_MASK		(1 <<
> FSPI_MCR0_LEARN_EN_SHIFT)
> > +#define FSPI_MCR0_SCRFRUN_EN_SHIFT	14
> > +#define FSPI_MCR0_SCRFRUN_EN_MASK	(1 <<
> FSPI_MCR0_SCRFRUN_EN_SHIFT)
> > +#define FSPI_MCR0_OCTCOMB_EN_SHIFT	13
> > +#define FSPI_MCR0_OCTCOMB_EN_MASK	(1 <<
> FSPI_MCR0_OCTCOMB_EN_SHIFT)
> > +#define FSPI_MCR0_DOZE_EN_SHIFT		12
> > +#define FSPI_MCR0_DOZE_EN_MASK		(1 <<
> FSPI_MCR0_DOZE_EN_SHIFT)
> > +#define FSPI_MCR0_HSEN_SHIFT		11
> > +#define FSPI_MCR0_HSEN_MASK		(1 << FSPI_MCR0_HSEN_SHIFT)
> > +#define FSPI_MCR0_SERCLKDIV_SHIFT	8
> > +#define FSPI_MCR0_SERCLKDIV_MASK	(7 <<
> FSPI_MCR0_SERCLKDIV_SHIFT)
> > +#define FSPI_MCR0_ATDF_EN_SHIFT		7
> > +#define FSPI_MCR0_ATDF_EN_MASK		(1 <<
> FSPI_MCR0_ATDF_EN_SHIFT)
> > +#define FSPI_MCR0_ARDF_EN_SHIFT		6
> > +#define FSPI_MCR0_ARDF_EN_MASK		(1 <<
> FSPI_MCR0_ARDF_EN_SHIFT)
> > +#define FSPI_MCR0_RXCLKSRC_SHIFT	4
> > +#define FSPI_MCR0_RXCLKSRC_MASK		(3 <<
> FSPI_MCR0_RXCLKSRC_SHIFT)
> > +#define FSPI_MCR0_END_CFG_SHIFT		2
> > +#define FSPI_MCR0_END_CFG_MASK		(3 <<
> FSPI_MCR0_END_CFG_SHIFT)
> > +#define FSPI_MCR0_MDIS_SHIFT		1
> > +#define FSPI_MCR0_MDIS_MASK		(1 << FSPI_MCR0_MDIS_SHIFT)
> > +#define FSPI_MCR0_SWRST_SHIFT		0
> > +#define FSPI_MCR0_SWRST_MASK		(1 <<
> FSPI_MCR0_SWRST_SHIFT)
>=20
> Do we really need all those _SHIFT/_MASK defs? I mean
>=20

Changes done in next version of the patch series, v4 [1].

> #define FSPI_MCR0_SWRST		BIT(0)
>=20
> or
>=20
> #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> #define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
>=20
> are just fine.
>=20
> > +
> > +enum nxp_fspi_devtype {
> > +	NXP_FSPI_LX2160A,
> > +};
>=20
> I'm pretty sure you don't need this enum if you describe all dev caps in =
the
> nxp_fspi_devtype_data struct.

Done, in v4.

>=20
> > +
> > +struct nxp_fspi_devtype_data {
> > +	enum nxp_fspi_devtype devtype;
> > +	unsigned int rxfifo;
> > +	unsigned int txfifo;
> > +	unsigned int ahb_buf_size;
> > +	unsigned int quirks;
> > +	bool endianness;
>=20
> How about renaming this variable big_endian and dropping the {L,B}_ENDIAN
> macros?
>=20
Done in v4, default make as little_endian to reduce indirect branch checkin=
g.

> > +};
>=20
> [...]
>=20
> > +struct nxp_fspi {
> > +	void __iomem *iobase;
> > +	void __iomem *ahb_addr;
> > +	u32 memmap_phy;
> > +	u32 memmap_phy_size;
> > +	struct clk *clk, *clk_en;
> > +	struct device *dev;
> > +	struct completion c;
> > +	const struct nxp_fspi_devtype_data *devtype_data;
> > +	struct mutex lock;
> > +	struct pm_qos_request pm_qos_req;
> > +	int selected;
> > +	void (*write)(u32 val, void __iomem *addr);
> > +	u32 (*read)(void __iomem *addr);
> > +};
> > +
> > +static void fspi_writel_be(u32 val, void __iomem *addr) {
> > +	iowrite32be(val, addr);
> > +}
> > +
> > +static void fspi_writel(u32 val, void __iomem *addr) {
> > +	iowrite32(val, addr);
> > +}
> > +
> > +static u32 fspi_readl_be(void __iomem *addr) {
> > +	return ioread32be(addr);
> > +}
> > +
> > +static u32 fspi_readl(void __iomem *addr) {
> > +	return ioread32(addr);
> > +}
>=20
> Hm, I'd recommend dropping the ->read/write() hooks and providing the
> following functions:
>=20
> static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr) =
{
> 	if (f->big_endian)
> 		iowrite32be(val, addr);
> 	else
> 		iowrite32(val, addr);
> }
>=20
>=20
> static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> 	if (f->big_endian)
> 		return ioread32be(addr);
> 	else
> 		return ioread32(addr);
> }
>=20
> > +
> > +static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id) {
> > +	struct nxp_fspi *f =3D dev_id;
> > +	u32 reg;
> > +
> > +	/* clear interrupt */
> > +	reg =3D f->read(f->iobase + FSPI_INTR);
> > +	f->write(FSPI_INTR_IPCMDDONE_MASK, f->iobase + FSPI_INTR);
> > +
> > +	if (reg & FSPI_INTR_IPCMDDONE_MASK)
> > +		complete(&f->c);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> [...]
>=20
> > +/*
> > + * If the slave device content being changed by Write/Erase, need to
> > + * invalidate the AHB buffer. This can be achieved by doing the reset
> > + * of controller after setting MCR0[SWRESET] bit.
> > + */
> > +static inline void nxp_fspi_invalid(struct nxp_fspi *f) {
> > +	u32 reg;
> > +
> > +	reg =3D f->read(f->iobase + FSPI_MCR0);
> > +	f->write(reg | FSPI_MCR0_SWRST_MASK, f->iobase + FSPI_MCR0);
> > +
> > +	while (f->read(f->iobase + FSPI_MCR0) & FSPI_MCR0_SWRST_MASK)
> > +		;
>=20
> Did you consider using readl_poll_timeout[_atomic]()?
>=20
> 	if (f->big_endian)
> 		mask =3D (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
> 	else
> 		mask =3D (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
>=20
> 	ret =3D readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
> 				 reg & mask, 0, FSPI_SWRST_TIMEOUT);
> 	WARN_ON(ret);
>=20
> > +}
>=20
Thanks, added readl_poll_timeout() functionality instead of busy looping.

> [...]
>=20
> > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct
> > +spi_mem_op *op) {
> > +	u32 len =3D op->data.nbytes;
> > +
> > +	/* Read out the data directly from the AHB buffer. */
> > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
>=20
> Don't know if it's supported, but if it is, I recommend using DMA to do t=
his copy,
> because otherwise you might stall the CPU for quite a long time if the fl=
ash is
> operating in a low-speed mode, and RT maintainers will complain about tha=
t at
> some point ;-).
>=20
Read using DMA is not supported by the controller in AHB mode, only support=
ed in IP mode.
Have to use memcpy_fromio() calls. Maximum data size can be read in single =
call is 0x800 using AHB read.

--
Regards
Yogesh Gaur.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D69535

> > +}
> > +
> > +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base =3D f->iobase;
> > +	int i, j;
> > +	int size, tmp_size, wm_size;
> > +	u32 data =3D 0;
> > +	u32 *txbuf =3D (u32 *) op->data.buf.out;
> > +
> > +	/* clear the TX FIFO. */
> > +	f->write(FSPI_IPTXFCR_CLR_MASK, base + FSPI_IPTXFCR);
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size =3D 8;
> > +	size =3D op->data.nbytes / wm_size;
> > +	for (i =3D 0; i < size; i++) {
> > +		/* Wait for TXFIFO empty */
> > +		while (!(f->read(base + FSPI_INTR) & FSPI_INTR_IPTXWE_MASK))
> > +			;
>=20
> Use readl_poll_timeout(), or even better, provide an helper
> (fspi_readl_poll_timeout()?) that hides the BE/LE stuff, so that you can =
reuse it
> when this pattern occurs.
>=20
> [...]
>=20
> > +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> > +spi_mem_op *op) {
> > +	struct nxp_fspi *f =3D spi_controller_get_devdata(mem->spi->master);
> > +	void __iomem *base =3D f->iobase;
> > +	int err =3D 0;
> > +	unsigned int timeout =3D 1000;
> > +
> > +	mutex_lock(&f->lock);
> > +
> > +	/* wait for the controller being ready */
> > +	do {
> > +		u32 status;
> > +
> > +		status =3D f->read(base + FSPI_STS0);
> > +		if ((status & FSPI_STS0_ARB_IDLE_MASK) &&
> > +		    (status & FSPI_STS0_SEQ_IDLE_MASK))
> > +			break;
> > +		udelay(1);
> > +		dev_dbg(f->dev, "The controller is busy, 0x%x\n", status);
>=20
> Same here.
>=20
> Note that I didn't spend time looking at how the IP works, which explains=
 why I
> focus on tiny details here. Unfortunately, I won't have time to review th=
e driver
> in more details, so I'll leave that to someone else, or let Mark decides =
if he's
> happy enough with the current version.
>=20
> Regards,
>=20
> Boris
