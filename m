From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: slink: do not prepare dma transfer with DMA_CTRL_ACK
 flag
Date: Wed, 3 Apr 2013 15:01:25 +0530
Message-ID: <515BF6ED.2060904@nvidia.com>
References: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com> <20130401133459.GS18636@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130401133459.GS18636-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 01 April 2013 07:05 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Fri, Nov 23, 2012 at 02:52:39PM +0530, Laxman Dewangan wrote:
>> Spi starts transfer using dma with DMA_CTRL_ACK which is not require
>> becasue spi driver does not use completed dma_desc after transfer
>> done and so it does not ack the dma descriptor. Removing the
>> DMA_CTRL_ACK flag to avoid memory leak in dma driver.
> Applied, thanks.

Mark,
There was bug in dma driver about handling of DMA_CTRL_ACK flag which we 
fixed after Stephen pointed out.
This change is no more require.
Can you please drop this patch? Let me know if I need to send the revert 
patch.

Sorry for inconvenience.

Thanks,
Laxan
