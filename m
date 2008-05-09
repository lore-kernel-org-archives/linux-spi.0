From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: SPI bridge
Date: Fri, 9 May 2008 10:24:00 -0600
Message-ID: <fa686aa40805090924r1b6f06fhb0369f18958bd8a6@mail.gmail.com>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I don't see anything in the SPI documentation about this... has any
work been done on supporting drivers for SPI bridges?  Specifically,
an SPI device that has local registers, but can also pass through the
SPI signals to child devices.

As an example; imagine the following configuration:

+------------+
| SPI Master |
+------------+
 |
 |MDIO,MISO,MCK,SS0,SS1
 |
+-------------+  SS2  +--------------+
|             |-------| SPI Device 1 |
| SPI Bridge  |       +--------------+
|             |
|             |  SS3  +--------------+
|             |-------| SPI Device 1 |
|             |       +--------------+
|             |
|             |  SS4  +--------------+
|             |-------| SPI Device 1 |
+-------------+       +--------------+

So, SS0 access registers on the SPI bridge
SS1 is passed through so SS2, SS3 or SS4 based on a register value in
the SPI bridge.  I thought about just overriding the SPI controller's
SS activate function, but that leaves a bit of a chicken and egg
problem.  The message has already been dequeued when the CS is called,
but the new SPI message so set the SS register needs to be inserted
before the current message.  I could hack it to make it work, but I'd
like to do this in a reusable/adaptable way.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
