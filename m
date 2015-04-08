From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: bcm-mspi: Make BCMA optional to support
 non-BCMA chips
Date: Wed, 8 Apr 2015 21:27:19 +0200
Message-ID: <CAOiHx==NCAOqFf2gzEX+fmFq=TRjq9hHDbpBt4Dpdg1HC6qjuQ@mail.gmail.com>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com> <1428516275-12819-5-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428516275-12819-5-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Apr 8, 2015 at 8:04 PM, Jonathan Richardson
<jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> The Broadcom MSPI controller is used on various chips. The driver onl=
y
> supported BCM53xx chips with BCMA (an AMBA bus variant). It now suppo=
rts
> both BCMA MSPI and non-BCMA MSPI. To do this the following changes we=
re
> made:
>
>   - A new config for non-BCMA chips has been added.
>   - Common code between the BCMA and non BCMA version are shared.
>   - Function pointers to set read/write functions to abstract bcma
>     and non-bcma versions are provided.
>   - DT is now mandatory. Hard coded SPI devices are removed and must =
be
>     set in DT.
>   - Remove function was unnecessary and removed.
>
> Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/spi/Kconfig        |    5 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-bcm-mspi.c |  228 ++++++++++++++++++++++++++++++++--=
----------
>  3 files changed, 171 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 766e08d..23f2357 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -120,6 +120,11 @@ config SPI_BCMA_MSPI
>         help
>           Enable support for the Broadcom BCMA MSPI controller.
>
> +config SPI_BCM_MSPI
> +       tristate "Broadcom MSPI controller"

You say "DT is now mandatory", but I don't see you depending on OF.
Does it compile with OF disabled?

> +       help
> +         Enable support for the Broadcom MSPI controller.
> +
>  config SPI_BCM63XX
>         tristate "Broadcom BCM63xx SPI controller"
>         depends on BCM63XX
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 6b58100..36872d2 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_ATH79)                       +=3D =
spi-ath79.o
>  obj-$(CONFIG_SPI_AU1550)               +=3D spi-au1550.o
>  obj-$(CONFIG_SPI_BCM2835)              +=3D spi-bcm2835.o
>  obj-$(CONFIG_SPI_BCMA_MSPI)            +=3D spi-bcm-mspi.o
> +obj-$(CONFIG_SPI_BCM_MSPI)             +=3D spi-bcm-mspi.o

What happens if SPI_BCMA_MSPI and SPI_BCM_MSPI are both set? What
happens if they disagree, i.e. one is y, the other m?

>  obj-$(CONFIG_SPI_BCM63XX)              +=3D spi-bcm63xx.o
>  obj-$(CONFIG_SPI_BCM63XX_HSSPI)                +=3D spi-bcm63xx-hssp=
i.o
>  obj-$(CONFIG_SPI_BFIN5XX)              +=3D spi-bfin5xx.o
> diff --git a/drivers/spi/spi-bcm-mspi.c b/drivers/spi/spi-bcm-mspi.c
> index 502227d..32bb1f0 100644
> --- a/drivers/spi/spi-bcm-mspi.c
> +++ b/drivers/spi/spi-bcm-mspi.c
> @@ -11,11 +11,13 @@
>   * GNU General Public License for more details.
>   */
>  #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/bcma/bcma.h>
>  #include <linux/spi/spi.h>
> +#include <linux/of.h>
>
>  #include "spi-bcm-mspi.h"
>
> @@ -25,22 +27,17 @@
>  #define BCM_MSPI_SPE_TIMEOUT_MS 80
>
>  struct bcm_mspi {
> +#ifdef CONFIG_SPI_BCMA_MSPI
>         struct bcma_device *core;
> -       struct spi_master *master;
> +#endif
>
> +       void __iomem *base;
> +       struct spi_master *master;

You could make this part a bit more readable by not reordering existing=
 members.

>         size_t read_offset;
> -};
> -
> -static inline u32 bcm_mspi_read(struct bcm_mspi *mspi, u16 offset)
> -{
> -       return bcma_read32(mspi->core, offset);
> -}
>
> -static inline void bcm_mspi_write(struct bcm_mspi *mspi, u16 offset,
> -                                   u32 value)
> -{
> -       bcma_write32(mspi->core, offset, value);
> -}
> +       void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 val=
ue);
> +       u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
> +};

Why not keep these and let them call mspi->mspi_read() resp.
mspi->mspi_write()? It would reduce the amount of changes quite a bit.

>
>  static inline unsigned int bcm_mspi_calc_timeout(size_t len)
>  {
> @@ -56,7 +53,7 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, uns=
igned int timeout_ms)
>         /* SPE bit has to be 0 before we read MSPI STATUS */
>         deadline =3D jiffies + BCM_MSPI_SPE_TIMEOUT_MS * HZ / 1000;
>         do {
> -               tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
> +               tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
>                 if (!(tmp & MSPI_SPCR2_SPE))
>                         break;
>                 udelay(5);
> @@ -68,9 +65,9 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, uns=
igned int timeout_ms)
>         /* Check status */
>         deadline =3D jiffies + timeout_ms * HZ / 1000;
>         do {
> -               tmp =3D bcm_mspi_read(mspi, MSPI_STATUS);
> +               tmp =3D mspi->mspi_read(mspi, MSPI_STATUS);
>                 if (tmp & MSPI_STATUS_SPIF) {
> -                       bcm_mspi_write(mspi, MSPI_STATUS, 0);
> +                       mspi->mspi_write(mspi, MSPI_STATUS, 0);
>                         return 0;
>                 }
>
> @@ -79,7 +76,7 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, uns=
igned int timeout_ms)
>         } while (!time_after_eq(jiffies, deadline));
>
>  spi_timeout:
> -       bcm_mspi_write(mspi, MSPI_STATUS, 0);
> +       mspi->mspi_write(mspi, MSPI_STATUS, 0);
>
>         pr_err("Timeout waiting for SPI to be ready!\n");
>
> @@ -94,7 +91,7 @@ static void bcm_mspi_buf_write(struct bcm_mspi *msp=
i, u8 *w_buf,
>
>         for (i =3D 0; i < len; i++) {
>                 /* Transmit Register File MSB */
> -               bcm_mspi_write(mspi, MSPI_TXRAM + 4 * (i * 2),
> +               mspi->mspi_write(mspi, MSPI_TXRAM + 4 * (i * 2),
>                                  (unsigned int)w_buf[i]);
>         }
>
> @@ -105,28 +102,28 @@ static void bcm_mspi_buf_write(struct bcm_mspi =
*mspi, u8 *w_buf,
>                         tmp &=3D ~MSPI_CDRAM_CONT;
>                 tmp &=3D ~0x1;
>                 /* Command Register File */
> -               bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
> +               mspi->mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
>         }
>
>         /* Set queue pointers */
> -       bcm_mspi_write(mspi, MSPI_NEWQP, 0);
> -       bcm_mspi_write(mspi, MSPI_ENDQP, len - 1);
> +       mspi->mspi_write(mspi, MSPI_NEWQP, 0);
> +       mspi->mspi_write(mspi, MSPI_ENDQP, len - 1);
>
>         if (cont)
> -               bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
> +               mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 1);
>
>         /* Start SPI transfer */
> -       tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
> +       tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
>         tmp |=3D MSPI_SPCR2_SPE;
>         if (cont)
>                 tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
> -       bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
> +       mspi->mspi_write(mspi, MSPI_SPCR2, tmp);
>
>         /* Wait for SPI to finish */
>         bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
>
>         if (!cont)
> -               bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
> +               mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 0);
>
>         mspi->read_offset =3D len;
>  }
> @@ -144,34 +141,35 @@ static void bcm_mspi_buf_read(struct bcm_mspi *=
mspi, u8 *r_buf,
>                         tmp &=3D ~MSPI_CDRAM_CONT;
>                 tmp &=3D ~0x1;
>                 /* Command Register File */
> -               bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
> +               mspi->mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
>         }
>
>         /* Set queue pointers */
> -       bcm_mspi_write(mspi, MSPI_NEWQP, 0);
> -       bcm_mspi_write(mspi, MSPI_ENDQP, mspi->read_offset + len - 1)=
;
> +       mspi->mspi_write(mspi, MSPI_NEWQP, 0);
> +       mspi->mspi_write(mspi, MSPI_ENDQP,
> +                        mspi->read_offset + len - 1);
>
>         if (cont)
> -               bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
> +               mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 1);
>
>         /* Start SPI transfer */
> -       tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
> +       tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
>         tmp |=3D MSPI_SPCR2_SPE;
>         if (cont)
>                 tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
> -       bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
> +       mspi->mspi_write(mspi, MSPI_SPCR2, tmp);
>
>         /* Wait for SPI to finish */
>         bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
>
>         if (!cont)
> -               bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
> +               mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 0);
>
>         for (i =3D 0; i < len; ++i) {
>                 int offset =3D mspi->read_offset + i;
>
>                 /* Data stored in the transmit register file LSB */
> -               r_buf[i] =3D (u8)bcm_mspi_read(mspi,
> +               r_buf[i] =3D (u8)mspi->mspi_read(mspi,
>                         MSPI_RXRAM + 4 * (1 + offset * 2));
>         }
>
> @@ -216,10 +214,104 @@ static int bcm_mspi_transfer_one(struct spi_ma=
ster *master,
>         return 0;
>  }
>
> -static struct spi_board_info bcm_mspi_info =3D {
> -       .modalias       =3D "bcm53xxspiflash",
> +/*
> + * Allocate SPI master for both bcma and non bcma bus. The SPI devic=
e must be
> + * configured in DT.
> + */
> +static struct bcm_mspi *bcm_mspi_init(struct device *dev)
> +{
> +       struct bcm_mspi *data;
> +       struct spi_master *master;
> +
> +       master =3D spi_alloc_master(dev, sizeof(*data));
> +       if (!master) {
> +               dev_err(dev, "error allocating spi_master\n");
> +               return 0;

return NULL;

> +       }
> +
> +       data =3D spi_master_get_devdata(master);
> +       data->master =3D master;
> +
> +       /* SPI master will always use the SPI device(s) from DT. */
> +       master->dev.of_node =3D dev->of_node;
> +       master->transfer_one =3D bcm_mspi_transfer_one;
> +
> +       return data;
> +}
> +
> +#ifdef CONFIG_SPI_BCM_MSPI

Won't this break when being build as a module? I think you need

#if IS_ENABLED(CONFIG_SPI_BCM_MSPI)

> +
> +static const struct of_device_id bcm_mspi_dt[] =3D {
> +       { .compatible =3D "brcm,mspi" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_mspi_dt);
> +
> +static inline u32 bcm_mspi_read(struct bcm_mspi *mspi, u16 offset)
> +{
> +       return readl(mspi->base + offset);
> +}
> +
> +static inline void bcm_mspi_write(struct bcm_mspi *mspi, u16 offset,
> +       u32 value)
> +{
> +       writel(value, mspi->base + offset);
> +}
> +
> +/*
> + * Probe routine for non-bcma devices.
> + */
> +static int bcm_mspi_probe(struct platform_device *pdev)
> +{
> +       struct bcm_mspi *data;
> +       struct device *dev =3D &pdev->dev;
> +       int err;
> +       struct resource *res;
> +
> +       dev_info(dev, "BCM MSPI probe\n");
> +
> +       data =3D bcm_mspi_init(dev);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       /* Map base memory address. */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(data->base)) {
> +               dev_err(&pdev->dev, "unable to map I/O memory\n");

devm_ioremap_resource will already complain for you.

> +               err =3D PTR_ERR(data->base);
> +               goto out;
> +       }
> +
> +       data->mspi_read =3D bcm_mspi_read;
> +       data->mspi_write =3D bcm_mspi_write;
> +       platform_set_drvdata(pdev, data);
> +
> +       err =3D devm_spi_register_master(dev, data->master);
> +       if (err)
> +               goto out;
> +
> +       return 0;
> +
> +out:
> +       spi_master_put(data->master);
> +       return err;
> +}
> +
> +static struct platform_driver bcm_mspi_driver =3D {
> +       .driver =3D {
> +               .name =3D "bcm-mspi",
> +               .of_match_table =3D bcm_mspi_dt,
> +       },
> +       .probe =3D bcm_mspi_probe,
>  };
>
> +module_platform_driver(bcm_mspi_driver);
> +
> +#endif
> +
> +#ifdef CONFIG_SPI_BCMA_MSPI

likewise.

> +
>  static const struct bcma_device_id bcm_mspi_bcma_tbl[] =3D {
>         BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_QSPI, BCMA_ANY_REV,
>                 BCMA_ANY_CLASS),
> @@ -227,62 +319,70 @@ static const struct bcma_device_id bcm_mspi_bcm=
a_tbl[] =3D {
>  };
>  MODULE_DEVICE_TABLE(bcma, bcm_mspi_bcma_tbl);
>
> +static const struct of_device_id bcm_bcma_mspi_dt[] =3D {
> +       { .compatible =3D "brcm,bcma-mspi" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_mspi_dt);
> +
> +static inline u32 bcm_bcma_mspi_read(struct bcm_mspi *mspi, u16 offs=
et)
> +{
> +       return bcma_read32(mspi->core, offset);
> +}
> +
> +static inline void bcm_bcma_mspi_write(struct bcm_mspi *mspi, u16 of=
fset,
> +       u32 value)
> +{
> +       bcma_write32(mspi->core, offset, value);
> +}
> +
> +/*
> + * Probe routine for bcma devices.
> + */
>  static int bcm_mspi_bcma_probe(struct bcma_device *core)
>  {
>         struct bcm_mspi *data;
> -       struct spi_master *master;
>         int err;
>
>         dev_info(&core->dev, "BCM MSPI BCMA probe\n");
>
>         if (core->bus->drv_cc.core->id.rev !=3D 42) {
> -               pr_err("SPI on SoC with unsupported ChipCommon rev\n"=
);
> +               dev_err(&core->dev,
> +                       "SPI on SoC with unsupported ChipCommon rev\n=
");
>                 return -ENOTSUPP;
>         }
>
> -       master =3D spi_alloc_master(&core->dev, sizeof(*data));
> -       if (!master)
> +       data =3D bcm_mspi_init(&core->dev);
> +       if (!data)
>                 return -ENOMEM;
>
> -       data =3D spi_master_get_devdata(master);
> -       data->master =3D master;
> +       data->mspi_read =3D bcm_bcma_mspi_read;
> +       data->mspi_write =3D bcm_bcma_mspi_write;
>         data->core =3D core;
>
> -       master->transfer_one =3D bcm_mspi_transfer_one;
> -
>         bcma_set_drvdata(core, data);
>
>         err =3D devm_spi_register_master(&core->dev, data->master);
>         if (err) {
> -               spi_master_put(master);
> -               bcma_set_drvdata(core, NULL);
> -               goto out;
> +               spi_master_put(data->master);
> +               return err;
>         }
>
> -       /* Broadcom SoCs (at least with the CC rev 42) use SPI for fl=
ash only */
> -       spi_new_device(master, &bcm_mspi_info);

Why are you removing the registration of the flash device? Won't this
break bcm53xx's flash registration?

> -
> -out:
> -       return err;
> -}
> -
> -static void bcm_mspi_bcma_remove(struct bcma_device *core)
> -{
> -       struct bcm_mspi *mspi =3D bcma_get_drvdata(core);
> -
> -       spi_unregister_master(mspi->master);
> +       return 0;
>  }
>
>  static struct bcma_driver bcm_mspi_bcma_driver =3D {
>         .name           =3D KBUILD_MODNAME,
> +       .drv =3D {
> +               .of_match_table =3D bcm_bcma_mspi_dt,
> +       },
>         .id_table       =3D bcm_mspi_bcma_tbl,
>         .probe          =3D bcm_mspi_bcma_probe,
> -       .remove         =3D bcm_mspi_bcma_remove,
>  };
>
> -static int __init bcm_mspi_module_init(void)
> +static int __init bcm_mspi_bcma_module_init(void)
>  {
> -       int err =3D 0;
> +       int err;

Unrelated change.

>
>         err =3D bcma_driver_register(&bcm_mspi_bcma_driver);
>         if (err)
> @@ -291,13 +391,15 @@ static int __init bcm_mspi_module_init(void)
>         return err;
>  }
>
> -static void __exit bcm_mspi_module_exit(void)
> +static void __exit bcm_mspi_bcma_module_exit(void)
>  {
>         bcma_driver_unregister(&bcm_mspi_bcma_driver);
>  }
>
> -module_init(bcm_mspi_module_init);
> -module_exit(bcm_mspi_module_exit);
> +module_init(bcm_mspi_bcma_module_init);
> +module_exit(bcm_mspi_bcma_module_exit);
> +
> +#endif
>
>  MODULE_DESCRIPTION("Broadcom MSPI SPI Controller driver");
>  MODULE_AUTHOR("Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> --


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
