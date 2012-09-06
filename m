From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: tegra: remove support of legacy DMA driver based
 access
Date: Thu, 06 Sep 2012 17:50:07 -0600
Message-ID: <504936AF.8010701@wwwdotorg.org>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com> <1345126397-28864-5-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345126397-28864-5-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/16/2012 08:13 AM, Laxman Dewangan wrote:
> Remove the support code which uses the legacy APB DMA driver
> for accessing the SPI FIFO.
> The driver will use the dmaengine based APB DMA driver for
> accessing reqding/writing to SPI FIFO.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Grant, Mark,

I'd like to take this patch through the Tegra tree, since it relies on
the previous Tegra patches to convert to dmaengine. Could I please get
an ack if that's OK? Thanks.
