From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically
	to get DMA device info
Date: Fri, 09 Mar 2012 16:50:35 -0700
Message-ID: <20120309235036.05D933E0950@localhost>
References: <1323403905-3432-1-git-send-email-tomoya.rohm@gmail.com>
	<CANKRQniO55ZO+15Wt63Jtj4_MJk3b04_KXZT4bcrOaJjBedzyQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="===============8624250636969088621=="
Cc: kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CANKRQniO55ZO+15Wt63Jtj4_MJk3b04_KXZT4bcrOaJjBedzyQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============8624250636969088621==

On Thu, 19 Jan 2012 11:34:43 +0900, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Grant.
> 
> More than a month has been passed since I posted the following patches.
> However still not reviewed yet.
> 
> [PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically to get
> DMA device info
> [PATCH 2/4] spi-topcliff-pch: Fix issue for transmitting over 4KByte
> [PATCH 3/4][RESEND] spi-topcliff-pch: supports a spi mode setup and
> bit order setup by IO control
> [PATCH 4/4] spi-topcliff-pch: add recovery processing in case wait-event timeout
> 
> Could you review these ?

I'm working through my backlog now.  A big part of the problem is my
method of dealing with pending patches really sucked.  I've switched
to using notmuch-vim, which seems to be a much better system for tracking
email that I need to pay attention to.

g.

> 
> thanks,
> tomoya
> 
> 2011/12/9 Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/spi/spi-topcliff-pch.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> > index 99ec279..fcd9462 100644
> > --- a/drivers/spi/spi-topcliff-pch.c
> > +++ b/drivers/spi/spi-topcliff-pch.c
> > @@ -920,7 +920,8 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
> >        dma_cap_set(DMA_SLAVE, mask);
> >
> >        /* Get DMA's dev information */
> > -       dma_dev = pci_get_bus_and_slot(2, PCI_DEVFN(12, 0));
> > +       dma_dev = pci_get_bus_and_slot(data->board_dat->pdev->bus->number,
> > +                                      PCI_DEVFN(12, 0));
> >
> >        /* Set Tx DMA */
> >        param = &dma->param_tx;
> > --
> > 1.7.4.4
> >

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.


--===============8624250636969088621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============8624250636969088621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============8624250636969088621==--
