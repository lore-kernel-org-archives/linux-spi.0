From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Mon, 12 Apr 2010 11:03:58 +0100
Message-ID: <y2q56d259a01004120303wff208c27kf601a6b6699a48e9@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
	<x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
	<l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
	<20100410155443.GG2685@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100410155443.GG2685-WfG2TfFPcQ9S6P4I59wummXnswh1EIUO@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

and

-         if (espi->tx == 0 && espi->rx == 0)
-                 espi->fifo_level = 0;

since it's always created as 0 and is always reset to 0 by the end of a transfer

and if you like

          /* is transfer finished? */
-         if (espi->tx == t->len && espi->rx == t->len) {
+         if (espi->fifo_level == 0) {

to save a couple of instructions

    M

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
