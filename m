From: Nuutti Kotivuori <naked-X3B1VOXEql0@public.gmane.org>
Subject: Continuous streaming SPI transfer
Date: Fri, 28 Sep 2012 01:09:25 +0300
Message-ID: <87zk4bazje.fsf@kiiro.xen-host.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hello,

I would like to use SPI in a streaming fashion, with a transfer being
active all the time. This seems very difficult with the current kernel
drivers. I am mainly looking at the Raspberry Pi BCM2708 SPI driver, but
I have also tried to find similar features from other drivers.

There seems to be no way to prevent the deactivation and reactivation of
the clock and everything between separate transfers - and a single
transfer is bounded in size and no progress is reported for it. Even
within a single transfer, it would seem that an earlier transfer is
waited to receive a DONE signal (tx fifo empty, rx fifo has everything)
before starting a new transfer, so there's always a small gap between
transfers. (The RPi hardware stops sending SCLK if there ever is a
condition where there is no byte ready in the FIFO to be sent, so if a
DONE signal is receved that means that SCLK has already been stopped.)

Keeping a transfer active constantly would need some buffering on writes
and reads to keep the TX FIFO always filled and RX FIFO not
full. Otherwise I don't see any direct problems with it, atleast on the
hardware level.

So, my questions are:

 1) Is there a fundamental problem in keeping an SPI transfer active for
    extended periods of time (several hours)?
 2) Is this possible with the kernel API somehow?
 3) Is this possible from userland somehow?
 4) If it is not possible, what would be a good API for such a case?
 5) Would patches for such functionality be accepted?

Thank you in advance,
-- Naked

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
