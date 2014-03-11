From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] spi: rspi: Add runtime PM support, using spi core auto_runtime_pm
Date: Tue, 11 Mar 2014 14:10:31 +0100
Message-ID: <CAMuHMdWoPWebnyUu2uGebbnzu68Lh4qsgzpu-otnwMmvaeY1hQ@mail.gmail.com>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
	<1394531952-3905-3-git-send-email-geert@linux-m68k.org>
	<20140311104713.GN28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140311104713.GN28112@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Tue, Mar 11, 2014 at 11:47 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 11, 2014 at 10:59:12AM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> Applied, thanks, though...
>
>> -     ret = clk_prepare_enable(rspi->clk);
>> -     if (ret < 0) {
>> -             dev_err(&pdev->dev, "unable to prepare/enable clock\n");
>> -             goto error1;
>> -     }
>> +     pm_runtime_enable(&pdev->dev);
>
> ...due to the runtime PM API being configurable you're supposed to start
> off with the device runtime enabled (this applies to some of the other
> patches too).  I'm not sure that's terribly realistic for these drivers
> though.

Can you please elaborate what should be fixed?

If I disable CONFIG_PM_RUNTIME, the kernel prints:

    Runtime PM disabled, clock forced on.

and the clock is enabled all the time (verified by looking at the clock
registers)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
