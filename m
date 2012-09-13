From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 0/5] ARM: tegra: move all APB DMA client to dmaengine
 based driver
Date: Thu, 13 Sep 2012 17:35:20 -0600
Message-ID: <50526DB8.3090808@wwwdotorg.org>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345126397-28864-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/16/2012 08:13 AM, Laxman Dewangan wrote:
> This patch series enable the dmaengine based Tegra APB DMA driver
> and remove the support code for the legacy dma driver from different
> APB DMA clients.
> Patch 1 enable the dmaengine based dma drie and disable the legacy dma driver
>         in config file.
> Patch 2 remove the legacy dma driver.
> Patch 3,4, 5 remove the support code from different APB DMA clients to support
>         legacy dma driver.
> 
> Please note that this series will depends on patch
> dma: tegra: enable/disable dma clock
> which is not in 3.6-rc1 but will be available in next RC (rc2) of 3.6 as
> part of fixes.

I have applied this series to Tegra's for-3.7/dmaengine branch. Right
now, that branch is based directly on Mark Brown's ASoC for-3.6 branch
in order to pick up the fix it depends on. However, I'll rebase on the
3.6 pull request tag he sends for that branch as soon as it's available.
