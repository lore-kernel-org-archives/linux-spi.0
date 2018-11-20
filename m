From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Tue, 20 Nov 2018 09:01:29 +0100
Message-ID: <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw> <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, Nov 19, 2018 at 11:01 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car D3 RPC SPI controller driver.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,750 @@

> +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> +{
> +       int ret;
> +
> +       if (rpc->cur_speed_hz == freq)
> +               return 0;
> +
> +       clk_disable_unprepare(rpc->clk_rpc);
> +       ret = clk_set_rate(rpc->clk_rpc, freq);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(rpc->clk_rpc);
> +       if (ret)
> +               return ret;

The clk_{disable_unprepare,prepare_enable}() may be needed on the Macronix
controller you based this driver on, but will be futile on Renesas SoCs.

As the RPC is part of the CPG/MSSR clock domain, its clock will be controlled
by the Runtime PM.  As you've already called pm_runtime_get_sync() from your
.probe() calback, Runtime PM will have enabled the clock.
If you disable it manually, you create an imbalance between automatic and
manual clock control.

So please don't control the clock explicitly, but always use
pm_runtime_*() calls.

> +static int __maybe_unused rpc_spi_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +
> +       clk_disable_unprepare(rpc->clk_rpc);

At this point, the clock is enabled due to Runtime PM, and you disable it
manually.
During system suspend, the clock will be disabled by the PM framework
again, leading to a negative enable count.
I expect you to see warning splats during system suspend.
Hence please drop the explicit clock management from this function.

I'm not familiar with the spimem framework, but for a normal SPI controller,
you want to call spi_master_resume(master) here.
See e.g. commit c1ca59c22c56930b ("spi: rspi: Fix invalid SPI use during
system suspend")

> +
> +       return 0;
> +}
> +
> +static int __maybe_unused rpc_spi_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = clk_prepare_enable(rpc->clk_rpc);
> +       if (ret)
> +               dev_err(dev, "Can't enable rpc->clk_rpc\n");

Likewise, please drop the explicit clock management here. The PM core
code will handle it through the clock domain.

+ spi_master_resume(master)

> +
> +       return ret;
> +}
> +
> +static const struct dev_pm_ops rpc_spi_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(rpc_spi_runtime_suspend,
> +                          rpc_spi_runtime_resume, NULL)

Ah, you only use these for Runtime PM.  Not needed, as Runtime PM handles
the clock domain without any callbacks.

With spi_master_{suspend,resume}() added, you can use SIMPLE_DEV_PM_OPS(),
and make everything work during/after system suspend.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
