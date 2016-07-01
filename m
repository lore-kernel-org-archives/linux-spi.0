From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add option to insert delay between transactions
Date: Thu, 30 Jun 2016 21:44:37 -0700
Message-ID: <CAD=FV=Xv0zy-bGhD8sdtJOruiyMNpL1a8y6usQSjk1jpU9jisQ@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org> <1467258867-117727-3-git-send-email-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467258867-117727-3-git-send-email-apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Wed, Jun 29, 2016 at 8:54 PM,  <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Some devices may need CS to be deasserted for some time
> between transactions. Added a new capability to guarantee
> a delay between SPI transactions for the device.
>
> Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/spi/spi.c       | 3 +++
>  include/linux/spi/spi.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c51c864..639c7bd 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -971,6 +971,9 @@ static int spi_transfer_one_message(struct spi_master *master,
>                 spi_reset_cs_wake_timer(msg->spi);
>         }
>
> +       if (msg->spi->xfer_delay)
> +               mdelay(msg->spi->xfer_delay);
> +

Sounds like you're generalizing "EC_SPI_RECOVERY_TIME_NS" from the
cros EC code.  That code actually keeps track of the end of the last
transfer and only delays as much as needed.

Also note that time is in NS, which seems like a more appropriate time
scale.  Even if the hardware you're talking to needs many milliseconds
to recover, there might be some that need only a few ns.


>         spi_set_cs(msg->spi, true);
>
>         SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4b06ba6..4b1aa13 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -137,6 +137,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   * @cs_wake_timer: Timer measuring the delay before the device goes to
>   *     sleep after the last SPI transaction.
>   *
> + * @xfer_delay: Delay between SPI transactions (msec).
> + *
>   * @statistics: statistics for the spi_device
>   *
>   * A @spi_device is used to interchange data between an SPI slave
> @@ -183,6 +185,8 @@ struct spi_device {
>         bool                    cs_wake_needed;
>         struct timer_list       cs_wake_timer;
>
> +       u32                     xfer_delay;
> +
>         /* the statistics */
>         struct spi_statistics   statistics;

As mentioned in the other patch, some of your code is missing and is
in patch #1.

-Doug
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
