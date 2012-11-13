From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for sflash controller
Date: Wed, 14 Nov 2012 00:12:17 +0530
Message-ID: <50A29489.5090606@nvidia.com>
References: <1352782854-25351-1-git-send-email-ldewangan@nvidia.com> <50A28299.6080809@wwwdotorg.org>
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
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A28299.6080809-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 13 November 2012 10:55 PM, Stephen Warren wrote:
> On 11/12/2012 10:00 PM, Laxman Dewangan wrote:
>
>> +static int tegra_sflash_resume(struct device *dev)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
>> +	int ret;
>> +
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret<  0) {
>> +		dev_err(dev, "pm runtime failed, e = %d\n", ret);
>> +		return ret;
>> +	}
>> +	tegra_sflash_writel(tsd, tsd->command_reg, SPI_COMMAND);
>> +	pm_runtime_put(dev);
> Can we avoid this whole function simply by programming SPI_COMMAND at
> the start of each transaction? That seems simpler. I assume that
> shouldn't e.g. leave any chip-selects in some bad state, or at least if
> it does, that shouldn't be a problem, because before the driver probes()
> at kernel boot, SPI_COMMAND won't have been programmed either.
>
> Aside from that,

I am not sure about the side effect of moving this to transfer but I can 
suspect:
When client driver is active, it need the proper state of CS. If we move 
this to transfer then probbaly CS is not in proper state until client 
calls the transfer function and this is not correct. The CS should be 
inactive state for all devices in non-transfer states.

> Acked-by: Stephen Warren<swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Tested-by: Stephen Warren<swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks for testing. I will respin patch V2 for taking care of above 
comments.
