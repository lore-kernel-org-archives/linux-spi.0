From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 16:46:45 +0200
Message-ID: <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
References: <20181003123328.GA29471@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: gustavo@embeddedor.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003123328.GA29471@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Gustavo,

On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Apparently, this code does not actually fall through to the next case
> because the machine restarts before it has a chance. However, for the
> sake of maintenance and readability, we better add the missing break
> statement.
>
> Addresses-Coverity-ID: 1437892 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-slave-system-control.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
> index c0257e9..169f3d5 100644
> --- a/drivers/spi/spi-slave-system-control.c
> +++ b/drivers/spi/spi-slave-system-control.c
> @@ -60,6 +60,7 @@ static void spi_slave_system_control_complete(void *arg)
>         case CMD_REBOOT:
>                 dev_info(&priv->spi->dev, "Rebooting system...\n");
>                 kernel_restart(NULL);
> +               break;
>
>         case CMD_POWEROFF:
>                 dev_info(&priv->spi->dev, "Powering off system...\n");

Alternatively, kernel_restart() and friends could be marked __noreturn.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
