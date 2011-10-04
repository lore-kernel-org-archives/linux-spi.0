From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] spi-topcliff-pch: add tx-memory clear after complete
 transmitting
Date: Tue, 4 Oct 2011 10:03:15 -0600
Message-ID: <20111004160315.GA8970@ponder.secretlab.ca>
References: <1315295914-6862-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <4E8ACEAE.3040400@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E8ACEAE.3040400@dsn.lapis-semi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 04, 2011 at 06:15:26PM +0900, Tomoya MORINAGA wrote:
> Hi Grant,
> 
> 1 month has passed. You look very busy, right ?
> We've been long waiting for your accept.
> Could you review these patch series ?
> 
> Thanks in advance.

Just looked at it now.  I'm picking it up and I'll send the pull req to Linus right away

g.

> 
> (2011/09/06 16:58), Tomoya MORINAGA wrote:
> > Currently, in case of reading date from SPI flash,
> > command is sent twice.
> > The cause is that tx-memory clear processing is missing .
> > This patch adds the tx-momory clear processing.
> > 
> > Signed-off-by: Tomoya MORINAGA<tomoya-linux@dsn.okisemi.com>
> > ---
> >   drivers/spi/spi-topcliff-pch.c |    5 +++++
> >   1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> > index 540c290..1b98b7e 100644
> > --- a/drivers/spi/spi-topcliff-pch.c
> > +++ b/drivers/spi/spi-topcliff-pch.c
> > @@ -839,6 +839,11 @@ static void pch_spi_start_transfer(struct pch_spi_data *data)
> > 
> >   	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_rx_p, dma->nent,
> >   			    DMA_FROM_DEVICE);
> > +
> > +	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_tx_p, dma->nent,
> > +			    DMA_FROM_DEVICE);
> > +	memset(data->dma.tx_buf_virt, 0, PAGE_SIZE);
> > +
> >   	async_tx_ack(dma->desc_rx);
> >   	async_tx_ack(dma->desc_tx);
> >   	kfree(dma->sg_tx_p);
> 
> 
> -- 
> tomoya
> ROHM Co., Ltd.
