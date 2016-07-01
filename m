From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Thu, 30 Jun 2016 21:23:26 -0700
Message-ID: <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467258867-117727-1-git-send-email-apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Andrey,

On Wed, Jun 29, 2016 at 8:54 PM,  <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Some SPI devices may go to sleep after a period of inactivity
> on SPI. For such devices, if enough time has passed since the
> last SPI transaction, toggle CS and wait for the device to
> start before communicating with it.
>
> Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/spi/spi.c       | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h | 17 +++++++++++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 77e6e45..c51c864 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -700,6 +700,20 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
>                 spi->master->set_cs(spi, !enable);
>  }
>
> +static void spi_cs_wake_timer_func(unsigned long arg)
> +{
> +       struct spi_device *spi = (struct spi_device *)arg;
> +
> +       spi->cs_wake_needed = true;

Don't you need some type of lock?  If nothing else you might run into
weakly ordered memory issues and so the write you doing here might not
take effect right away.  Seems like you need _something_ other than
just a simple assignment here, but maybe I'm mixed up.

Also, something doesn't seem terribly robust about this, buy maybe I'm
being paranoid.  If something happens where the timer hasn't fired
quickly enough then you might not know that you need to assert the
wakeup, right?  I don't think there's a 100% guarantee that a timer
will fire and finish running within a certain period of time, is
there?


> +}
> +
> +static void spi_reset_cs_wake_timer(struct spi_device *spi)
> +{
> +       spi->cs_wake_needed = false;
> +       mod_timer(&spi->cs_wake_timer,
> +                 jiffies + spi->cs_sleep_jiffies);

Seems like a race here, right?  If you set:

spi->cs_wake_needed = false;

...and then the timer fires, it will be set to "true" and then you'll
call your mod_timer().  That seems bad, right?


Also: is it valid for spi->cs_sleep_jiffies to be 0 (if the device
might go to sleep in < 1 jiffy of activity?).  Does that work OK?

> +}
> +
>  #ifdef CONFIG_HAS_DMA
>  static int spi_map_buf(struct spi_master *master, struct device *dev,
>                        struct sg_table *sgt, void *buf, size_t len,
> @@ -948,6 +962,15 @@ static int spi_transfer_one_message(struct spi_master *master,
>         struct spi_statistics *statm = &master->statistics;
>         struct spi_statistics *stats = &msg->spi->statistics;
>
> +       if (msg->spi->cs_wake_after_sleep && msg->spi->cs_wake_needed) {

Do you need to think about keep_cs here?  Said another way: what
happens if you haven't communicated for a while but the last
communication left the cs asserted?  Seems like in that case you
wouldn't need to wake the device up, right?


> +               dev_info(&msg->spi->dev, "waking after possible sleep\n");

dev_info seems awfully spammy.  deb_dbg()?

> +               spi_set_cs(msg->spi, true);
> +               mdelay(1);

Why 1 millisecond?

> +               spi_set_cs(msg->spi, false);
> +               msleep(msg->spi->cs_wake_duration);
> +               spi_reset_cs_wake_timer(msg->spi);
> +       }
> +
>         spi_set_cs(msg->spi, true);
>
>         SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
> @@ -1024,6 +1047,9 @@ out:
>         if (ret != 0 || !keep_cs)
>                 spi_set_cs(msg->spi, false);
>
> +       if (msg->spi->cs_wake_after_sleep && !ret)
> +               spi_reset_cs_wake_timer(msg->spi);
> +
>         if (msg->status == -EINPROGRESS)
>                 msg->status = ret;
>
> @@ -1551,6 +1577,45 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
>         }
>         spi->max_speed_hz = value;
>
> +       /* Do we need to assert CS to wake the device after sleep */
> +       spi->cs_wake_after_sleep =
> +               of_property_read_bool(nc, "cs-wake-after-sleep");
> +       if (spi->cs_wake_after_sleep) {
> +               dev_info(&master->dev, "cs-wake-after-sleep enabled\n");

Again, probably too spammy.  dev_dbg()

> +
> +               /* After what delay device goes to sleep */
> +               rc = of_property_read_u32(nc, "cs-sleep-delay", &value);
> +               if (rc) {
> +                       dev_err(&master->dev,
> +                               "%s has no valid 'cs-sleep-delay' property (%d)\n",
> +                               nc->full_name, rc);
> +                       goto err_out;
> +               }
> +               spi->cs_sleep_jiffies = value * HZ / 1000; /* jiffies */

Explain why you're not using msecs_to_jiffies() here?  Presumably
because you want to round down?

BTW: why do you need the "jiffies" comment?

> +
> +               /* How long to wait after waking */
> +               rc = of_property_read_u32(nc, "cs-wake-duration", &value);
> +               if (rc) {
> +                       dev_err(&master->dev,
> +                               "%s has no valid 'cs-wake-duration' property (%d)\n",
> +                               nc->full_name, rc);
> +                       goto err_out;
> +               }
> +               spi->cs_wake_duration = value; /* msec */

Why not name it "cs_wake_ms" and get rid of the "msec" comment?


> +               /* Wake before accessing for the 1st time */
> +               spi->cs_wake_needed = true;
> +               init_timer(&spi->cs_wake_timer);
> +               spi->cs_wake_timer.data = (unsigned long)spi;
> +               spi->cs_wake_timer.function = spi_cs_wake_timer_func;
> +       }
> +
> +       /* Should there be a delay before each transfer */
> +       spi->xfer_delay = 0;
> +       of_property_read_u32(nc, "xfer-delay", &spi->xfer_delay);
> +       if (spi->xfer_delay)
> +               dev_info(&master->dev, "xfer-delay = %u\n", spi->xfer_delay);
> +

Isn't xfer_delay part of another patch in this series?

>         /* Store a pointer to the node in the device structure */
>         of_node_get(nc);
>         spi->dev.of_node = nc;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 1f03483..4b06ba6 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -126,6 +126,17 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
>   *     when not using a GPIO line)
>   *
> + * @cs_wake_after_sleep: Briefly toggle CS before talking to a device
> + *     if it could go to sleep.
> + * @cs_sleep_jiffies: Delay after which a device may go to sleep if there
> + *     was no SPI activity for it (jiffies).
> + * @cs_wake_duration: Delay after waking the device by toggling CS before
> + *     it is ready (msec).
> + * @cs_wake_needed: Is the wake needed (cs_sleep_jiffies passed since
> + *     the last SPI transaction).
> + * @cs_wake_timer: Timer measuring the delay before the device goes to
> + *     sleep after the last SPI transaction.
> + *
>   * @statistics: statistics for the spi_device
>   *
>   * A @spi_device is used to interchange data between an SPI slave
> @@ -166,6 +177,12 @@ struct spi_device {
>         char                    modalias[SPI_NAME_SIZE];
>         int                     cs_gpio;        /* chip select gpio */
>
> +       bool                    cs_wake_after_sleep;
> +       unsigned long           cs_sleep_jiffies;
> +       unsigned long           cs_wake_duration;
> +       bool                    cs_wake_needed;
> +       struct timer_list       cs_wake_timer;

Tiny nit: group bools together and get a slightly more optimal
structure packing?

> +
>         /* the statistics */
>         struct spi_statistics   statistics;
>
> --
> 2.6.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
