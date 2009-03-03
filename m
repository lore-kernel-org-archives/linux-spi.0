From: Mark Bishop <mark-Wri040CV1BU@public.gmane.org>
Subject: Freescale MPC8313 & SPI
Date: Tue, 03 Mar 2009 15:01:12 -0500
Message-ID: <20090303150112.7t6tpqkw0wsgoc4s@www.bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I am trying to understand more about how to talk to different spi  
chips using the MPC8313.  The documentation that comes with the  
development board is really lacking and I am relying on the  
/usr/src/linux/Documentaion/spi.  However, I still can't seem to  
answer my questions.

1) Which device do I open up to talk to the bus.  I would use  
something like /dev/ttyS0 for a serial port, and I assume it would be  
/dev/spidev.0 and I would have to make it manually using mknod - but  
what ties the /dev/spidev.0 to the actual chip driver?  Is there  
something I have to do in addition to mknod?

2) I would be looking for a few examples on how to talk to a SPI bus  
as well.  I've looked at spidev_test.c and I would like to see another  
example or two.

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
