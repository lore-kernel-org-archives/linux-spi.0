From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 6/6] spi: slave: Add SPI slave handler controlling
 system state
Date: Mon, 22 May 2017 20:59:46 +0300
Message-ID: <CAHp75VemBR5S9YJPP9YZHyhpGG+CrBDuk19V5vy0qMqfEUJO0w@mail.gmail.com>
References: <1495458705-11692-1-git-send-email-geert+renesas@glider.be> <1495458705-11692-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495458705-11692-7-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 22, 2017 at 4:11 PM, Geert Uytterhoeven
<geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
> Add an example SPI slave handler to allow remote control of system
> reboot, power off, halt, and suspend.
>

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v5:
>   - Add usage documentation to file header,
>   - Use network byte order for commands, to match the "-p" parameter of
>     spidev_test,
>   - Replace pr_*() by dev_*(), stop printing __func__,
>   - Remove spi_setup() call to configure 8 bits per word, as that's the
>     default,
>
> v3, v4:
>   - No changes,
>
> v2:
>   - Use spi_async() instead of spi_read(),
>   - Submit the next transfer from the previous transfer's completion
>     callback, removing the need for a thread,
>   - Let .remove() call spi_slave_abort() to cancel the current ongoing
>     transfer, and wait for the completion to terminate,
>   - Remove FIXME about hanging kthread_stop(),
>   - Fix copy-and-pasted module description.
> ---
>  drivers/spi/Kconfig                    |   6 ++
>  drivers/spi/Makefile                   |   1 +
>  drivers/spi/spi-slave-system-control.c | 154 +++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/spi/spi-slave-system-control.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9972ee2a8454a2fc..82cd818aa06293f5 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -803,6 +803,12 @@ config SPI_SLAVE_TIME
>           SPI slave handler responding with the time of reception of the last
>           SPI message.
>
> +config SPI_SLAVE_SYSTEM_CONTROL
> +       tristate "SPI slave handler controlling system state"
> +       help
> +         SPI slave handler to allow remote control of system reboot, power
> +         off, halt, and suspend.
> +
>  endif # SPI_SLAVE
>
>  endif # SPI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index fb078693dbe40da4..1d7923e8c63bc22b 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -108,3 +108,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)              += spi-zynqmp-gqspi.o
>
>  # SPI slave protocol handlers
>  obj-$(CONFIG_SPI_SLAVE_TIME)           += spi-slave-time.o
> +obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL) += spi-slave-system-control.o
> diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
> new file mode 100644
> index 0000000000000000..c0257e937995ec53
> --- /dev/null
> +++ b/drivers/spi/spi-slave-system-control.c
> @@ -0,0 +1,154 @@
> +/*
> + * SPI slave handler controlling system state
> + *
> + * This SPI slave handler allows remote control of system reboot, power off,
> + * halt, and suspend.
> + *
> + * Copyright (C) 2016-2017 Glider bvba
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Usage (assuming /dev/spidev2.0 corresponds to the SPI master on the remote
> + * system):
> + *
> + *   # reboot='\x7c\x50'
> + *   # poweroff='\x71\x3f'
> + *   # halt='\x38\x76'
> + *   # suspend='\x1b\x1b'
> + *   # spidev_test -D /dev/spidev2.0 -p $suspend # or $reboot, $poweroff, $halt
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/suspend.h>
> +#include <linux/spi/spi.h>
> +
> +/*
> + * The numbers are chosen to display something human-readable on two 7-segment
> + * displays connected to two 74HC595 shift registers
> + */
> +#define CMD_REBOOT     0x7c50  /* rb */
> +#define CMD_POWEROFF   0x713f  /* OF */
> +#define CMD_HALT       0x3876  /* HL */
> +#define CMD_SUSPEND    0x1b1b  /* ZZ */
> +
> +struct spi_slave_system_control_priv {
> +       struct spi_device *spi;
> +       struct completion finished;
> +       struct spi_transfer xfer;
> +       struct spi_message msg;
> +       __be16 cmd;
> +};
> +
> +static
> +int spi_slave_system_control_submit(struct spi_slave_system_control_priv *priv);
> +
> +static void spi_slave_system_control_complete(void *arg)
> +{
> +       struct spi_slave_system_control_priv *priv = arg;
> +       u16 cmd;
> +       int ret;
> +
> +       if (priv->msg.status)
> +               goto terminate;
> +
> +       cmd = be16_to_cpu(priv->cmd);
> +       switch (cmd) {
> +       case CMD_REBOOT:
> +               dev_info(&priv->spi->dev, "Rebooting system...\n");
> +               kernel_restart(NULL);
> +
> +       case CMD_POWEROFF:
> +               dev_info(&priv->spi->dev, "Powering off system...\n");
> +               kernel_power_off();
> +               break;
> +
> +       case CMD_HALT:
> +               dev_info(&priv->spi->dev, "Halting system...\n");
> +               kernel_halt();
> +               break;
> +
> +       case CMD_SUSPEND:
> +               dev_info(&priv->spi->dev, "Suspending system...\n");
> +               pm_suspend(PM_SUSPEND_MEM);
> +               break;
> +
> +       default:
> +               dev_warn(&priv->spi->dev, "Unknown command 0x%x\n", cmd);
> +               break;
> +       }
> +
> +       ret = spi_slave_system_control_submit(priv);
> +       if (ret)
> +               goto terminate;
> +
> +       return;
> +
> +terminate:
> +       dev_info(&priv->spi->dev, "Terminating\n");
> +       complete(&priv->finished);
> +}
> +
> +static
> +int spi_slave_system_control_submit(struct spi_slave_system_control_priv *priv)
> +{
> +       int ret;
> +
> +       spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
> +
> +       priv->msg.complete = spi_slave_system_control_complete;
> +       priv->msg.context = priv;
> +
> +       ret = spi_async(priv->spi, &priv->msg);
> +       if (ret)
> +               dev_err(&priv->spi->dev, "spi_async() failed %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int spi_slave_system_control_probe(struct spi_device *spi)
> +{
> +       struct spi_slave_system_control_priv *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->spi = spi;
> +       init_completion(&priv->finished);
> +       priv->xfer.rx_buf = &priv->cmd;
> +       priv->xfer.len = sizeof(priv->cmd);
> +
> +       ret = spi_slave_system_control_submit(priv);
> +       if (ret)
> +               return ret;
> +
> +       spi_set_drvdata(spi, priv);
> +       return 0;
> +}
> +
> +static int spi_slave_system_control_remove(struct spi_device *spi)
> +{
> +       struct spi_slave_system_control_priv *priv = spi_get_drvdata(spi);
> +
> +       spi_slave_abort(spi);
> +       wait_for_completion(&priv->finished);
> +       return 0;
> +}
> +
> +static struct spi_driver spi_slave_system_control_driver = {
> +       .driver = {
> +               .name   = "spi-slave-system-control",
> +       },
> +       .probe          = spi_slave_system_control_probe,
> +       .remove         = spi_slave_system_control_remove,
> +};
> +module_spi_driver(spi_slave_system_control_driver);
> +
> +MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>");
> +MODULE_DESCRIPTION("SPI slave handler controlling system state");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
