From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Wed, 25 Mar 2015 23:40:16 +0200
Message-ID: <CAHp75VdE9-4TQP1Fdbb7g0Bzg2GDEvgsYxex7JVxUvxcfT6qdQ@mail.gmail.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
	<1426853793-24454-2-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426853793-24454-2-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Mar 20, 2015 at 2:16 PM, Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org> wrote:

Besides what Mark told you (I mostly about absence of the commit
message) there are few more comments below.

> Signed-off-by: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>

> +++ b/drivers/spi/spi-rb4xx.c
> @@ -0,0 +1,419 @@
> +/*
> + * SPI controller driver for the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

2010, 2015 ?

> + *
> + * This file was based on the patches for Linux 2.6.27.39 published =
by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +#include <asm/mach-ath79/ath79.h>
> +
> +#define DRV_NAME       "rb4xx-spi"
> +#define DRV_DESC       "Mikrotik RB4xx SPI controller driver"
> +#define DRV_VERSION    "0.1.0"
> +
> +#define SPI_CTRL_FASTEST       0x40
> +#define SPI_HZ                 33333334
> +
> +#undef RB4XX_SPI_DEBUG

Why is it here?

> +
> +struct rb4xx_spi {
> +       void __iomem            *base;
> +       struct spi_master       *master;
> +
> +       unsigned                spi_ctrl;
> +
> +       struct clk              *ahb_clk;
> +       unsigned long           ahb_freq;
> +
> +       spinlock_t              lock;
> +       struct list_head        queue;
> +       int                     busy:1;
> +       int                     cs_wait;
> +};
> +
> +static unsigned spi_clk_low =3D AR71XX_SPI_IOC_CS1;
> +
> +#ifdef RB4XX_SPI_DEBUG
> +static inline void do_spi_delay(void)
> +{
> +       ndelay(20000);
> +}
> +#else
> +static inline void do_spi_delay(void) { }
> +#endif
> +
> +static inline void do_spi_init(struct spi_device *spi)
> +{
> +       unsigned cs =3D AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1;
> +
> +       if (!(spi->mode & SPI_CS_HIGH))
> +               cs ^=3D (spi->chip_select =3D=3D 2) ? AR71XX_SPI_IOC_=
CS1 :
> +                                               AR71XX_SPI_IOC_CS0;

What is the magic CS =3D=3D 2?

> +
> +       spi_clk_low =3D cs;
> +}
> +
> +static inline void do_spi_finish(void __iomem *base)
> +{
> +       do_spi_delay();
> +       __raw_writel(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1,
> +                    base + AR71XX_SPI_REG_IOC);

I highly recommend you to provide pair of inliners to access hardware.
It would be easy to maintain=E2=80=A6

> +}
> +
> +static inline void do_spi_clk(void __iomem *base, int bit)
> +{
> +       unsigned bval =3D spi_clk_low | ((bit & 1) ? AR71XX_SPI_IOC_D=
O : 0);
> +
> +       do_spi_delay();
> +       __raw_writel(bval, base + AR71XX_SPI_REG_IOC);

=E2=80=A6and you may easily provide rb4xx_writel_delayed() as well.

> +       do_spi_delay();
> +       __raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG=
_IOC);
> +}
> +
> +static void do_spi_byte(void __iomem *base, unsigned char byte)
> +{
> +       do_spi_clk(base, byte >> 7);
> +       do_spi_clk(base, byte >> 6);
> +       do_spi_clk(base, byte >> 5);
> +       do_spi_clk(base, byte >> 4);
> +       do_spi_clk(base, byte >> 3);
> +       do_spi_clk(base, byte >> 2);
> +       do_spi_clk(base, byte >> 1);
> +       do_spi_clk(base, byte);
> +
> +       pr_debug("spi_byte sent 0x%02x got 0x%02x\n",
> +                (unsigned)byte,
> +                (unsigned char)__raw_readl(base + AR71XX_SPI_REG_RDS=
));
> +}
> +
> +static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1=
,
> +                                  unsigned bit2)
> +{
> +       unsigned bval =3D (spi_clk_low |
> +                        ((bit1 & 1) ? AR71XX_SPI_IOC_DO : 0) |
> +                        ((bit2 & 1) ? AR71XX_SPI_IOC_CS2 : 0));

Regarding to the usage, why not to provide one variable with two bits?

> +       do_spi_delay();
> +       __raw_writel(bval, base + AR71XX_SPI_REG_IOC);
> +       do_spi_delay();
> +       __raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG=
_IOC);
> +}
> +
> +static void do_spi_byte_fast(void __iomem *base, unsigned char byte)
> +{
> +       do_spi_clk_fast(base, byte >> 7, byte >> 6);
> +       do_spi_clk_fast(base, byte >> 5, byte >> 4);
> +       do_spi_clk_fast(base, byte >> 3, byte >> 2);
> +       do_spi_clk_fast(base, byte >> 1, byte >> 0);
> +
> +       pr_debug("spi_byte_fast sent 0x%02x got 0x%02x\n",
> +                (unsigned)byte,
> +                (unsigned char) __raw_readl(base + AR71XX_SPI_REG_RD=
S));
> +}
> +
> +static int rb4xx_spi_txrx(void __iomem *base, struct spi_transfer *t=
)
> +{
> +       const unsigned char *rxv_ptr =3D NULL;
> +       const unsigned char *tx_ptr =3D t->tx_buf;
> +       unsigned char *rx_ptr =3D t->rx_buf;
> +       unsigned i;
> +
> +       pr_debug("spi_txrx len %u tx %u rx %u\n", t->len,
> +                (t->tx_buf ? 1 : 0),

!!t->tx_buf ?
Or personally I prefer to see %p here.

> +                (t->rx_buf ? 1 : 0));

Ditto.

> +
> +       for (i =3D 0; i < t->len; ++i) {
> +               unsigned char sdata =3D tx_ptr ? tx_ptr[i] : 0;
> +
> +               if (t->fast_write)
> +                       do_spi_byte_fast(base, sdata);
> +               else
> +                       do_spi_byte(base, sdata);
> +
> +               if (rx_ptr) {
> +                       rx_ptr[i] =3D __raw_readl(base + AR71XX_SPI_R=
EG_RDS) & 0xff;
> +               } else if (rxv_ptr) {
> +                       unsigned char c =3D __raw_readl(base + AR71XX=
_SPI_REG_RDS);
> +
> +                       if (rxv_ptr[i] !=3D c)
> +                               return i;
> +               }
> +       }
> +
> +       return i;
> +}
> +
> +static int rb4xx_spi_msg(struct rb4xx_spi *rbspi, struct spi_message=
 *m)
> +{
> +       struct spi_transfer *t =3D NULL;
> +       void __iomem *base =3D rbspi->base;
> +
> +       m->status =3D 0;
> +       if (list_empty(&m->transfers))
> +               return -1;
> +
> +       __raw_writel(AR71XX_SPI_FS_GPIO, base + AR71XX_SPI_REG_FS);
> +       __raw_writel(SPI_CTRL_FASTEST, base + AR71XX_SPI_REG_CTRL);
> +       do_spi_init(m->spi);
> +
> +       list_for_each_entry(t, &m->transfers, transfer_list) {
> +               int len;
> +
> +               len =3D rb4xx_spi_txrx(base, t);
> +               if (len !=3D t->len) {
> +                       m->status =3D -EMSGSIZE;
> +                       break;
> +               }
> +               m->actual_length +=3D len;
> +
> +               if (t->cs_change) {
> +                       if (list_is_last(&t->transfer_list, &m->trans=
fers)) {
> +                               /* wait for continuation */
> +                               return m->spi->chip_select;
> +                       }
> +                       do_spi_finish(base);
> +                       ndelay(100);
> +               }
> +       }
> +
> +       do_spi_finish(base);
> +       __raw_writel(rbspi->spi_ctrl, base + AR71XX_SPI_REG_CTRL);
> +       __raw_writel(0, base + AR71XX_SPI_REG_FS);
> +       return -1;
> +}
> +
> +static void rb4xx_spi_process_queue_locked(struct rb4xx_spi *rbspi,
> +                                          unsigned long *flags)
> +{
> +       int cs =3D rbspi->cs_wait;
> +
> +       rbspi->busy =3D 1;
> +       while (!list_empty(&rbspi->queue)) {
> +               struct spi_message *m;
> +
> +               list_for_each_entry(m, &rbspi->queue, queue)
> +                       if (cs < 0 || cs =3D=3D m->spi->chip_select)
> +                               break;
> +
> +               if (&m->queue =3D=3D &rbspi->queue)
> +                       break;
> +
> +               list_del_init(&m->queue);
> +               spin_unlock_irqrestore(&rbspi->lock, *flags);
> +
> +               cs =3D rb4xx_spi_msg(rbspi, m);
> +               m->complete(m->context);
> +
> +               spin_lock_irqsave(&rbspi->lock, *flags);
> +       }
> +
> +       rbspi->cs_wait =3D cs;
> +       rbspi->busy =3D 0;
> +
> +       if (cs >=3D 0) {
> +               /* TODO: add timer to unlock cs after 1s inactivity *=
/
> +       }
> +}
> +
> +static int rb4xx_spi_transfer(struct spi_device *spi,
> +                             struct spi_message *m)
> +{
> +       struct rb4xx_spi *rbspi =3D spi_master_get_devdata(spi->maste=
r);
> +       unsigned long flags;
> +
> +       m->actual_length =3D 0;
> +       m->status =3D -EINPROGRESS;
> +
> +       spin_lock_irqsave(&rbspi->lock, flags);
> +       list_add_tail(&m->queue, &rbspi->queue);
> +       if (rbspi->busy ||
> +           (rbspi->cs_wait >=3D 0 && rbspi->cs_wait !=3D m->spi->chi=
p_select)) {
> +               /* job will be done later */
> +               spin_unlock_irqrestore(&rbspi->lock, flags);
> +               return 0;
> +       }
> +
> +       /* process job in current context */
> +       rb4xx_spi_process_queue_locked(rbspi, &flags);
> +       spin_unlock_irqrestore(&rbspi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +       struct rb4xx_spi *rbspi =3D spi_master_get_devdata(spi->maste=
r);
> +       unsigned long flags;
> +
> +       if (spi->mode & ~(SPI_CS_HIGH)) {
> +               dev_err(&spi->dev, "mode %x not supported\n",
> +                       (unsigned) spi->mode);

Why explicitly casted?

> +               return -EINVAL;
> +       }
> +
> +       if (spi->bits_per_word !=3D 8 && spi->bits_per_word !=3D 0) {
> +               dev_err(&spi->dev, "bits_per_word %u not supported\n"=
,
> +                       (unsigned) spi->bits_per_word);

Ditto.

> +               return -EINVAL;
> +       }
> +
> +       spin_lock_irqsave(&rbspi->lock, flags);
> +       if (rbspi->cs_wait =3D=3D spi->chip_select && !rbspi->busy) {
> +               rbspi->cs_wait =3D -1;
> +               rb4xx_spi_process_queue_locked(rbspi, &flags);
> +       }
> +       spin_unlock_irqrestore(&rbspi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static unsigned get_spi_ctrl(struct rb4xx_spi *rbspi)
> +{
> +       unsigned div;
> +
> +       div =3D (rbspi->ahb_freq - 1) / (2 * SPI_HZ);
> +
> +       /*
> +        * CPU has a bug at (div =3D=3D 0) - first bit read is random
> +        */

Would it be one line?

> +       if (div =3D=3D 0)
> +               ++div;

div++ will work as well.

> +
> +       return SPI_CTRL_FASTEST + div;
> +}
> +
> +static int rb4xx_spi_probe(struct platform_device *pdev)
> +{
> +       struct spi_master *master;
> +       struct rb4xx_spi *rbspi;
> +       struct resource *r;
> +       int err =3D 0;
> +
> +       master =3D spi_alloc_master(&pdev->dev, sizeof(*rbspi));

What if you set clock, get resources first and then allocate master?

> +       if (!master) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       master->bus_num =3D 0;
> +       master->num_chipselect =3D 3;
> +       master->setup =3D rb4xx_spi_setup;
> +       master->transfer =3D rb4xx_spi_transfer;
> +
> +       rbspi =3D spi_master_get_devdata(master);
> +
> +       rbspi->ahb_clk =3D clk_get(&pdev->dev, "ahb");

What about devm_*, here devm_clk_get()?

> +       if (IS_ERR(rbspi->ahb_clk)) {
> +               err =3D PTR_ERR(rbspi->ahb_clk);
> +               goto err_put_master;
> +       }
> +
> +       err =3D clk_enable(rbspi->ahb_clk);

Shouldn't be clk_prepare_enable()?

> +       if (err)
> +               goto err_clk_put;
> +
> +       rbspi->ahb_freq =3D clk_get_rate(rbspi->ahb_clk);
> +       if (!rbspi->ahb_freq) {
> +               err =3D -EINVAL;
> +               goto err_clk_disable;
> +       }
> +
> +       platform_set_drvdata(pdev, rbspi);
> +
> +       r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!r) {
> +               err =3D -ENOENT;
> +               goto err_clk_disable;
> +       }
> +
> +       rbspi->base =3D ioremap(r->start, r->end - r->start + 1);
> +       if (!rbspi->base) {
> +               err =3D -ENXIO;
> +               goto err_clk_disable;
> +       }

devm_ioremap_resource()

> +
> +       rbspi->master =3D master;
> +       rbspi->spi_ctrl =3D get_spi_ctrl(rbspi);
> +       rbspi->cs_wait =3D -1;
> +
> +       spin_lock_init(&rbspi->lock);
> +       INIT_LIST_HEAD(&rbspi->queue);
> +
> +       err =3D spi_register_master(master);
> +       if (err) {
> +               dev_err(&pdev->dev, "failed to register SPI master\n"=
);
> +               goto err_iounmap;
> +       }
> +
> +       return 0;
> +
> +err_iounmap:
> +       iounmap(rbspi->base);

Gone with devm_*

> +err_clk_disable:
> +       clk_disable(rbspi->ahb_clk);

clk_disable_unprepare

> +err_clk_put:
> +       clk_put(rbspi->ahb_clk);

Ditto.

> +err_put_master:
> +       platform_set_drvdata(pdev, NULL);

Not needed.

> +       spi_master_put(master);
> +err_out:
> +       return err;
> +}
> +
> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +       struct rb4xx_spi *rbspi =3D platform_get_drvdata(pdev);
> +
> +       iounmap(rbspi->base);

Will gone with devm_*.

> +       clk_disable(rbspi->ahb_clk);

clk_disable_unprepare()

> +       clk_put(rbspi->ahb_clk);

Ditto.

> +       platform_set_drvdata(pdev, NULL);

Not needed.

> +       spi_master_put(rbspi->master);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver rb4xx_spi_drv =3D {
> +       .probe          =3D rb4xx_spi_probe,
> +       .remove         =3D rb4xx_spi_remove,
> +       .driver         =3D {
> +               .name   =3D DRV_NAME,
> +               .owner  =3D THIS_MODULE,

Not needed.

> +       },
> +};
> +
> +static int __init rb4xx_spi_init(void)
> +{
> +       return platform_driver_register(&rb4xx_spi_drv);
> +}
> +subsys_initcall(rb4xx_spi_init);
> +
> +static void __exit rb4xx_spi_exit(void)
> +{
> +       platform_driver_unregister(&rb4xx_spi_drv);
> +}
> +
> +module_exit(rb4xx_spi_exit);
> +
> +MODULE_DESCRIPTION(DRV_DESC);
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_AUTHOR("Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
