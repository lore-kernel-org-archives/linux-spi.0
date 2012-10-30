From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] spi: tegra: add spi driver for SLINK controller
Date: Tue, 30 Oct 2012 11:13:34 +0530
Message-ID: <508F6906.7020704@nvidia.com>
References: <1351531104-1604-1-git-send-email-ldewangan@nvidia.com>
	<508ED5A5.3000703@wwwdotorg.org>
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
In-Reply-To: <508ED5A5.3000703-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Taking example from the mfd, we depends on particular driver, not from 
the core driver.
I like to have this depends on Tegra20_apb_dma.

>> +			x = 0;
>> +			for (i = 0; nbytes&&  (i<  tspi->bytes_per_word);
>> +							i++, nbytes--)
>> +				x |= ((*tx_buf++)<<  i*8);
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

I like to clean it later.


>> +		val |= SLINK_PACKED;
>> +		tegra_slink_writel(tspi, val, SLINK_DMA_CTL);
>> +		udelay(1);
>> +		wmb();
> Why the udelay() and wmb()?
udelay() is suggetsed by ASIC.
wmb() is lying in our downstream code and hence it is there but I dont 
think it is require now. I will remove it.


>> +static int tegra_slink_runtime_resume(struct device *dev)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
>> +
>> +	return tegra_slink_clk_prepare(tspi);
>> +}
> Why not move the body of tegra_slink_clk_{un,prepare} inside those
> functions, since they're only called from those functions?
>
Fine, I will do this,


>> +MODULE_ALIAS("platform:tegra_slink-slink");
> I think that's a typo.
Yes, I will correct it.



------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
