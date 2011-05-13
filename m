From: viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [QUERY] amba/pl022: DMA channel allocation always fail.
Date: Fri, 13 May 2011 17:31:04 +0530
Message-ID: <4DCD1D80.7060409@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>,
	Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
To: "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Linus,

amba/pl022 and my dma driver dw_dmac.c, both have registered init() routines
with subsys_initcall(). Now at bootup, spi boots up before DMA and so DMA
channels are never available at spi probe.

What should be done to solve this issue?

One idea is allocate DMA channel as and when required, instead of allocating them
at probe. But in that case too i am not sure, that this issue will be solved.
As, if spi slave device is added from board file, then it will also try to transfer
data as soon as spi driver is up. So that too may be called before dma_probe().

-- 
viresh

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
