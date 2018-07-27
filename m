From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/5] spi: dw: export dw_spi_set_cs
Date: Fri, 27 Jul 2018 23:07:38 +0300
Message-ID: <CAHp75VeC+3A02eErFmfWix87Zx8Wd6dbAQsmQhoT0VF30do7=Q@mail.gmail.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com> <20180727195358.23336-2-alexandre.belloni@bootlin.com>
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
In-Reply-To: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 27, 2018 at 10:53 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Export dw_spi_set_cs so it can be used from the various IP integration
> modules.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/spi/spi-dw.c | 3 ++-
>  drivers/spi/spi-dw.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index f76e31faf694..ac2eb89ef7a5 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>
> -static void dw_spi_set_cs(struct spi_device *spi, bool enable)
> +void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>         struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>         struct chip_data *chip = spi_get_ctldata(spi);
> @@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
>         if (!enable)
>                 dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
>  }
> +EXPORT_SYMBOL_GPL(dw_spi_set_cs);
>
>  /* Return the max entries we can fill into tx fifo */
>  static inline u32 tx_max(struct dw_spi *dws)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 446013022849..0168b08364d5 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -245,6 +245,7 @@ struct dw_spi_chip {
>         void (*cs_control)(u32 command);
>  };
>
> +extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
>  extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
>  extern void dw_spi_remove_host(struct dw_spi *dws);
>  extern int dw_spi_suspend_host(struct dw_spi *dws);
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
