From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Linux SPI slave support
Date: Sat, 30 Jun 2012 05:15:41 +0200
Message-ID: <201206300515.41575.marex@denx.de>
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

is there currently any ongoing effort to support SPI slave mode in Linux?

If there is none, could you please share any hints that might help me better 
choose and go in the direction of implementing the SPI slave support?

I had this quick idea of simply extending the flags field of struct spi_master 
{} by something like SPI_MASTER_CAN_BE_SWITCHED_TO_SLAVE_MODE (shortened of 
course). Then there'd have to be a function present that can switch the mode, 
also in struct spi_master it seems. And then, any driver willing to use the 
slave support will simply call this switch function. Something amongst those 
lines maybe? Basically, the idea would be to have SPI slave mode drivers and 
master mode drivers using the same API, just make the bus configured 
differently.

Please advise. Thanks in advance!

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
