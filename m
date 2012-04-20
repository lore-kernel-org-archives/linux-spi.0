From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] spi: spi-rspi: add dmaengine supporting
Date: Fri, 20 Apr 2012 15:40:43 +0900
Message-ID: <20120420064038.GA24697@verge.net.au>
References: <4F90F92C.5030001@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F90F92C.5030001@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 20, 2012 at 02:50:36PM +0900, Shimoda, Yoshihiro wrote:
> This patch adds dmaengine supporting using sh_dma driver. The module
> receives data by DMAC, it also needs TX DMAC to generate SPI's clocks.

Hi Shimoda-san,

could you let me know if it is possible to exercise this code
on the sh7757lcr board and if so, how?

Thanks
