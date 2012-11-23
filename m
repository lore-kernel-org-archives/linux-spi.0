From: phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH 1/2] spi: sh-hspi: Improve performance
Date: Fri, 23 Nov 2012 10:02:51 +0000
Message-ID: <OFEE410524.0469150E-ON80257ABF.00364800-80257ABF.00373133@eu.necel.com>
References: <1353595047-14558-1-git-send-email-phil.edworthy@renesas.com>
	<20121123095137.7DBB03E07BE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20121123095137.7DBB03E07BE@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> Sent by: Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>
> On Thu, 22 Nov 2012 14:37:26 +0000, Phil Edworthy
> <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > The driver attempts to read the recieved data immediately after
> > writing to the transmit buffer. If no data is available, the driver
> > currently waits 20ms until trying again. Since the hardware needs
> > to shift out the transmitted data, the first poll always fails,
> > leading to 20ms delay between bytes.
> >
> > This patch reduces the polling interval to 1us, and also reduces
> > the timeout to 10ms.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-sh-hspi.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> > index 934138c..0ca18c8 100644
> > --- a/drivers/spi/spi-sh-hspi.c
> > +++ b/drivers/spi/spi-sh-hspi.c
> > @@ -73,13 +73,13 @@ static u32 hspi_read(struct hspi_priv *hspi, int reg)
> >   */
> >  static int hspi_status_check_timeout(struct hspi_priv *hspi, u32
> mask, u32 val)
> >  {
> > -   int t = 256;
> > +   int t = 10000; /* 10ms max timeout */
> >
> >     while (t--) {
> >        if ((mask & hspi_read(hspi, SPSR)) == val)
> >           return 0;
> >
> > -      msleep(20);
> > +      udelay(1);
> >     }
>
> This does have the side effect that the cpu is now spinning instead of
> scheduling something else when the device is busy. Is that what you
> want? (the answer depends on how big the fifo is and how fast the SPI
> bus runs).
That's true... The HW has an 8 byte fifo, but at the moment this driver
doesn't use it. I suppose the sensible thing to do is calculate the time
we expect to wait for the received data to become available, and if this
time is over some threshold, use msleep instead of udelay.

Thanks
Phil
------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
