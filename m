From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SPI + SD card
Date: Wed, 04 Nov 2009 18:27:14 -0500
Message-ID: <4AF20DD2.2050101@whoi.edu>
References: <f96d234e0911041353o25aeee4aqbb482f162aaeac5f@mail.gmail.com>
	<f96d234e0911041354p1f11e415g427ec9b74ff4d25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Cliff Brake <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f96d234e0911041354p1f11e415g427ec9b74ff4d25b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/04/2009 04:54 PM, Cliff Brake wrote:
> On Wed, Nov 4, 2009 at 4:53 PM, Cliff Brake <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hello,
>>
>> I'm trying to get a PXA270 to talk to a SD card via SPI.  Has anyone
>> else done this?

I haven't used an SD card, but...

>> One of the requirements is the CS stay low for the entire transaction.
>>  Can this be done with the PXA270 controlling the frame (CS) signal,
>> or is GPIO control typically required?

A GPIO is typically used.  The PXA2xx processors lack a
multi-chip-select function for SPI devices, so one has to use a GPIO if
more than one device is on the bus.  Back in 2.6.20, there was a
cs_control() call back to allow the pxa2xx_spi.c driver to control a
separately allocated GPIO line.  I think there is now a more generalized
procedure in the kernel to specify the GPIO that is to be used for each
device on the bus.

> Also, what SPI mode is typically used for SD?  Looks like 0 and 3 are
> the closest (http://elm-chan.org/docs/spi_e.html).

Not sure on that one.  I think there was a lot of discussion about that
a couple of years ago when someone was getting SD cards to work.  You
might want to search the archives if no one answers you directly.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
