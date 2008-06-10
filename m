From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] au1550-spi: proper platform driver.
Date: Tue, 10 Jun 2008 15:35:41 +0200
Message-ID: <484E832D.2090002@gmail.com>
References: <20080610132440.GA6580@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080610132440.GA6580-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Manuel Lauss wrote:
 >>From d5c837fe6df9c4cebb0d2d7fc947c7d50c4369c6 Mon Sep 17 00:00:00 2001
 > From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
 > Date: Sat, 7 Jun 2008 12:14:37 +0200
 > Subject: [PATCH] au1550_spi: proper platform driver
 >
 > Remove the Au1550 resource table and instead extract MMIO/IRQ/DMA
 > resources from platform resource information like any well-behaved
 > platform driver.
 >
 > Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
 > Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Please, do not sign by my signature:-/ Particularly when you did not make the
requested change concerning the parameter of release_mem_region() - see below,
please...

<snip>

 > @@ -924,7 +915,9 @@ err_no_txdma_descr:
 >  		au1xxx_dbdma_chan_free(hw->dma_tx_ch);
 >
 >  err_no_txdma:
 > -err_dma_add_dev:
 > +	iounmap((void __iomem *)hw->regs);
 > +
 > +err_ioremap:
 >  	release_mem_region((unsigned long)hw->regs, sizeof(psc_spi_t));

hw->regs is not valid argument for release_mem_region() - physical address was
used for request_mem_region() obtained from the resource, but here it is used
ioremapped and it's not even valid anymore...

 >
 >  err_no_iores:
 > @@ -945,6 +938,7 @@ static int __exit au1550_spi_remove(struct 
platform_device *pdev)
 >  	spi_bitbang_stop(&hw->bitbang);
 >  	free_irq(hw->irq, hw);
 >  	release_mem_region((unsigned long)hw->regs, sizeof(psc_spi_t));
 > +	iounmap((void __iomem *)hw->regs);

maybe we should put the iounmap() above the release_mem_region().
Here the parameter for release_mem_region() has the same problem as mentioned above.

<snip>

Could you please, fix that?

Thanks and best regards,
Jan


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
