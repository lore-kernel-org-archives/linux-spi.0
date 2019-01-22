From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 22 Jan 2019 10:36:50 +0100
Message-ID: <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 14, 2019 at 4:36 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> I have noticed that system suspend has started failing consistently on a
> couple Tegra boards over the last few days with the linux-next branch.
> The following error is seen on on entering suspend ...
>
> [   58.222033] spi_master spi1: could not stop message queue
> [   58.222038] spi_master spi1: queue stop failed
> [   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
> [   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
> [   58.222057] PM: Some devices failed to suspend, or early wake event detected
>
> Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
> waking pump thread from spi_sync instead run teardown delayed") and
> reverting this on top of -next fixes the problem. I have not had chance
> to dig any further but wanted to report this issue to see if you have
> any thoughts.

I can confirm this on r8a7791/koelsch:

    PM: suspend entry (deep)
    PM: Syncing filesystems ... done.
    Freezing user space processes ... (elapsed 0.010 seconds) done.
    OOM killer disabled.
    Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
    spi_master spi0: could not stop message queue
    spi_master spi0: queue stop failed
    dpm_run_callback(): rspi_suspend+0x0/0xc returns -16
    PM: Device e6b10000.spi failed to suspend: error -16
    PM: Some devices failed to suspend, or early wake event detected

In addition, after boot, when the QSPI device is idle (the only activity
was the initial probe), the device is no longer runtime-suspended, as
witnessed by the following change to
/sys/kernel/debug/pm_genpd/pm_genpd_summary:

    -    /devices/platform/soc/e6b10000.spi                  suspended
    +    /devices/platform/soc/e6b10000.spi                  active

and by the following change to /sys/kernel/debug/clk/clk_summary:

    -             qspi                     0        1        0
97500000          0     0  50000
    -                qspi_mod              0        1        0
97500000          0     0  50000
    +             qspi                     1        1        0
97500000          0     0  50000
    +                qspi_mod              1        1        0
97500000          0     0  50000

Reverting 412e60373245 also fixes that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
