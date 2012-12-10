From: phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH v2] spi: sh-hspi: Improve performance
Date: Mon, 10 Dec 2012 09:35:07 +0000
Message-ID: <OFF14E1C10.84C252C4-ON80257AD0.0034773F-80257AD0.0034A8A8@eu.necel.com>
References: <20121123095137.7DBB03E07BE@localhost>
	<1353681984-15850-1-git-send-email-phil.edworthy@renesas.com>
	<20121206143421.603383E0948@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20121206143421.603383E0948@localhost>
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

> <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > The driver attempts to read the received data immediately after
> > writing to the transmit buffer. If no data is available, the driver
> > currently waits 20ms until trying again. Since the hardware needs
> > to shift out the transmitted data, the first poll always fails,
> > leading to 20ms delay between bytes.
> >
> > This patch waits for the time it takes to transmit a byte before
> > reading the received data.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > ---
> > v2:
> >  Instead of replacing msleep(20) with udelay(1), this version now
> >  calculates the time it takes to shift out a byte, and uses udelay or
> >  ndelay for this time. After this it falls back to polling every 20ms
> >  using msleep. The delay has an empirical element based on testing at
> >  different speeds.
<snip>

> This is still just busywaiting. Which means just burning CPU cycles
> unconditionally even if it does finish early.
>
> Instead of doing nothing, it is actually a whole lot better to use a
> small delay and check if there is stuff to do frequently than it is to
> try and delay for the entire duration. Due to the way this driver is
> architected, nothing else can use the CPU during the delay().
>
> What would really be better is to load up the fifo and full as it will
> go and then rely on IRQs to tell the driver when it becomes ready to
> fill with more data.

Ok, I see now. I'll look at using dma instead though, as that will be better in the long run.

Thanks for your comments,
Phil
------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
