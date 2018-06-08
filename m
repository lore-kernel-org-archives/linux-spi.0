From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
Date: Fri, 8 Jun 2018 23:27:14 +0300
Message-ID: <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de> <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
<yogeshnarayan.gaur@nxp.com> wrote:

Hi Frieder,

> +#define QUADSPI_MCR_RESERVED_MASK      (0xF << 16)

GENMASK()

> +#define QUADSPI_MCR_END_CFG_MASK       (0x3 << 2)

> +#define QUADSPI_BUF3CR_ADATSZ_MASK     (0xFF << QUADSPI_BUF3CR_ADATSZ_SHIFT)

> +#define QUADSPI_SMPR_DDRSMP_MASK       (7 << 16)

> +#define QUADSPI_RBCT_WMRK_MASK         0x1F

Ditto.

> +#define QUADSPI_LUT_OFFSET             (SEQID_LUT * 4 * 4)
> +#define QUADSPI_LUT_REG(idx)           (QUADSPI_LUT_BASE + \
> +                                       QUADSPI_LUT_OFFSET + (idx) * 4)

It looks slightly better when

#define FOO \
 (BAR1 + BAR2 ...)

> +/*
> + * An IC bug makes it necessary to rearrange the 32-bit data.
> + * Later chips, such as IMX6SLX, have fixed this bug.
> + */
> +static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a) {
> +       return needs_swap_endian(q) ? __swab32(a) : a; }

func()
{
...
}

Fix this everywhere.



> +static void qspi_writel(struct fsl_qspi *q, u32 val, void __iomem
> +*addr) {
> +       if (q->big_endian)
> +               iowrite32be(val, addr);
> +       else
> +               iowrite32(val, addr);
> +}
> +
> +static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr) {
> +       if (q->big_endian)
> +               return ioread32be(addr);
> +       else
> +               return ioread32(addr);
> +}

Better to define ->read() and ->write() callbacks and call them unconditionally.

> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {

> +       switch (width) {
> +       case 1:
> +       case 2:
> +       case 4:
> +               return 0;
> +       }


if (!is_power_of_2(width) || width >= 8)
 return -E...;

return 0;

?

> +
> +       return -ENOTSUPP;
> +}

> +static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q) {
> +       int ret;
> +
> +       ret = clk_prepare_enable(q->clk_en);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(q->clk);
> +       if (ret) {

> +               clk_disable_unprepare(q->clk_en);

Is it needed here?

> +               return ret;
> +       }
> +
> +       if (needs_wakeup_wait_mode(q))
> +               pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
> +
> +       return 0;
> +}

> +               qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));

Redundant parens.



> +       seq = seq ? 0 : 1;

seq = (seq + 1) % 2;

?

> +}

> +       for (i = 0; i < op->data.nbytes; i += 4) {
> +               u32 val = 0;
> +
> +               memcpy(&val, op->data.buf.out + i,

> +                      min_t(unsigned int, op->data.nbytes - i, 4));

You may easily avoid this conditional on each iteration.

> +
> +               val = fsl_qspi_endian_xchg(q, val);
> +               qspi_writel(q, val, base + QUADSPI_TBDR);
> +       }

> +       /* wait for the controller being ready */

FOREVER! See below.

> +       do {
> +               u32 status;
> +
> +               status = qspi_readl(q, base + QUADSPI_SR);
> +               if (status &
> +                   (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
> +                       udelay(1);
> +                       dev_dbg(q->dev, "The controller is busy, 0x%x\n",
> +                               status);
> +                       continue;
> +               }
> +               break;
> +       } while (1);

Please, avoid infinite loops.

unsigned int count = 100;
...
do {
...
} while (--count);

> +       if (of_get_available_child_count(q->dev->of_node) == 1)
> +               name = dev_name(q->dev);
> +       else
> +               name = devm_kasprintf(dev, GFP_KERNEL,
> +                                     "%s-%d", dev_name(q->dev),
> +                                     mem->spi->chip_select);
> +
> +       if (!name) {
> +               dev_err(dev, "failed to get memory for custom flash name\n");

> +               return dev_name(q->dev);

Might it be racy if in between device gets a name assigned?

> +       }

> +       if (q->ahb_addr)
> +               iounmap(q->ahb_addr);

Double unmap?

> +static struct platform_driver fsl_qspi_driver = {
> +       .driver = {
> +               .name   = "fsl-quadspi",
> +               .of_match_table = fsl_qspi_dt_ids,
> +       },
> +       .probe          = fsl_qspi_probe,
> +       .remove         = fsl_qspi_remove,

> +       .suspend        = fsl_qspi_suspend,
> +       .resume         = fsl_qspi_resume,

Why not in struct dev_pm_ops?

> +};


> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");

Wrong indentation.

-- 
With Best Regards,
Andy Shevchenko
