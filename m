From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/5] spi: dw-mmio: add MSCC Ocelot support
Date: Fri, 27 Jul 2018 23:14:48 +0300
Message-ID: <CAHp75VcWHHmUeSoQddi=YpNVfnkADa7cKk2C0EzZCCnriLCFPQ@mail.gmail.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com> <20180727195358.23336-4-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727195358.23336-4-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 27, 2018 at 10:53 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v3:
>  - use dw_spi_set_cs instead of open coding
>  - few small improvements suggested by Andy
>  - changed the comment to be clearer regarding which IP is used on the SoC
>  - removed useless dt bindings change
>
> Change in v2:
>  - correctly use device_get_match_data to retrieve the init function instead of
>    hardcoding it.
>
>  drivers/spi/spi-dw-mmio.c | 90 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index d25cc4037e23..e80f60ed6fdf 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -15,11 +15,13 @@
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/scatterlist.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/property.h>
> +#include <linux/regmap.h>
>
>  #include "spi-dw.h"
>
> @@ -28,10 +30,90 @@
>  struct dw_spi_mmio {
>         struct dw_spi  dws;
>         struct clk     *clk;
> +       void           *priv;
>  };
>
> +#define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL      0x24
> +#define OCELOT_IF_SI_OWNER_MASK                        GENMASK(5, 4)
> +#define OCELOT_IF_SI_OWNER_OFFSET              4
> +#define MSCC_IF_SI_OWNER_SISL                  0
> +#define MSCC_IF_SI_OWNER_SIBM                  1
> +#define MSCC_IF_SI_OWNER_SIMC                  2
> +
> +#define MSCC_SPI_MST_SW_MODE                   0x14
> +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)
> +
> +struct dw_spi_mscc {
> +       struct regmap       *syscon;
> +       void __iomem        *spi_mst;
> +};
> +
> +/*
> + * The Designware SPI controller (referred to as master in the documentation)
> + * automatically deasserts chip select when the tx fifo is empty. The chip
> + * selects then needs to be either driven as GPIOs or, for the first 4 using the
> + * the SPI boot controller registers. the final chip select is an OR gate
> + * between the Designware SPI controller and the SPI boot controller.
> + */
> +static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +       struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +       struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
> +       u32 cs = spi->chip_select;
> +
> +       if (cs < 4) {
> +               u32 sw_mode = MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE;
> +
> +               if (!enable)
> +                       sw_mode |= MSCC_SPI_MST_SW_MODE_SW_SPI_CS(BIT(cs));
> +
> +               writel(sw_mode, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
> +       }
> +
> +       dw_spi_set_cs(spi, enable);
> +}
> +
> +static int dw_spi_mscc_init(struct platform_device *pdev,
> +                           struct dw_spi_mmio *dwsmmio)
> +{
> +       struct dw_spi_mscc *dwsmscc;
> +       struct resource *res;
> +
> +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(*dwsmscc), GFP_KERNEL);
> +       if (!dwsmscc)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       dwsmscc->spi_mst = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(dwsmscc->spi_mst)) {
> +               dev_err(&pdev->dev, "SPI_MST region map failed\n");
> +               return PTR_ERR(dwsmscc->spi_mst);
> +       }
> +
> +       dwsmscc->syscon = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
> +       if (IS_ERR(dwsmscc->syscon))
> +               return PTR_ERR(dwsmscc->syscon);
> +
> +       /* Deassert all CS */
> +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
> +
> +       /* Select the owner of the SI interface */
> +       regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> +                          OCELOT_IF_SI_OWNER_MASK,
> +                          MSCC_IF_SI_OWNER_SIMC << OCELOT_IF_SI_OWNER_OFFSET);
> +
> +       dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
> +       dwsmmio->priv = dwsmscc;
> +
> +       return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
> +       int (*init_func)(struct platform_device *pdev,
> +                        struct dw_spi_mmio *dwsmmio);
>         struct dw_spi_mmio *dwsmmio;
>         struct dw_spi *dws;
>         struct resource *mem;
> @@ -99,6 +181,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       init_func = device_get_match_data(&pdev->dev);
> +       if (init_func) {
> +               ret = init_func(pdev, dwsmmio);
> +               if (ret)
> +                       goto out;
> +       }
> +
>         ret = dw_spi_add_host(&pdev->dev, dws);
>         if (ret)
>                 goto out;
> @@ -123,6 +212,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
>
>  static const struct of_device_id dw_spi_mmio_of_match[] = {
>         { .compatible = "snps,dw-apb-ssi", },
> +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
>         { /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
