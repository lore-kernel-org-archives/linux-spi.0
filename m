From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for SLINK controller
Date: Sat, 27 Oct 2012 00:19:00 +0530
Message-ID: <508ADB1C.6040602@nvidia.com>
References: <1350557233-31234-1-git-send-email-ldewangan@nvidia.com>
	<5085A667.2000100@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5085A667.2000100-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Thanks Stephen for review.
I have taken care of almost all feedback. Some of having my below comments.



On Tuesday 23 October 2012 01:32 AM, Stephen Warren wrote:
> On 10/18/2012 04:47 AM, Laxman Dewangan wrote:
>> Tegra20/Tegra30 supports the spi interface through its SLINK
>> controller. Add spi driver for SLINK controller.
>
>> +static inline void tegra_slink_writel(struct tegra_slink_data *tspi,
>> +             unsigned long val, unsigned long reg)
>> +{
>> +     writel(val, tspi->base + reg);
>> +
>> +     /* Read back register to make sure that register writes completed */
>> +     if (reg != SLINK_TX_FIFO)
>> +             readl(tspi->base + SLINK_MAS_DATA);
> Is that really necessary on every single write, or only for certain
> specific operations? This seems rather heavy-weight.
>

We do write register very less (as we  shadow the register locally), I 
do not see any perf degradation here.


>> +     val_write = SLINK_RDY;
>> +     val_write |= (val&  SLINK_FIFO_ERROR);
> Why not just always set SLINK_FIFO_ERROR; does it have to be set in the
> write only if the status was previously asserted? If that is true, how
> do you avoid a race condition where the bit gets set in SLINK_STATUS
> after you read it but before you write to clear it?
>
Status gets updated together. There is no steps of updating status.


>
>> +     if (bits_per_word == 8 || bits_per_word == 16) {
>> +             tspi->is_packed = 1;
>> +             tspi->words_per_32bit = 32/bits_per_word;
> Spaces required around all operators. Does this pass checkpatch? No:
> total: 1405 errors, 11 warnings, 1418 lines checked
>

I saw the issue by my checkpatch is not caching the issue. Let me 
recheck my command.

>> +             bits_per_word = t->bits_per_word ? t->bits_per_word :
>> +                                             tspi->cur_spi->bits_per_word;
> That logic is repeated a few times. Shouldn't there be a macro to avoid
> cut/paste. Perhaps even in the SPI core rather than this driver.
>

I will post the change for moving the code to core later. I will keep 
this for now.

>> +             struct tegra_slink_data *tspi, struct spi_transfer *t)
> Are there no cases where we can simply DMA straight into the client
> buffer? I suppose it would be limited to cache-line-aligned
> cache-line-size-aligned buffers which is probably unlikely in general:-(
>

I think it is possible by checking some flags, I will explore and will 
post the fix later.

>> +static int tegra_slink_unprepare_transfer(struct spi_master *master)
>> +{
>> +     struct tegra_slink_data *tspi = spi_master_get_devdata(master);
>> +
>> +     pm_runtime_put_sync(tspi->dev);
>> +     return 0;
>> +}
> Does this driver actually implement any runtime PM ops? I certainly
> don't see any in struct dev_pm_ops tegra_slink_dev_pm_ops. Related, why
> do tegra_slink_clk_{en,dis}able exist; shouldn't those functions be the
> implementation of the runtime PM ops? Related, why are
> tegra_slink_clk_{en,dis}able called all over the place, rather than
> relying on runtime PM API calls, or tegra_slink_{,un}prepare_transfer
> having been called?
>


OK, I move the clock control in runtime callbacks.


> So that all implies that we wait for the very first interrupt from the
> SPI peripheral for a transfer, and then wait for the DMA controller to
> complete all DMA (which would probably entail actually waiting for DMA
> to drain the RX FIFO in the RX case). Does it make sense to simply
> return from the ISR if not all conditions that we will wait on have
> occurred, and so avoid blocking this ISR thread? I suppose since this
> thread gets blocked rather than spinning, it's not a big deal though.
>

In this case, we can get rid of isr thread and move the wait/status 
check to caller thread.
I need to do some more stress on this and if it is fine then will post 
the patch later for this, not as part of this patch.


>> +     spin_lock_irqsave(&tspi->lock, flags);
>> +     if (err) {
>> +             dev_err(tspi->dev,
>> +                     "DmaXfer: ERROR bit set 0x%x\n", tspi->status_reg);
>> +             dev_err(tspi->dev,
>> +                     "DmaXfer 0x%08x:0x%08x:0x%08x\n", tspi->command_reg,
>> +                             tspi->command2_reg, tspi->dma_control_reg);
>> +             tegra_periph_reset_assert(tspi->clk);
>> +             udelay(2);
>> +             tegra_periph_reset_deassert(tspi->clk);
> Do we /have/ to reset the SPI block; can't we just disable it in the
> control register, clear all status, and re-program it from scratch?
>
> If at all possible, I would like to avoid introducing any new use of
> tegra_periph_reset_{,de}assert, since that API has no standard subsystem
> equivalent (or if it does, isn't hooked into the standard subsystem
> yet), and hence means this driver relies on a header file currently in
> arch/arm/mach-tegra/include/mach, and we need to move or delete all such
> headers in order to support single zImage.

Is there a way to support the reset of controller. We will need this 
functionality.


------------------------------------------------------------------------------
The Windows 8 Center 
In partnership with Sourceforge
Your idea - your app - 30 days. Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
