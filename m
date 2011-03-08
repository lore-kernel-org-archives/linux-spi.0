From: Niclas Karlsson <niclas.karlsson-h3aQMNCITb4@public.gmane.org>
Subject: Getting alot of zero values from ads7846 using atmel_spi
Date: Tue, 08 Mar 2011 10:44:56 +0100
Message-ID: <1299577496.13486.13.camel@SESTOWS194>
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

Hi,
I'm not sure this is the right mailinglist for my question, but I give
it a shot.

I'm working on a custom hardware running Linux kernel 2.6.32.3. The
hardware is based on the AT91SAM9263-ek evaluation board and have touch
screen attached to it. The touch screen controller is ads7846 and is
connected to SPI.

I'm in some trouble using the SPI (driver: atmel_spi).

ads7846 have two extra inputs that I want to use. The problem is that
when reading these inputs from sysfs I get a lot of zeroes when it
should read ( when no sensor is connected) ~3300 mV, e.g. 
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0
~# cat /sys/bus/spi/devices/spi0.1/in0_input
3299 <-- This one is correct.
~# cat /sys/bus/spi/devices/spi0.1/in0_input
0

I have measured the input and it's stable at 3.3V.

Do anyone know why I read so many zeroes?

I have made some printk in ads7846.c to trace the problem. It seemed to
read more correct values when I added the printks.

Thank you for the help,
Niclas

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
