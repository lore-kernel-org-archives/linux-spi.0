From: Dimitar Penev <dpenev-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: general question: spi framework
Date: Fri, 28 May 2010 03:40:18 -0700 (PDT)
Message-ID: <875452.33839.qm@web31802.mail.mud.yahoo.com>
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

Hi Guys,

I have a pretty general question about the spi framework.
I hope this is not off topic for this list.

So it is about uclinux kernel 2.6.28 for blackfin cpu. 

1. I undestand how to define my spi data in the board file. 
2. I have kernel device driver for my spi chip.
3. I have read about linux/spi/spi.h and the spi protocol driver API which
   is exported. 
spi_read(struct spi_device *spi, u8 *buf, size_t len)
spi_write(struct spi_device *spi, const u8 *buf, size_t len)
etc ...

I would like to use this API from another kernel module (so kernel space)
For me it is unclear however how to get pointer to spi_device from my kernel module. In general is there somewhere an example for using of the spi framework from the kernel space. 
I don't want to write spi device drivers. It is already written in the linux tree. I would like to use it from the kernel space.     

Thank you for all pointers you provide!
Dimitar
  





      

------------------------------------------------------------------------------
