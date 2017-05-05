From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 4/6] spi: sh-msiof: Add slave mode support
Date: Fri, 5 May 2017 11:42:15 +0200
Message-ID: <CAMuHMdUBXtsLZYDx6Lbabp=qAnpWMbo3N6z0CMYd=YP=wJdmXg@mail.gmail.com>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be> <1493919951-32122-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wu Fengguang <fengguang.wu@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1493919951-32122-5-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 4, 2017 at 7:45 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Add slave mode support to the MSIOF driver, in both PIO and DMA mode.
>
> For now this only supports the transmission of messages with a size
> that is known in advance.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> [geert: Timeout handling cleanup, spi core integration, cancellation,
>         rewording]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> index 2ce15ca977828668..7c4e8c4f3a9bddfd 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c

> +static int sh_msiof_slave_abort(struct spi_master *master)
> +{
> +       struct sh_msiof_spi_priv *p = spi_master_get_devdata(master);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&p->done.wait.lock, flags);
> +       if (!p->done.done) {
> +               wait_queue_t *curr, *next;
> +
> +               list_for_each_entry_safe(curr, next, &p->done.wait.task_list,
> +                                        task_list) {
> +                       signal_wake_up(curr->private, 1);

0day reported a build failure in the modular case (thanks!):

    ERROR: "signal_wake_up_state" [drivers/spi/spi-sh-msiof.ko] undefined!

signal_wake_up() is a static inline function calling signal_wake_up_state(),
but the latter is not exported to modules.

I'll bring it up with the scheduler people...

> +                       break;
> +               }
> +       }
> +       spin_unlock_irqrestore(&p->done.wait.lock, flags);
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
