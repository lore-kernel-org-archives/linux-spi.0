From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: slink: do not prepare dma transfer with
	DMA_CTRL_ACK flag
Date: Tue, 27 Nov 2012 04:30:30 +0530
Message-ID: <50B3F48E.4040705@nvidia.com>
References: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com>
	<50B3E72B.6020003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <50B3E72B.6020003-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 27 November 2012 03:33 AM, Stephen Warren wrote:
> On 11/23/2012 02:22 AM, Laxman Dewangan wrote:
>> Spi starts transfer using dma with DMA_CTRL_ACK which is not require
>> becasue spi driver does not use completed dma_desc after transfer
>> done and so it does not ack the dma descriptor. Removing the
>> DMA_CTRL_ACK flag to avoid memory leak in dma driver.
> I'm not quite sure, but isn't this the opposite of what's wanted. I
> think that setting this flag in prep() means that the SPI driver need
> not explicitly ack it later?
>
> At least, tegra_dma_desc_get() returns an allocated descriptor if one
> exists and async_tx_test_ack()==true for it, and it's true when the
> DMA_CTRL_ACK flag is set, which happens either due to calling
> async_tx_ack(), or because tegra_dma_prep_slave_sg() was called with
> DMA_CTRL_ACK in flags.

I think DMA_CTRL_ACK flag is require if we want to free/reuse desc only 
when client ack it.

Although some part of implementation is wrong in the tegra20-apb-dma.c.

static struct tegra_dma_desc *tegra_dma_desc_get(
                 struct tegra_dma_channel *tdc)
{
         struct tegra_dma_desc *dma_desc;
         unsigned long flags;

         spin_lock_irqsave(&tdc->lock, flags);

         /* Do not allocate if desc are waiting for ack */
         list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
                 if (async_tx_test_ack(&dma_desc->txd)) {
                         list_del(&dma_desc->node);
:::::::::::::::

}

In above it should be if (!async_tx_test_ack())

And when client done with the desc, then it can say as async_tx_clear_ack().


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
