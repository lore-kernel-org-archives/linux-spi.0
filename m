From: Robin Holt <holt-sJ/iWh9BUns@public.gmane.org>
Subject: Help with freescale p1010 based espi implementation.
Date: Wed, 19 Oct 2011 00:46:22 -0500
Message-ID: <20111019054622.GE22814@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Robin Holt <holt-sJ/iWh9BUns@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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

I am a newbie to SPI and Broadcom Robo switch parts, so any correction
to my direction early on is _VERY_ welcome.


The Freescale P1010 communications SOC includes an ESPI controller
which works with the spi-fsl-espi.c driver.  In that driver, the chip
selects are limited to 4 by the SPCOM_CS field of the command register.
Unfortunately, in the documentation, the only supported value for
that field is '00b'.  In our board design, we decided to use GPIO5
to effectively drive the select line of a 1-of-2 MUX chip (TI Part
SN74CBTLV3257PWR pin 1).

My immediate need is a quick-fix to the espi driver to allow driving
GPIO5 in addition to the two bits currently being used by the chip select
portion of the command register.  By quick fix, I am looking for something
to maintain locally until a more general method for abstracting the
board specific CS enhancements from the ESPI driver.

I have modified the boot loader to have GPIO5 set as an output and setting
it high prior to booting the kernel.  That reflects the strapping on
the board and the inactive high state needed by the CS signal.

I believe that I want my flattened device tree to have
fsl,espi-num-chipselects set to 8 (or at least 5), and then assign the
two devices chipselect 4 (the SPI Flash part which is addressed with
GPIO5=1 and command.CS field=0) and chipselect 0 (Broadcom Robo switch
which is addressed with GPIO5=0 and command.CS field=0).


On the subject of the GPIOs, I see those are being defined by the
mpc8xxx_gpio.c driver.  I do see messages during boot, and can use the
sysfs interface to toggle GPIO5 (which is really mapped to GPIO 229, but
that is probably my problem).  How would I locate that GPIO "correctly"
from within the spi-fsl-espi.c driver?


Another, mostly unrelated question is, can I get the kernel to define the
robo switch device without any kernel driver matching its FDT "compatible"
entry?  What I believe the SDK needs is merely a SPI driver defined and
then I think I can get the remainder of the Broadcom SDK working.

Thank you in advance for the help,
Robin Holt

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
