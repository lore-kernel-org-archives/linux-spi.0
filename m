From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] dw_spi: Allow interrupt sharing
Date: Thu, 9 Sep 2010 13:08:58 +0800
Message-ID: <20100909050858.GA8003@ywang-moblin2.bj.intel.com>
References: <20100907072727.GA2152@ywang-moblin2.bj.intel.com> <20100908165341.GJ3686@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Feng Tang <feng.tang@intel.com>,
	George Shore <george@georgeshore.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100908165341.GJ3686@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 08, 2010 at 10:53:41AM -0600, Grant Likely wrote:
> On Tue, Sep 07, 2010 at 03:27:27PM +0800, Yong Wang wrote:
> > Allow interrupt sharing since exclusive interrupt line for
> > DW SPI controller is not provided on every platform.
> > 
> > Signed-off-by: Yong Wang <yong.y.wang@intel.com>
> > ---
> >  drivers/spi/dw_spi.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> > index d256cb0..11fbbf6 100644
> > --- a/drivers/spi/dw_spi.c
> > +++ b/drivers/spi/dw_spi.c
> > @@ -396,6 +396,11 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
> >  static irqreturn_t dw_spi_irq(int irq, void *dev_id)
> >  {
> >  	struct dw_spi *dws = dev_id;
> > +	u16 irq_status, irq_mask = 0x3f;
> > +
> > +	irq_status = dw_readw(dws, isr) & irq_mask;
> > +	if (!irq_status)
> > +		return IRQ_NONE;
> 
> To be more concise, this could have simply been:
> 
> if (!dw_readw(dws, isr) & 0x3f)
> 	return IRQ_NONE;
> 
> ... but I'm nitpicking here.  If I don't get an updated version of
> this patch from you in the next few days then I'll apply this one.
> 

Thanks for your comments, Grant. Could you please apply the patch as is?
I think it is more readable. In addition, it is consistent with other
parts of the driver in terms of how isr register is manipulated.

Thanks
-Yong
