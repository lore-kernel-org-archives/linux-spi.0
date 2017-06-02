From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Fri, 2 Jun 2017 07:38:52 +0200
Message-ID: <20170602053852.7w4c35tn5daq7omy@pengutronix.de>
References: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com>
 <20170529095043.mytrgtyfne4dfmae@pengutronix.de>
 <59300177.5030908@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59300177.5030908-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jun 01, 2017 at 04:58:47AM -0700, Jiada Wang wrote:
> Hi Sascha
> 
> On 05/29/2017 02:50 AM, Sascha Hauer wrote:
> > Hi,
> > 
> > On Thu, May 25, 2017 at 10:02:42PM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
> > > From: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> > > 
> > > previously burst length (BURST_LENGTH) is always set to equal
> > > to bits_per_word, causes a 10us gap between each word in
> > > transfer, which significantly affects performance.
> > > 
> > > This patch uses 32 bits transfer to simulate lower bits transfer,
> > > and adjusts burst length runtimely to use biggeest burst length
> > > as possible to reduce the gaps in transfer for PIO mode.
> > > 
> > First let me say that I'm not really looking forward to have this patch
> > in the driver. It adds quite some code to already hairy code pathes in
> > the imx-spi driver and I saw you have the same patch for DMA mode
> > aswell.
> > 
> > The driver has different function hooks for the different controllers.
> > This patch breaks that. In some places it assumes that dynamic burst
> > is only possible on i.MX51 type controllers and also that in case
> > dynamic burst is enabled it must be an i.MX51 type controller.
> > 
> > We should really see how this patch can be better integrated into the
> > driver, or, how the driver can be changed to better support the dynamic
> > burst usecase.
>  Yes, I can understand your concern, as this patch brings in a bunch of
> change,
> and changes the behaviour of data transfer.
> how about introduce a new DTS property like "fsl,spi-dynamic-burst",
> and only enables dynamic burst when this property is added.

This will only reduce the testing coverage of the feature, not a good
option.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
