From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 5/6] spi: slave: Add SPI slave handler reporting uptime
 at previous message
Date: Mon, 22 May 2017 20:58:30 +0300
Message-ID: <CAHp75VcxtNrWCUjBsCtkuyaQy=gXLwHf+CQojxcbWxbtGbGJ8g@mail.gmail.com>
References: <1495458705-11692-1-git-send-email-geert+renesas@glider.be> <1495458705-11692-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1495458705-11692-6-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 22, 2017 at 4:11 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add an example SPI slave handler responding with the uptime at the time
> of reception of the last SPI message.
>
> This can be used by an external microcontroller as a dead man's switch.
>

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - Add usage documentation to file header,
>   - Replace pr_*() by dev_*(), stop printing __func__,
>   - Rename rem_ns to rem_us, as the remainder is in microseconds,
>   - Remove spi_setup() call to configure 8 bits per word, as that's the
>     default,
>
> v4:
>   - No changes,
>
> v3:
>   - Add #include <linux/sched/clock.h>,
>
> v2:
>   - Resolve semantic differences in patch description, file header, and
>     module description,
>   - Use spi_async() instead of spi_read(),
>   - Submit the next transfer from the previous transfer's completion
>     callback, removing the need for a thread,
>   - Let .remove() call spi_slave_abort() to cancel the current ongoing
>     transfer, and wait for the completion to terminate,
>   - Remove FIXME about hanging kthread_stop().
> ---
>  drivers/spi/Kconfig          |   6 ++
>  drivers/spi/Makefile         |   1 +
>  drivers/spi/spi-slave-time.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/spi/spi-slave-time.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f21499b1f71ab7c3..9972ee2a8454a2fc 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -797,6 +797,12 @@ config SPI_SLAVE
>
>  if SPI_SLAVE
>
> +config SPI_SLAVE_TIME
> +       tristate "SPI slave handler reporting boot up time"
> +       help
> +         SPI slave handler responding with the time of reception of the last
> +         SPI message.
> +
>  endif # SPI_SLAVE
>
>  endif # SPI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index e50852c6fcb87d8b..fb078693dbe40da4 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -107,3 +107,4 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)             += spi-xtensa-xtfpga.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)         += spi-zynqmp-gqspi.o
>
>  # SPI slave protocol handlers
> +obj-$(CONFIG_SPI_SLAVE_TIME)           += spi-slave-time.o
> diff --git a/drivers/spi/spi-slave-time.c b/drivers/spi/spi-slave-time.c
> new file mode 100644
> index 0000000000000000..f2e07a392d6863ea
> --- /dev/null
> +++ b/drivers/spi/spi-slave-time.c
> @@ -0,0 +1,129 @@
> +/*
> + * SPI slave handler reporting uptime at reception of previous SPI message
> + *
> + * This SPI slave handler sends the time of reception of the last SPI message
> + * as two 32-bit unsigned integers in binary format and in network byte order,
> + * representing the number of seconds and fractional seconds (in microseconds)
> + * since boot up.
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
> + *   # spidev_test -D /dev/spidev2.0 -p dummy-8B
> + *   spi mode: 0x0
> + *   bits per word: 8
> + *   max speed: 500000 Hz (500 KHz)
> + *   RX | 00 00 04 6D 00 09 5B BB ...
> + *             ^^^^^    ^^^^^^^^
> + *             seconds  microseconds
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/module.h>
> +#include <linux/sched/clock.h>
> +#include <linux/spi/spi.h>
> +
> +
> +struct spi_slave_time_priv {
> +       struct spi_device *spi;
> +       struct completion finished;
> +       struct spi_transfer xfer;
> +       struct spi_message msg;
> +       __be32 buf[2];
> +};
> +
> +static int spi_slave_time_submit(struct spi_slave_time_priv *priv);
> +
> +static void spi_slave_time_complete(void *arg)
> +{
> +       struct spi_slave_time_priv *priv = arg;
> +       int ret;
> +
> +       ret = priv->msg.status;
> +       if (ret)
> +               goto terminate;
> +
> +       ret = spi_slave_time_submit(priv);
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
> +static int spi_slave_time_submit(struct spi_slave_time_priv *priv)
> +{
> +       u32 rem_us;
> +       int ret;
> +       u64 ts;
> +
> +       ts = local_clock();
> +       rem_us = do_div(ts, 1000000000) / 1000;
> +
> +       priv->buf[0] = cpu_to_be32(ts);
> +       priv->buf[1] = cpu_to_be32(rem_us);
> +
> +       spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
> +
> +       priv->msg.complete = spi_slave_time_complete;
> +       priv->msg.context = priv;
> +
> +       ret = spi_async(priv->spi, &priv->msg);
> +       if (ret)
> +               dev_err(&priv->spi->dev, "spi_async() failed %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int spi_slave_time_probe(struct spi_device *spi)
> +{
> +       struct spi_slave_time_priv *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->spi = spi;
> +       init_completion(&priv->finished);
> +       priv->xfer.tx_buf = priv->buf;
> +       priv->xfer.len = sizeof(priv->buf);
> +
> +       ret = spi_slave_time_submit(priv);
> +       if (ret)
> +               return ret;
> +
> +       spi_set_drvdata(spi, priv);
> +       return 0;
> +}
> +
> +static int spi_slave_time_remove(struct spi_device *spi)
> +{
> +       struct spi_slave_time_priv *priv = spi_get_drvdata(spi);
> +
> +       spi_slave_abort(spi);
> +       wait_for_completion(&priv->finished);
> +       return 0;
> +}
> +
> +static struct spi_driver spi_slave_time_driver = {
> +       .driver = {
> +               .name   = "spi-slave-time",
> +       },
> +       .probe          = spi_slave_time_probe,
> +       .remove         = spi_slave_time_remove,
> +};
> +module_spi_driver(spi_slave_time_driver);
> +
> +MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
> +MODULE_DESCRIPTION("SPI slave reporting uptime at previous SPI message");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
