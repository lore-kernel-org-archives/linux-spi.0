From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev: fix hang when transfer_one_message fails
Date: Thu, 23 Jan 2014 17:47:02 +0100
Message-ID: <CAMuHMdU0FRi4=YejN+3TLJCwcptHVaaGFTLPyuwzO4NH9=-cUw@mail.gmail.com>
References: <1388965166-27334-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388965166-27334-1-git-send-email-daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 6, 2014 at 12:39 AM,  <danielfsantos-fOdFMYwuEsI@public.gmane.org> wrote:
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -735,7 +735,9 @@ static void spi_pump_messages(struct kthread_work *work)
>         ret = master->transfer_one_message(master, master->cur_msg);
>         if (ret) {
>                 dev_err(&master->dev,
> -                       "failed to transfer one message from queue\n");
> +                       "failed to transfer one message from queue: %d\n", ret);
> +               master->cur_msg->status = ret;

This crashes with drivers using the generic spi_transfer_one_message(),
which always calls spi_finalize_current_message(), which zeroes
master->cur_msg:

spi_master spi0: failed to transfer one message from queue: -110
spi_pump_messages:748 master = ef3d8c00
spi_pump_messages:749 master->cur_msg =   (null)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
pgd = c0004000
[00000020] *pgd=00000000
Internal error: Oops: 817 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 30 Comm: spi0 Not tainted
3.13.0-koelsch-00403-gecb6e4e65dea-dirty #274
task: ef250bc0 ti: ef3f0000 task.ti: ef3f0000
PC is at spi_pump_messages+0x22c/0x288
LR is at irq_work_queue+0x6c/0xcc

Probably your transfer_one_message() forgot to call
spi_finalize_current_message()? Is this allowed in case of failure?

 * @transfer_one_message: the subsystem calls the driver to transfer a single
 *      message while queuing transfers that arrive in the meantime. When the
 *      driver is finished with this message, it must call
 *      spi_finalize_current_message() so the subsystem can issue the next
 *      transfer

Alternatively, we need a check for master->cur_msg here.

> +               spi_finalize_current_message(master);
>                 return;
>         }
>  }

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
