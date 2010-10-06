From: Sergii Kovalchuk <sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Assert CS, wait for IRQ, write data sequence
Date: Wed, 6 Oct 2010 16:49:45 +0300
Message-ID: <201010061649.45237.sentinelofsetch@gmail.com>
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

I'm implementing an SPI protocol driver for TI WL12xx combo chip. According to 
the spec, for write transaction I should complete the following sequence:

1. Assert CS
2. Wait until chip will trigger IRQ
3. Write data

Looking at spi_transfer structure I wondering, how I can implement such logic 
- there is no explicit ways to implement "wait for an event" within single 
spi_message processing.
 
As current workarround I use a simple delay in 5 us, but for sleep states it 
might be not sufficient, since wake-up time are ususally greater.


It would be appropriate to assert CS manually, wait for IRQ and then start the 
data transfer, but may be there is some more essential way to accomplish this?

--
Best regards,
Sergii Kovalchuk

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
