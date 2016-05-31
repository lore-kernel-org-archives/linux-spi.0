From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Tue, 31 May 2016 07:43:37 -0300
Message-ID: <CAOMZO5CiW3J+naHfitjv59i4xisYB1R3ATs2qvz4mLh_FMyf+g@mail.gmail.com>
References: <574D5C2B.1000400@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <574D5C2B.1000400-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[Adding Sascha and Anton in Cc]

On Tue, May 31, 2016 at 6:40 AM, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org> wrote:
> Hi,
>
> as imx6 using multiple burst to send data to spi slaves and drop the
> chipselect between the words by default my sensor NXP MPL115A1 wasn't
> working.
> The hint comes from a discussion in the Freescale forum from 2013 where Jeff
> Coffman posted his solution for a 3.x kernel.
> I'd pick-up the idea behind and develop something which works "so far" with
> 4.6 and linux-next
>
> Up front - I'm not happy using the xfer->cs_change to get set the single
> burst
> I more likely want add a new xfer bit which allow to dedicated set a single
> burst.
> To replace todays:
>         xfer[0].cs_change = 0;
> with a
>         xfer[0].singleburst = 1;
>
> An other issue with is not yet solved; when I have a odd number of bytes (8
> bpw) in a transfer, its result in 3 bytes eaten on the start and 0x00 added
> on the tail -
>
> Single file patch - something to view.
>
> Patch v0: add support for imx6 single burst mode.
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 50769078..3440d0e 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -60,6 +60,8 @@ struct spi_imx_config {
>         unsigned int speed_hz;
>         unsigned int bpw;
>         unsigned int mode;
> +       unsigned int len;
> +       unsigned int single_burst_mode:1;
>         u8 cs;
>  };
>
> @@ -99,11 +101,13 @@ struct spi_imx_data {
>         unsigned int bytes_per_word;
>
>         unsigned int count;
> +       unsigned int rxcount;
>         void (*tx)(struct spi_imx_data *);
>         void (*rx)(struct spi_imx_data *);
>         void *rx_buf;
>         const void *tx_buf;
>         unsigned int txfifo; /* number of words pushed in tx FIFO */
> +       u8 bits_per_word;
>
>         /* DMA */
>         bool usedma;
> @@ -168,6 +172,191 @@ MXC_SPI_BUF_TX(u16)
>  MXC_SPI_BUF_RX(u32)
>  MXC_SPI_BUF_TX(u32)
>
> +static void spi_imx_buf_rx_sb(struct spi_imx_data *spi_imx)
> +{
> +    unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
> +    dev_dbg(spi_imx->dev, "%s: rxcount: %u val:0x%08x\n",
> +           __func__, spi_imx->rxcount , val);
> +    if (spi_imx->rxcount>=4) {
> +           if (spi_imx->rx_buf) {
> +                   if (spi_imx->bits_per_word==32) {
> +                           spi_imx_buf_rx_u32(spi_imx);
> +                   } else if (spi_imx->bits_per_word==16) {
> +                           *(u16 *)spi_imx->rx_buf = (val>>16);
> +                           spi_imx->rx_buf += sizeof(u16);
> +                           *(u16 *)spi_imx->rx_buf = val;
> +                           spi_imx->rx_buf += sizeof(u16);
> +                   } else {
> +                           *(u8 *)spi_imx->rx_buf = (val>>24);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = (val>>16);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = (val>>8);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   }
> +           }
> +           spi_imx->rxcount-=4;
> +    }
> +    else if (spi_imx->rxcount==3) {
> +           if (spi_imx->rx_buf) {
> +                   if (spi_imx->bits_per_word==32) {
> +                           *(u8 *)spi_imx->rx_buf = val>>24;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val>>16;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val>>8;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   } else if (spi_imx->bits_per_word==16) {
> +                           *(u16 *)spi_imx->rx_buf = (val>>16);
> +                           spi_imx->rx_buf += sizeof(u16);
> +                           *(u8 *)spi_imx->rx_buf = val>>8;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   } else {
> +                           *(u8 *)spi_imx->rx_buf = (val>>16);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = (val>>8);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   }
> +           }
> +           spi_imx->rxcount-=3;
> +    }
> +    else if (spi_imx->rxcount==2) {
> +           if (spi_imx->rx_buf) {
> +                   if (spi_imx->bits_per_word==32) {
> +                           *(u8 *)spi_imx->rx_buf = val>>24;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val>>16;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   } else if (spi_imx->bits_per_word==16) {
> +                           spi_imx_buf_rx_u16(spi_imx);
> +                   } else {
> +                           *(u8 *)spi_imx->rx_buf = (val>>8);
> +                           spi_imx->rx_buf += sizeof(u8);
> +                           *(u8 *)spi_imx->rx_buf = val;
> +                           spi_imx->rx_buf += sizeof(u8);
> +                   }
> +           }
> +           spi_imx->rxcount-=2;
> +    }
> +    else if (spi_imx->rxcount==1) {
> +           if (spi_imx->rx_buf) {
> +                   if (spi_imx->bits_per_word==32) {
> +                           *(u8 *)spi_imx->rx_buf = val>>24;
> +                   } else if (spi_imx->bits_per_word==16) {
> +                           *(u8 *)spi_imx->rx_buf = val>>8;
> +                   } else {
> +                           spi_imx_buf_rx_u8(spi_imx);
> +                   }
> +           }
> +           spi_imx->rxcount-=1;
> +    }
> +}
> +
> +static void spi_imx_buf_tx_sb(struct spi_imx_data *spi_imx)
> +{
> +       unsigned int val = 0;
> +       dev_dbg(spi_imx->dev, "%s: txcount: %u ptr:0x%08x\n",
> +               __func__, spi_imx->count ,*(u32 *)spi_imx->tx_buf);
> +       if (spi_imx->count>=4) {
> +               if (spi_imx->bits_per_word==32) {
> +                       spi_imx_buf_tx_u32(spi_imx);
> +               } else {
> +                       if (spi_imx->tx_buf) {
> +                               if (spi_imx->bits_per_word==16) {
> +                                       val = *(u16 *)spi_imx->tx_buf<<16;
> +                                       spi_imx->tx_buf += sizeof(u16);
> +                                       val |= *(u16 *)spi_imx->tx_buf;
> +                                       spi_imx->tx_buf += sizeof(u16);
> +                               } else {
> +                                       val = *(u8 *)spi_imx->tx_buf<<24;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                                       val |= *(u8 *)spi_imx->tx_buf<<16;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                                       val |= *(u8 *)spi_imx->tx_buf<<8;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                                       val |= *(u8 *)spi_imx->tx_buf;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                               }
> +                               writel(val, spi_imx->base + MXC_CSPITXDATA);
> +                       }
> +                       spi_imx->count -= 4;
> +               }
> +       }
> +       else if (spi_imx->count==3) {
> +               if (spi_imx->tx_buf) {
> +                       if (spi_imx->bits_per_word==32) {
> +                               val = *(u8 *)spi_imx->tx_buf<<24;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf<<16;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf<<8;
> +                               spi_imx->tx_buf += sizeof(u8);
> +
> +                       } else if (spi_imx->bits_per_word==16) {
> +                               val = *(u8 *)spi_imx->tx_buf<<24;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf<<16;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf;
> +                               spi_imx->tx_buf += sizeof(u8);
> +
> +                       } else {
> +                               val = *(u8 *)spi_imx->tx_buf<<16;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf<<8;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                               val |= *(u8 *)spi_imx->tx_buf;
> +                               spi_imx->tx_buf += sizeof(u8);
> +                       }
> +                       writel(val, spi_imx->base + MXC_CSPITXDATA);
> +               }
> +               spi_imx->count -= 3;
> +       }
> +       else if (spi_imx->count==2) {
> +               if (spi_imx->bits_per_word==16) {
> +                       spi_imx_buf_tx_u16(spi_imx);
> +               } else {
> +                       if (spi_imx->tx_buf) {
> +                               if (spi_imx->bits_per_word==32) {
> +                                       val = *(u8 *)spi_imx->tx_buf<<24;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                                       val |= *(u8 *)spi_imx->tx_buf<<16;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                               } else {
> +                                       val = *(u8 *)spi_imx->tx_buf<<8;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                                       val |= *(u8 *)spi_imx->tx_buf;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                               }
> +                               writel(val, spi_imx->base + MXC_CSPITXDATA);
> +                       }
> +                       spi_imx->count -= 2;
> +               }
> +       }
> +       else if (spi_imx->count==1) {
> +               if (spi_imx->bits_per_word==8){
> +                       spi_imx_buf_tx_u8(spi_imx);
> +               } else {
> +                       if (spi_imx->tx_buf) {
> +                               if (spi_imx->bits_per_word==32) {
> +                                       val = *(u8 *)spi_imx->tx_buf<<24;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                               } else if (spi_imx->bits_per_word==16) {
> +                                       val = *(u8 *)spi_imx->tx_buf<<8;
> +                                       spi_imx->tx_buf += sizeof(u8);
> +                               }
> +                               writel(val, spi_imx->base + MXC_CSPITXDATA);
> +                       }
> +                       spi_imx->count -= 1;
> +               }
> +       }
> +}
> +
> +
>  /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
>   * (which is currently not the case in this driver)
>   */
> @@ -357,9 +546,49 @@ static int __maybe_unused mx51_ecspi_config(struct
> spi_imx_data *spi_imx,
>         /* set chip select to use */
>         ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
>
> -       ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
> +       /* set single/multible burst parameters */
> +       if (config->single_burst_mode>0) {
> +               reg = 0;
> +               spi_imx->rx = spi_imx_buf_rx_sb;
> +               spi_imx->tx = spi_imx_buf_tx_sb;
> +               spi_imx->rxcount = config->len;
> +               spi_imx->bits_per_word = config->bpw;
> +
> +               /* calculate the Burst Length,
> +                  refer to 21.7.3 Control Register (ECSPIx_CONREG)
> +                  for details.
> +                */
> +               switch (config->len%4)
> +               {
> +               case 1:
> +                       ctrl |= 7 << MX51_ECSPI_CTRL_BL_OFFSET;
> +                       reg = (config->len-1) / 4;
> +                       break;
> +               case 2:
> +                       ctrl |= 15 << MX51_ECSPI_CTRL_BL_OFFSET;
> +                       reg = (config->len-2) / 4;
> +                       break;
> +               case 3:
> +                       ctrl |= 23 << MX51_ECSPI_CTRL_BL_OFFSET;
> +                       reg = (config->len-3) / 4;
> +                       break;
> +               case 0:
> +                       ctrl |= 31 << MX51_ECSPI_CTRL_BL_OFFSET;
> +                       reg = (config->len-4) / 4;
> +                       break;
> +               }
> +
> +               if (reg>0)
> +                       ctrl |= reg << (MX51_ECSPI_CTRL_BL_OFFSET + 5);
>
> -       cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
> +               cfg &= ~(MX51_ECSPI_CONFIG_SBBCTRL(config->cs));
> +
> +               dev_dbg(spi_imx->dev, "Single Burst reg:0x%08x cfg:0x%08x
> ctrl:0x%08x\n"
> +                       , reg, cfg, ctrl);
> +       } else {
> +               ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
> +               cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
> +       }
>
>         if (config->mode & SPI_CPHA)
>                 cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
> @@ -861,6 +1090,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>         config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
>         config.mode = spi->mode;
>         config.cs = spi->chip_select;
> +       config.len = t->len;
> +       config.single_burst_mode = ~(t->cs_change);
>
>         if (!config.speed_hz)
>                 config.speed_hz = spi->max_speed_hz;
>
>
>
>
>
> Regards
> Chris
>
> --
> GTSYS Limited RFID Technology
> 9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
> 42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
> Tel (852) 9079 9521
>
> Disclaimer: http://www.gtsys.com.hk/email/classified.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
