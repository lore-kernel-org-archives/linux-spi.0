From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/amba-pl022: work in polling or interrupt mode if
	pl022_dma_probe fails
Date: Thu, 19 May 2011 13:20:26 -0600
Message-ID: <20110519192026.GM5109@ponder.secretlab.ca>
References: <a105605733caadfea25034ce0b8af73eb907fd33.1305287569.git.viresh.kumar@st.com>
	<BANLkTi=V7Y1boyEVn5feSzUiZbUL5RhJyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: armando.visconti@st.com, Shiraz HASHIM <shiraz.hashim@st.com>,
	linus.walleij@stericsson.com, linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: viresh kumar <viresh.linux@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=V7Y1boyEVn5feSzUiZbUL5RhJyQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 13, 2011 at 06:49:39PM +0530, viresh kumar wrote:
> On 5/13/11, Viresh Kumar <viresh.kumar@st.com> wrote:
> > diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> > index 08de58e..82b98b8 100644
> > --- a/drivers/spi/amba-pl022.c
> > +++ b/drivers/spi/amba-pl022.c
> > @@ -1063,7 +1063,7 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
> >  					    pl022->master_info->dma_filter,
> >  					    pl022->master_info->dma_rx_param);
> >  	if (!pl022->dma_rx_channel) {
> > -		dev_err(&pl022->adev->dev, "no RX DMA channel!\n");
> > +		dev_warn(&pl022->adev->dev, "no RX DMA channel!\n");
> 
> Sorry, this must be dev_dbg

Please fixup and repost.  Add Linus' ack while you're at it.  :-)

Thanks,
g.

> 
> >  		goto err_no_rxchan;
> >  	}
> >
> > @@ -1071,13 +1071,13 @@ static int __init pl022_dma_probe(struct pl022
> > *pl022)
> >  					    pl022->master_info->dma_filter,
> >  					    pl022->master_info->dma_tx_param);
> >  	if (!pl022->dma_tx_channel) {
> > -		dev_err(&pl022->adev->dev, "no TX DMA channel!\n");
> > +		dev_warn(&pl022->adev->dev, "no TX DMA channel!\n");
> 
>                 dev_dbg
> 
> >  		goto err_no_txchan;
> >  	}
> >
> >  	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
> >  	if (!pl022->dummypage) {
> > -		dev_err(&pl022->adev->dev, "no DMA dummypage!\n");
> > +		dev_warn(&pl022->adev->dev, "no DMA dummypage!\n");
> 
>                 dev_dbg
> 
> >  		goto err_no_dummypage;
> >  	}
> >
> > @@ -1093,6 +1093,8 @@ err_no_txchan:
> >  	dma_release_channel(pl022->dma_rx_channel);
> >  	pl022->dma_rx_channel = NULL;
> >  err_no_rxchan:
> > +	dev_warn(&pl022->adev->dev,
> 
>         dev_err
> 
> > +			"Failed to work in dma mode, work without dma!\n");
> >  	return -ENODEV;
> >  }
> >
> 
> Will resend patch on Monday. Till that time, please see if this patch
> with mentioned changes is acceptable or not.
> 
> --
> viresh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
