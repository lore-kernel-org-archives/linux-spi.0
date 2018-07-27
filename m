From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
Date: Fri, 27 Jul 2018 16:07:54 +0300
Message-ID: <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com> <20180727120535.16504-3-alexandre.belloni@bootlin.com>
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
In-Reply-To: <20180727120535.16504-3-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 27, 2018 at 3:05 PM, Alexandre Belloni
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

Thanks for an update! My comments below (most of them just about style).

First of all, can we use 'controller' over the 'master' in the code?

>  .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-

>  Required properties:
> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> -  register set is required (named ICPU_CFG:SPI_MST)
> +- compatible : "snps,dw-apb-ssi"
> +- reg : The register base for the controller.

This hunk is odd.

>  struct dw_spi_mmio {
>         struct dw_spi  dws;
>         struct clk     *clk;
> +       void           *priv;
>  };

> +#define MSCC_SPI_MST_SW_MODE                   0x14
> +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)

+ blank line ?

> +struct dw_spi_mscc {
> +       struct regmap       *syscon;

> +       void __iomem        *spi_mst;

A nit: do we need to repeat "spi" here?

> +};

> +       if (!enable)
> +               dw_writel(dws, DW_SPI_SER, BIT(cs));

This sounds like

dw_set_cs(spi, enable);

> +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
> +                              GFP_KERNEL);

sizeof(*dwsmcc)  and one line in the result?

> +       /* Deassert all CS */
> +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);

Hmm... Don't we need to call dw_set_cs() for all of them as well?
If yes, perhaps better to call custom set_cs() in a loop?

-- 
With Best Regards,
Andy Shevchenko
