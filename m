From: "Charles Martel" <SingerIsland-KK0ffGbhmjU@public.gmane.org>
Subject: Change MODE, CS, BUS, and SPEED using SPI-DEV driver?
Date: Fri, 01 Oct 2010 13:40:31 -0400
Message-ID: <20101001175135.147160@gmx.com>
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

I have built a linux kernel using only the "S3C6410 High Speed SPI Driver." Debug messages were enabled.
In the ./drivers/spi directory, the following were built: built-in.o hspi-s3c64xx.o spi-dev.o spi.o
When I open the driver from a user space application, the debug statements come from the SPI-DEV driver.
However, I don't see the IOCTL calls in spi-dev.c to change the MODE, CS, BUS, or SPEED. I also need to use two speeds, high and low.
The question I have is how do I modify these settings?
Thanks in advance.
------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
