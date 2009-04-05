From: Mok Keith <ek9852-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: kernel-panic on pxa2xx_spi.c on pxa9xx cpu with
	dma enable
Date: Sun, 5 Apr 2009 11:32:54 +0800
Message-ID: <69f617130904042032o382f5084v4fe21884e2356c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

I have encounter a kernel panic, when I saw "pxa2xx-spi pxa2xx-spi.1:
dma_transfer: fifo overrun".
After dig into the code from the kernel panic log, I found that
cur_chip equals to NULL in pump_transfers function.

It is very easy to duplicated on my system running pxa9xx cpu with dma
enable (the spi working fine with pure I/O).
However if some printk is added for debugging, the problem gone.

So I cannot find out why the tasklet_schedule for pump_transfers is
called after giveback function is called without the cur_chip is set
first.

Anyone has any idea ?

Keith

------------------------------------------------------------------------------
