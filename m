From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Wed, 23 Jan 2019 09:26:48 +0100
Message-ID: <47b23e55-11b7-3d44-d611-8d6120139d5c@samsung.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
        <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
        <CGME20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi All

On 2019-01-22 10:36, Geert Uytterhoeven wrote:
> On Mon, Jan 14, 2019 at 4:36 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>> I have noticed that system suspend has started failing consistently on a
>> couple Tegra boards over the last few days with the linux-next branch.
>> The following error is seen on on entering suspend ...
>>
>> [   58.222033] spi_master spi1: could not stop message queue
>> [   58.222038] spi_master spi1: queue stop failed
>> [   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
>> [   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
>> [   58.222057] PM: Some devices failed to suspend, or early wake event detected
>>
>> Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
>> waking pump thread from spi_sync instead run teardown delayed") and
>> reverting this on top of -next fixes the problem. I have not had chance
>> to dig any further but wanted to report this issue to see if you have
>> any thoughts.
> I can confirm this on r8a7791/koelsch:
>
>     PM: suspend entry (deep)
>     PM: Syncing filesystems ... done.
>     Freezing user space processes ... (elapsed 0.010 seconds) done.
>     OOM killer disabled.
>     Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
>     spi_master spi0: could not stop message queue
>     spi_master spi0: queue stop failed
>     dpm_run_callback(): rspi_suspend+0x0/0xc returns -16
>     PM: Device e6b10000.spi failed to suspend: error -16
>     PM: Some devices failed to suspend, or early wake event detected

With recent linux-next I've got a similar issue on Samsung Exynos based
Chromebooks: Peach-Pit and Peach-Pi, both using SPI for communicating
with regulators via chrome EC bridge:

PM: suspend entry (deep)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
printk: Suspending console(s) (use no_console_suspend to debug)
...
spi_master spi2: could not stop message queue
spi_master spi2: queue stop failed
dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
PM: Device 12d40000.spi failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
