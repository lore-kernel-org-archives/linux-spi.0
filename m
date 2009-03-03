From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Freescale MPC8313 & SPI
Date: Tue, 03 Mar 2009 15:58:02 -0500
Message-ID: <49AD99DA.60407@whoi.edu>
References: <20090303150112.7t6tpqkw0wsgoc4s@www.bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Bishop <mark-Wri040CV1BU@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090303150112.7t6tpqkw0wsgoc4s-2+Z7l/WXEz7k1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Mark Bishop wrote:
> I am trying to understand more about how to talk to different spi  
> chips using the MPC8313.  The documentation that comes with the  
> development board is really lacking and I am relying on the  
> /usr/src/linux/Documentaion/spi.  However, I still can't seem to  
> answer my questions.
> 
> 1) Which device do I open up to talk to the bus.  I would use  
> something like /dev/ttyS0 for a serial port, and I assume it would be  
> /dev/spidev.0 and I would have to make it manually using mknod - but  
> what ties the /dev/spidev.0 to the actual chip driver?  Is there  
> something I have to do in addition to mknod?

There are two kernel drivers associated with SPI operations:

The controller driver (sometimes or previously called the master driver)
manipulates the physical pins of the SPI bus, controlling the clock,
data and chip selects for various devices attached to the bus.  It knows
how to send and receive variable length words, groups of those words
(transfers), and groups of transfers (messages).  It does not know much
about the actual chips attached to the bus (except what it may be told),
nor what sequence of messages/transfers have meaning to the attached chips.

The protocol driver knows what messages/transfers are useful for any
chip that might be connected.  Furthermore, it is the controller driver
that makes the link between the kernel side of libc, and the controller
driver.  Specifically, the protocol driver has implementations of read
write, seek, open, close, ioctl, etc.  It is normally the loading of a
protocol driver (usually a module) that generates the appropriate /dev
entry for the corresponding chip; I suppose /dev entries can be created
other ways.

There is normally a protocol driver for each (type of) device attached
to the bus, and only one controller driver per bus.  The controller
driver acts like a traffic cop directing the communications between
multiple protocol drivers and their respective chips.

> 2) I would be looking for a few examples on how to talk to a SPI bus  
> as well.  I've looked at spidev_test.c and I would like to see another  
> example or two.

Can't really help with an example.  I don't use the platform you have.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
