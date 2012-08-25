From: "Bastelli Carlo" <carlo_bastelli-whZMOeQn8C0@public.gmane.org>
Subject: Re: SLAVE Side SPI kernel driver development
Date: Sat, 25 Aug 2012 16:06:34 +0200
Message-ID: <000301cd82ca$d80e4170$0702a8c0@spectrekizxcpt>
References: <1345820228.87750.YahooMailNeo@web29604.mail.ird.yahoo.com>
	<5037B1DF.40503@whoi.edu>
	<000f01cd8295$bd728770$0702a8c0@spectrekizxcpt>
	<201208251344.10746.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Marek Vasut" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I will use an ARM processor from Atmel, do not yet know the exact model, but 
I know for a fact that the SPI controller included in their ARM processor 
supports slave mode. When I have more details on the hardware used will not 
forget to update the forum.

Thanks & Regards

Carlo Bastelli

----- Original Message ----- 
From: "Marek Vasut" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Bastelli Carlo" <carlo_bastelli-whZMOeQn8C0@public.gmane.org>
Cc: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>; "Fabio Estevam" 
<festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>; 
<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Sent: Saturday, August 25, 2012 1:44 PM
Subject: Re: SLAVE Side SPI kernel driver development


Dear Bastelli Carlo,

> In my application in fact the slave is connected to the master without
> other devices on the bus, a simple point to point, and receives a frame of
> known dimensions.

What hardware do you use? What CPU is it?

> I think I will be very busy to read post in the coming days  :)

Good luck with that.

> Thanks to all of you who provided suggestions.
> Carlo Bastelli
>
> ----- Original Message -----
> From: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
> To: "Marek Vasut" <marex-ynQEQJNshbs@public.gmane.org>
> Cc: "Fabio Estevam" <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>;
> <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>; "Bastelli Carlo (yahoo)"
> <carlo_bastelli-whZMOeQn8C0@public.gmane.org>; <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
> <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Sent: Friday, August 24, 2012 6:54 PM
> Subject: Re: SLAVE Side SPI kernel driver development
>
> On 08/24/2012 11:38 AM, Marek Vasut wrote:
> > Dear Fabio Estevam,
> >
> >> On Fri, Aug 24, 2012 at 11:57 AM, Bastelli Carlo (yahoo)
> >
> > CCing SPI list
> >
> >> <carlo_bastelli-whZMOeQn8C0@public.gmane.org> wrote:
> >>> Hello, I'm Carlo, I have a difficult task at work, my boss asked me to
> >>> develop
> >>>
> >>>  a driver SPI slave side on embedded ARM processor running Linux.
> >>>
> >>> Precisely linux occur on the SPI bus as a slave, not master as 
> >>> required
> >>> by the hierarchical structure of the current kernel. The new driver
> >>> will
> >>>
> >>>  receive via interrupt and respond when selected by its chip select.
> >
> > So a soft-spi ? It's gonna be slow as hell and unstable too.
> >
> >>>  Can
> >>>  anyone suggest the best way to develop this driver?
> >
> > Get a CPU which has SPI-slave capable IP, start from there. If you were
> > to implement soft-spi this way, you'd have to use FIQ on ARM, to be able
> > to handle
> > stuff with reasonable latency ... check how the ps/2-gpio driver is done
> > in
> > Linux ... I tried it, it barely worked, you don't want to go down that
> > road.
> >
> >>>  Personally, I
> >>>
> >>> have identified two main roads, the first if possible to exploit the
> >>> structure SPI master driver
> >
> > Not happening. You'd have to split the parts from the struct spi_master
> > into
> > common and master-only parts. That's for starters.
> >
> >>> with a few tricks that now I can not
> >>> define. The second most radical, write a driver for a UART like, but
> >>> managing the SPI device.
> >>> Thank you for any suggestions or examples.
> >
> > First of all, the SPI slave mode is COMPLETELY different from the master
> > mode.
> > You need to react on incoming CS-low ASAP, which might turn out to be a
> > problem
> > on it's own. Then, even if you do, you do not know how long the transfer
> > is
> > going to be, so you need to allocate enough buffers as the transfer
> > progresses
> > onwards.
> >
> > In case of your soft-spi, how do you plan to sample the CLK line to sync
> > clock?
> >
> >> Marek got spi slave running on a mx28. See his patch:
> >> http://www.spinics.net/lists/arm-kernel/msg190860.html
> >
> > This was tested (and developed) on this board:
> > http://www.denx-cs.de/?q=M28
> >
> > The userland code is really easy too, simply pump it into spidev or read
> > from
> > it. But all that is only possible because of the SPI IP in the mx28 is
> > nice.
> >
> >> Regards,
> >>
> >> Fabio Estevam
> >
> > Best regards,
> > Marek Vasut
>
> I generally agree with the above comments.  A generalized SPI slave must
> be able to respond instantly, often within one clock cycle.  This can
> only work in hardware, or in an OS like Linux when the activity on the
> bus is completely predictable by the Linux slave.  The only cases I know
> of are streaming of data in a predictable way between a single master
> and single slave (no other devices on the bus).
>
> This topic comes up periodically, but I don't think there has been any
> change in the situation for all the time I've followed the discussion.
> I recommend that you read the archives of this mailing list to
> understand the limitations of a potential slave mode.  The archives can
> be found at:
>
> http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general
>
> then look for threads with "slave" in the subject in the following
> months (I'd give thread start dates, but parts of the threads are
> disconnected in the archives, and this is the easiest way to see all the
> parts, day ranges are in parentheses):
>
> 2007/04 (13-18)
> 2007/09/27 and 2007/10 (13-17)
> 2009/03 (2-3)
> 2009/12/18 and 2010/1/19 and 2010/02 (14-16)
> 2010/07 (26) and 2010/08 (13)
> 2011/01 (28-31) and 2011/02 (1-10)
> 2011/10 (18)
> 2012/06 (29-30 and 2012/07 (1-17)

Best regards,
Marek Vasut 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
