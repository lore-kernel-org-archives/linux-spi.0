From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Fri, 31 Jan 2014 08:49:45 +0100
Message-ID: <CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391121536-10937-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Jan 30, 2014 at 11:38 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Don't wait indefinitely for transfers to complete but time out after 10ms
> more than we expect the transfer to take on the wire.
>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 7f23cf9afa79..1826a50c2aaf 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -710,6 +710,7 @@ static int spi_transfer_one_message(struct spi_master *master,
>         bool cur_cs = true;
>         bool keep_cs = false;
>         int ret = 0;
> +       int ms = 1;
>
>         spi_set_cs(msg->spi, true);
>
> @@ -727,7 +728,16 @@ static int spi_transfer_one_message(struct spi_master *master,
>
>                 if (ret > 0) {
>                         ret = 0;
> -                       wait_for_completion(&master->xfer_completion);
> +                       ms = xfer->len * 8 * 1000 / xfer->speed_hz;
> +                       ms += 10; /* some tolerance */
> +
> +                       ms = wait_for_completion_timeout(&master->xfer_completion,
> +                                                        msecs_to_jiffies(ms));
> +               }
> +
> +               if (ms == 0) {
> +                       dev_err(&msg->spi->dev, "SPI transfer timed out\n");
> +                       msg->status = -ETIMEDOUT;
>                 }
>
>                 trace_spi_transfer_stop(msg, xfer);

What if it still completes in the driver a little bit later? The
driver will also call
spi_finalize_current_message(), and we'll get a NULL pointer dereference
as master->cur_msg is now NULL.

So I think we need a check like (whitespace damaged) below:

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -829,6 +829,9 @@ void spi_finalize_current_message(struct spi_master *master)
          queue_kthread_work(&master->kworker, &master->pump_messages);
          spin_unlock_irqrestore(&master->queue_lock, flags);

+         if (!mesg)
+                 return NULL;
+
          if (master->cur_msg_prepared && master->unprepare_message) {
                  ret = master->unprepare_message(master, mesg);
          if (ret) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
