From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] spi: tegra: add spi driver for SLINK controller
Date: Tue, 30 Oct 2012 11:26:25 +0530
Message-ID: <508F6C09.4070104@nvidia.com>
References: <1351531104-1604-1-git-send-email-ldewangan@nvidia.com> <508ED5A5.3000703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508ED5A5.3000703-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 30 October 2012 12:44 AM, Stephen Warren wrote:
> On 10/29/2012 11:18 AM, Laxman Dewangan wrote:
>> Tegra20/Tegra30 supports the spi interface through its SLINK
>> controller. Add spi driver for SLINK controller.
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> +config SPI_TEGRA20_SLINK
>> +	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
>> +	depends on ARCH_TEGRA&&  TEGRA20_APB_DMA
> I think it depends on DMAENGINE, not the specific driver now, doesn't it?

I saw in MFD where the dependent driver depends on the actual drver, not 
on core. Also this driver need apb dma and hence if there is other dma 
driver based on dmaengine, not apb dma then this driver should not get 
invoked.

>> +			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
>> +		}
>> +	}
> The if and the else there are basically identical now. Can't the else
> branch simply be replaced by the if branch? At most I think the
> difference comes down to max_n_32bit v.s. fifo_words_left calculations
> being slight different; everything else is the same.
>
> I suppose this isn't a big deal though; we could clean it up later if
> necessary.
>

I like to do later.


>> +		tegra_slink_writel(tspi, val, SLINK_DMA_CTL);
>> +		udelay(1);
>> +		wmb();
> Why the udelay() and wmb()?

Udelay() is required as suggested by ASIC.
wmb() is lying in our downstream code and hence it is here but I think 
it is not require now.

>> +	return tegra_slink_clk_prepare(tspi);
>> +}
> Why not move the body of tegra_slink_clk_{un,prepare} inside those
> functions, since they're only called from those functions?
>

Fine, I will do.

>> +MODULE_ALIAS("platform:tegra_slink-slink");
> I think that's a typo.
I will fix this typo.

Thanks,
Laxman
