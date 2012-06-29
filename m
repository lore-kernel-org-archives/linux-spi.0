From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: use dmaengine based dma driver
Date: Fri, 29 Jun 2012 10:36:10 -0600
Message-ID: <4FEDD97A.7050702@wwwdotorg.org>
References: <1340969480-7702-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340969480-7702-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/29/2012 05:31 AM, Laxman Dewangan wrote:
> Use the dmaengine based Tegra APB DMA driver for
> data transfer between SPI FIFO and memory in
> place of legacy Tegra APB DMA.
> 
> The new driver is selected if legacy driver is not
> selected and new DMA driver is enabled through config
> file.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
