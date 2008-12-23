From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: How to satisfy specific timing diagram
Date: Tue, 23 Dec 2008 17:42:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812231713140.5188@axis700.grange>
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

Hi all,

I have to send a command equence to the S6E63D6 SPI display controller 
(just google for it, the first non-sponsored link has a datasheet). But 
its write timing diagram made me wonder how to achieve it... It has 16-bit 
registers, and the timing diagram looks like

1. CS down
2. send 1 start byte
3. pause the clock, hold CS
4. send 2 bytes register address back-to-back
5. stop clock, CS up

similarly you send data. So, what makes me uncertain is this pattern - 1 
byte, pause, 2 bytes back-to-back. All three bytes while holding CS. I 
tried just sending a 3-byte buffer, doesn't seen to work at first. Is 
there a way to reproduce this with the current SPI API?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
