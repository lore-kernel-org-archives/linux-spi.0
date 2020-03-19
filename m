From: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v12 2/4] mtd: spi-nor: add spi-mem support in
 cadence-quadspi controller driver
Date: Thu, 19 Mar 2020 08:09:48 +0000
Message-ID: <3360641.Vn3sISamPi@192.168.0.120>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <marex-ynQEQJNshbs@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <tudor.ambarus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, <richard-/L3Ra7n9ekc@public.gmane.org>,
        <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        <david.oberhollenzer-S6VGOU4v5edDinCvNWH78Q@public.gmane.org>
To: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310015213.1734-3-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Content-ID: <25199907B81B19458032A2FCEAFA74F2-Hry67jCOGbCcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tuesday, March 10, 2020 3:52:11 AM EET Ramuthevar, Vadivel MuruganX wrot=
e:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> From: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> This patch adds a spi-mem framework adaptation over cadence-quadspi drive=
r.

you need to specify on which versions of the controller you tested this.

>=20
> Signed-off-by: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> Signed-off-by: Vignesh
> Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 538
> +++++++++++++--------------------- 1 file changed, 209 insertions(+), 329
> deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c
> b/drivers/mtd/spi-nor/cadence-quadspi.c index 494dcab4aaaa..7b52e109036e
> 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -3,6 +3,8 @@

cut

>  struct cqspi_st {
> @@ -70,23 +66,20 @@ struct cqspi_st {
>         void __iomem            *ahb_base;
>         resource_size_t         ahb_size;
>         struct completion       transfer_complete;
> -       struct mutex            bus_mutex;

are we now supporting just a single flash on the bus? Does=20
CQSPI_MAX_CHIPSELECT make sense anymore?

>=20
>         struct dma_chan         *rx_chan;
>         struct completion       rx_dma_complete;
>         dma_addr_t              mmap_phys_base;
>=20
>         int                     current_cs;
> -       int                     current_page_size;
> -       int                     current_erase_size;
> -       int                     current_addr_width;
> -       unsigned long           master_ref_clk_hz;
>         bool                    is_decoded_cs;
> +       unsigned long           master_ref_clk_hz;

don't do changes for free, keep it were it was.

>         u32                     fifo_depth;
>         u32                     fifo_width;
>         bool                    rclk_en;
>         u32                     trigger_address;
>         u32                     wr_delay;
> +       bool                    use_dac_mode;
>         struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  };

cut

> -static int cqspi_read_setup(struct spi_nor *nor)
> +static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
> +                           const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
>         unsigned int dummy_clk =3D 0;
>         unsigned int reg;
>=20
> -       reg =3D nor->read_opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> -       reg |=3D cqspi_calc_rdreg(nor);
> +       reg =3D op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> +       reg |=3D cqspi_calc_rdreg(f_pdata);
>=20
>         /* Setup dummy clock cycles */
> -       dummy_clk =3D nor->read_dummy;
> +       dummy_clk =3D op->dummy.nbytes * 8;
>         if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
>                 dummy_clk =3D CQSPI_DUMMY_CLKS_MAX;
>=20
> -       if (dummy_clk / 8) {
> -               reg |=3D (1 << CQSPI_REG_RD_INSTR_MODE_EN_LSB);
> -               /* Set mode bits high to ensure chip doesn't enter XIP */
> -               writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
> -
> -               /* Need to subtract the mode byte (8 clocks). */
> -               if (f_pdata->inst_width !=3D CQSPI_INST_TYPE_QUAD)
> -                       dummy_clk -=3D 8;
> -
> -               if (dummy_clk)
> -                       reg |=3D (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MA=
SK)
> -                              << CQSPI_REG_RD_INSTR_DUMMY_LSB;
> -       }
> +       if (dummy_clk / 8)
> +               reg |=3D (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
> +                      << CQSPI_REG_RD_INSTR_DUMMY_LSB;

nit: we usually keep the operator on the first line

>=20
>         writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>=20
>         /* Set address width */
>         reg =3D readl(reg_base + CQSPI_REG_SIZE);
>         reg &=3D ~CQSPI_REG_SIZE_ADDRESS_MASK;
> -       reg |=3D (nor->addr_width - 1);
> +       reg |=3D (op->addr.nbytes - 1);
>         writel(reg, reg_base + CQSPI_REG_SIZE);
>         return 0;
>  }
>=20
> -static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
> -                                      loff_t from_addr, const size_t n_r=
x)
> +static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata=
,
> +                                      u8 *rxbuf, loff_t from_addr,
> +                                      const size_t n_rx)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       struct device *dev =3D &cqspi->pdev->dev;
>         void __iomem *reg_base =3D cqspi->iobase;
>         void __iomem *ahb_base =3D cqspi->ahb_base;
>         unsigned int remaining =3D n_rx;
> @@ -528,13 +508,13 @@ static int cqspi_indirect_read_execute(struct spi_n=
or
> *nor, u8 *rxbuf,
>=20
>         while (remaining > 0) {
>                 if (!wait_for_completion_timeout(&cqspi->transfer_complet=
e,
> -                               msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
> +                                              =20
> msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS))) ret =3D -ETIMEDOUT;

nit: unrelated change. You can fix all the checkpatch warnings in the drive=
r=20
at the beginning of the series in one dedicated patch, if you care of cours=
e,=20
but don't do it here.

cut

> -static int cqspi_of_get_pdata(struct platform_device *pdev)
> +static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> -       struct cqspi_st *cqspi =3D platform_get_drvdata(pdev);
> -
> -       cqspi->is_decoded_cs =3D of_property_read_bool(np,
> "cdns,is-decoded-cs"); +       struct device *dev =3D &cqspi->pdev->dev;

you dropped the reading of this property, but you kept the is_decoded_cs=20
member, shouldn't you drop the latter too? I guess this deserves a dedicate=
d=20
patch.

cut

>=20
> -static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> +static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  {
>         dma_cap_mask_t mask;
>=20
> @@ -1211,131 +1126,82 @@ static void cqspi_request_mmap_dma(struct cqspi_=
st
> *cqspi)
>=20
>         cqspi->rx_chan =3D dma_request_chan_by_mask(&mask);
>         if (IS_ERR(cqspi->rx_chan)) {
> -               dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +               int ret =3D PTR_ERR(cqspi->rx_chan);
> +
> +               if (ret =3D=3D -EPROBE_DEFER)
> +                       dev_err(&cqspi->pdev->dev, "No Rx DMA available\n=
");
> cqspi->rx_chan =3D NULL;

why do you print this just on defer?

> +
> +               return ret;

not initializing completion on errors needs a dedicated patch

>         }
>         init_completion(&cqspi->rx_dma_complete);
> +
> +       return 0;
>  }

cut

>=20
>  static int cqspi_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> +       const struct cqspi_driver_platdata *ddata;
> +       struct reset_control *rstc, *rstc_ocp;
>         struct device *dev =3D &pdev->dev;
> +       struct spi_master *master;
> +       struct resource *res_ahb;
>         struct cqspi_st *cqspi;
>         struct resource *res;
> -       struct resource *res_ahb;
> -       struct reset_control *rstc, *rstc_ocp;
> -       const struct cqspi_driver_platdata *ddata;
>         int ret;
>         int irq;
>=20
> -       cqspi =3D devm_kzalloc(dev, sizeof(*cqspi), GFP_KERNEL);
> -       if (!cqspi)
> +       master =3D spi_alloc_master(&pdev->dev, sizeof(*cqspi));
> +       if (!master) {
> +               dev_err(&pdev->dev, "spi_alloc_master failed\n");
>                 return -ENOMEM;
> +       }

don't forget to free the master on following errors

> +       master->mode_bits =3D SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;
> +       master->mem_ops =3D &cqspi_mem_ops;
> +       master->dev.of_node =3D pdev->dev.of_node;
> +
> +       cqspi =3D spi_master_get_devdata(master);
>=20
> -       mutex_init(&cqspi->bus_mutex);
>         cqspi->pdev =3D pdev;
> -       platform_set_drvdata(pdev, cqspi);
>=20
>         /* Obtain configuration from OF. */
> -       ret =3D cqspi_of_get_pdata(pdev);
> +       ret =3D cqspi_of_get_pdata(cqspi);
>         if (ret) {
>                 dev_err(dev, "Cannot get mandatory OF data.\n");
>                 return -ENODEV;
> @@ -1390,13 +1256,13 @@ static int cqspi_probe(struct platform_device *pd=
ev)
> rstc =3D devm_reset_control_get_optional_exclusive(dev, "qspi"); if
> (IS_ERR(rstc)) {
>                 dev_err(dev, "Cannot get QSPI reset.\n");
> -               return PTR_ERR(rstc);
> +               goto probe_reset_failed;
>         }
>=20
>         rstc_ocp =3D devm_reset_control_get_optional_exclusive(dev,
> "qspi-ocp"); if (IS_ERR(rstc_ocp)) {
>                 dev_err(dev, "Cannot get QSPI OCP reset.\n");
> -               return PTR_ERR(rstc_ocp);
> +               goto probe_reset_failed;

these 2 goto statements need a dedicated patch.

>         }
>=20
>         reset_control_assert(rstc);
> @@ -1407,15 +1273,21 @@ static int cqspi_probe(struct platform_device *pd=
ev)
>=20
>         cqspi->master_ref_clk_hz =3D clk_get_rate(cqspi->clk);
>         ddata  =3D of_device_get_match_data(dev);
> -       if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
> -               cqspi->wr_delay =3D 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> -                                                =20
> cqspi->master_ref_clk_hz); +       if (ddata) {
> +               if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
> +                       cqspi->wr_delay =3D 5 * DIV_ROUND_UP(NSEC_PER_SEC=
,
> +                                               cqspi->master_ref_clk_hz)=
;
> +               if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
> +                       master->mode_bits |=3D SPI_RX_OCTAL;
> +               if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
> +                       cqspi->use_dac_mode =3D true;
> +       }
>=20
>         ret =3D devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>                                pdev->name, cqspi);
>         if (ret) {
>                 dev_err(dev, "Cannot request IRQ.\n");
> -               goto probe_irq_failed;
> +               goto probe_reset_failed;
>         }
>=20
>         cqspi_wait_idle(cqspi);
> @@ -1423,16 +1295,28 @@ static int cqspi_probe(struct platform_device *pd=
ev)
> cqspi->current_cs =3D -1;
>         cqspi->sclk =3D 0;
>=20
> -       ret =3D cqspi_setup_flash(cqspi, np);
> +       ret =3D cqspi_setup_flash(cqspi);
>         if (ret) {
> -               dev_err(dev, "Cadence QSPI NOR probe failed %d\n", ret);
> +               dev_err(dev, "failed to setup flash parameters %d\n", ret=
);
>                 goto probe_setup_failed;
>         }
>=20
> -       return ret;
> +       if (cqspi->use_dac_mode) {
> +               ret =3D cqspi_request_mmap_dma(cqspi);

the driver was requesting the mmap for each available flash and now you do =
it=20
once, which is great, but this too has to be made in a dedicated patch.

> +               if (ret =3D=3D -EPROBE_DEFER)
> +                       goto probe_setup_failed;
> +       }
> +
> +       ret =3D devm_spi_register_master(dev, master);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to register SPI ctlr %d\n",
> ret); +               goto probe_setup_failed;
> +       }
> +
> +       return 0;
>  probe_setup_failed:
>         cqspi_controller_enable(cqspi, 0);
> -probe_irq_failed:
> +probe_reset_failed:
>         clk_disable_unprepare(cqspi->clk);
>  probe_clk_failed:
>         pm_runtime_put_sync(dev);
> @@ -1443,11 +1327,6 @@ static int cqspi_probe(struct platform_device *pde=
v)
>  static int cqspi_remove(struct platform_device *pdev)
>  {
>         struct cqspi_st *cqspi =3D platform_get_drvdata(pdev);
> -       int i;
> -
> -       for (i =3D 0; i < CQSPI_MAX_CHIPSELECT; i++)
> -               if (cqspi->f_pdata[i].registered)
> -                       mtd_device_unregister(&cqspi->f_pdata[i].nor.mtd)=
;
>=20
>         cqspi_controller_enable(cqspi, 0);
>=20
> @@ -1490,16 +1369,15 @@ static const struct dev_pm_ops cqspi__dev_pm_ops =
=3D {
> #endif
>=20
>  static const struct cqspi_driver_platdata cdns_qspi =3D {
> -       .hwcaps_mask =3D CQSPI_BASE_HWCAPS_MASK,
> +       .quirks =3D CQSPI_DISABLE_DAC_MODE,

The logic around CQSPI_DISABLE_DAC_MODE needs a dedicated patch.

Cheers,
ta
