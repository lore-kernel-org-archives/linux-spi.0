From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Tue, 20 Nov 2018 09:10:52 +0100
Message-ID: <20181120091052.096ab7e3@bbrezillon>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
        <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
        <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: masonccyang@mxic.com.tw, Mark Brown <broonie@kernel.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 20 Nov 2018 09:01:29 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > --- /dev/null
> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,750 @@  
> 
> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> > +{
> > +       int ret;
> > +
> > +       if (rpc->cur_speed_hz == freq)
> > +               return 0;
> > +
> > +       clk_disable_unprepare(rpc->clk_rpc);
> > +       ret = clk_set_rate(rpc->clk_rpc, freq);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = clk_prepare_enable(rpc->clk_rpc);
> > +       if (ret)
> > +               return ret;  
> 
> The clk_{disable_unprepare,prepare_enable}() may be needed on the Macronix
> controller you based this driver on, but will be futile on Renesas SoCs.
> 
> As the RPC is part of the CPG/MSSR clock domain, its clock will be controlled
> by the Runtime PM.  As you've already called pm_runtime_get_sync() from your
> .probe() calback, Runtime PM will have enabled the clock.
> If you disable it manually, you create an imbalance between automatic and
> manual clock control.
> 
> So please don't control the clock explicitly, but always use
> pm_runtime_*() calls.

More about that. The reason we did that on MXIC is that the clk rate
can't be changed when the clk is enabled. So we have to

1/ explicitly disable the clk that has been enabled by runtime PM
2/ set the new rate
3/ re-enable the clk

So the clk enable/disable are not unbalanced, but it's also true that
this disable/set_rate/enable dance might be unneeded on your platform.
