From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: slink: do not prepare dma transfer with DMA_CTRL_ACK
 flag
Date: Mon, 26 Nov 2012 15:03:23 -0700
Message-ID: <50B3E72B.6020003@wwwdotorg.org>
References: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353662559-26515-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/23/2012 02:22 AM, Laxman Dewangan wrote:
> Spi starts transfer using dma with DMA_CTRL_ACK which is not require
> becasue spi driver does not use completed dma_desc after transfer
> done and so it does not ack the dma descriptor. Removing the
> DMA_CTRL_ACK flag to avoid memory leak in dma driver.

I'm not quite sure, but isn't this the opposite of what's wanted. I
think that setting this flag in prep() means that the SPI driver need
not explicitly ack it later?

At least, tegra_dma_desc_get() returns an allocated descriptor if one
exists and async_tx_test_ack()==true for it, and it's true when the
DMA_CTRL_ACK flag is set, which happens either due to calling
async_tx_ack(), or because tegra_dma_prep_slave_sg() was called with
DMA_CTRL_ACK in flags.
