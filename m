From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] spi/makefile:  Fix typo from reorganize drivers
 patch.
Date: Thu, 16 Jun 2011 06:31:58 -0600
Message-ID: <20110616123158.GC31534@ponder.secretlab.ca>
References: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
 <1308158588-17249-2-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: dirk.brandewie@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308158588-17249-2-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2011 at 10:23:04AM -0700, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> 
> Fix Makefile to build designware driver.
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>

This is already fixed in spi/next

g.

> ---
>  drivers/spi/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f6d5018..b60b04b 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -23,7 +23,7 @@ obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
>  obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
>  obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
>  obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
> -spi_dw_midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
> +spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
>  obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
>  obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
>  obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
> -- 
> 1.7.3.4
> 
> 
> ------------------------------------------------------------------------------
> EditLive Enterprise is the world's most technically advanced content
> authoring tool. Experience the power of Track Changes, Inline Image
> Editing and ensure content is compliant with Accessibility Checking.
> http://p.sf.net/sfu/ephox-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
