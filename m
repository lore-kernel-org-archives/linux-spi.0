From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 26 Jun 2018 14:26:30 +0200
Message-ID: <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "richard@nod.at" <richard@nod.at>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 Han Xu <han.xu@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Andy,

On 08.06.2018 22:27, Andy Shevchenko wrote:
> On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com> wrote:
> 
> Hi Frieder,
> 
>> +#define QUADSPI_MCR_RESERVED_MASK      (0xF << 16)
> 
> GENMASK()

Ok.

> 
>> +#define QUADSPI_MCR_END_CFG_MASK       (0x3 << 2)
> 
>> +#define QUADSPI_BUF3CR_ADATSZ_MASK     (0xFF << QUADSPI_BUF3CR_ADATSZ_SHIFT)
> 
>> +#define QUADSPI_SMPR_DDRSMP_MASK       (7 << 16)
> 
>> +#define QUADSPI_RBCT_WMRK_MASK         0x1F
> 
> Ditto.

Ok.

> 
>> +#define QUADSPI_LUT_OFFSET             (SEQID_LUT * 4 * 4)
>> +#define QUADSPI_LUT_REG(idx)           (QUADSPI_LUT_BASE + \
>> +                                       QUADSPI_LUT_OFFSET + (idx) * 4)
> 
> It looks slightly better when
> 
> #define FOO \
>   (BAR1 + BAR2 ...)

Ok.

> 
>> +/*
>> + * An IC bug makes it necessary to rearrange the 32-bit data.
>> + * Later chips, such as IMX6SLX, have fixed this bug.
>> + */
>> +static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a) {
>> +       return needs_swap_endian(q) ? __swab32(a) : a; }
> 
> func()
> {
> ...
> }
> 
> Fix this everywhere.

I will fix this.

> 
> 
> 
>> +static void qspi_writel(struct fsl_qspi *q, u32 val, void __iomem
>> +*addr) {
>> +       if (q->big_endian)
>> +               iowrite32be(val, addr);
>> +       else
>> +               iowrite32(val, addr);
>> +}
>> +
>> +static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr) {
>> +       if (q->big_endian)
>> +               return ioread32be(addr);
>> +       else
>> +               return ioread32(addr);
>> +}
> 
> Better to define ->read() and ->write() callbacks and call them unconditionally.

Ok.

> 
>> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {
> 
>> +       switch (width) {
>> +       case 1:
>> +       case 2:
>> +       case 4:
>> +               return 0;
>> +       }
> 
> 
> if (!is_power_of_2(width) || width >= 8)
>   return -E...;
> 
> return 0;
> 
> ?

Your proposition is a bit shorter, but I think it's slightly harder to read.

> 
>> +
>> +       return -ENOTSUPP;
>> +}
> 
>> +static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q) {
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(q->clk_en);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_prepare_enable(q->clk);
>> +       if (ret) {
> 
>> +               clk_disable_unprepare(q->clk_en);
> 
> Is it needed here?

No, this is probably superfluous. I will remove it.

> 
>> +               return ret;
>> +       }
>> +
>> +       if (needs_wakeup_wait_mode(q))
>> +               pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
>> +
>> +       return 0;
>> +}
> 
>> +               qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> 
> Redundant parens.

Ok, I thought this is better for readability.

> 
> 
> 
>> +       seq = seq ? 0 : 1;
> 
> seq = (seq + 1) % 2;
> 
> ?

Ok.

> 
>> +}
> 
>> +       for (i = 0; i < op->data.nbytes; i += 4) {
>> +               u32 val = 0;
>> +
>> +               memcpy(&val, op->data.buf.out + i,
> 
>> +                      min_t(unsigned int, op->data.nbytes - i, 4));
> 
> You may easily avoid this conditional on each iteration.

Do you mean something like this, or are there better ways?

u32 val = 0;

for (i = 0; i < ALIGN_DOWN(op->data.nbytes, 4); i += 4)
{
	memcpy(&val, op->data.buf.out + i, 4);
	val = fsl_qspi_endian_xchg(q, val);
	qspi_writel(q, val, base + QUADSPI_TBDR);
}

memcpy(&val, op->data.buf.out + i, op->data.nbytes);
val = fsl_qspi_endian_xchg(q, val);
qspi_writel(q, val, base + QUADSPI_TBDR);

> 
>> +
>> +               val = fsl_qspi_endian_xchg(q, val);
>> +               qspi_writel(q, val, base + QUADSPI_TBDR);
>> +       }
> 
>> +       /* wait for the controller being ready */
> 
> FOREVER! See below.
> 
>> +       do {
>> +               u32 status;
>> +
>> +               status = qspi_readl(q, base + QUADSPI_SR);
>> +               if (status &
>> +                   (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
>> +                       udelay(1);
>> +                       dev_dbg(q->dev, "The controller is busy, 0x%x\n",
>> +                               status);
>> +                       continue;
>> +               }
>> +               break;
>> +       } while (1);
> 
> Please, avoid infinite loops.
> 
> unsigned int count = 100;
> ...
> do {
> ...
> } while (--count);

Ok, will change that.

> 
>> +       if (of_get_available_child_count(q->dev->of_node) == 1)
>> +               name = dev_name(q->dev);
>> +       else
>> +               name = devm_kasprintf(dev, GFP_KERNEL,
>> +                                     "%s-%d", dev_name(q->dev),
>> +                                     mem->spi->chip_select);
>> +
>> +       if (!name) {
>> +               dev_err(dev, "failed to get memory for custom flash name\n");
> 
>> +               return dev_name(q->dev);
> 
> Might it be racy if in between device gets a name assigned?

Ok, I will change that to make sure that dev_name() is only called once.

> 
>> +       }
> 
>> +       if (q->ahb_addr)
>> +               iounmap(q->ahb_addr);
> 
> Double unmap?

Right, this is redundant. I will remove it.

> 
>> +static struct platform_driver fsl_qspi_driver = {
>> +       .driver = {
>> +               .name   = "fsl-quadspi",
>> +               .of_match_table = fsl_qspi_dt_ids,
>> +       },
>> +       .probe          = fsl_qspi_probe,
>> +       .remove         = fsl_qspi_remove,
> 
>> +       .suspend        = fsl_qspi_suspend,
>> +       .resume         = fsl_qspi_resume,
> 
> Why not in struct dev_pm_ops?

This was taken from the original driver. I will add a struct dev_pm_ops 
to hold fsl_qspi_suspend() and fsl_qspi_resume().

> 
>> +};
> 
> 
>> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
>> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
>> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");
> 
> Wrong indentation.

What is wrong? Some newlines are missing here between the MODULE_ 
macros, but in my original patch it seems correct.

Thank you for your review,

Frieder

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
