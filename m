From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 22 Nov 2012 11:04:19 +0000
Message-ID: <20121122110419.5e08f6cf@bob.linux.org.uk>
References: <1353464203.20353.6.camel@bichao>
	<CAM=Q2cu6ReS-6sJxdacnw=FYGdoFed9bM1gA6yFEtmVjs8KQTA@mail.gmail.com>
	<20121121122630.13fc2087@bob.linux.org.uk>
	<CAM=Q2cuCZni2DyzDux-E5H4-djgNrUURTYJ+f=_oMBeJE7eGMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2cuCZni2DyzDux-E5H4-djgNrUURTYJ+f=_oMBeJE7eGMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> Thats what I was trying to understand.
> 
> If I am not wrong the latency is time related.
> Why only some platforms / modes need it also the value is not speed
> dependent.

Because the problem was fixed in the later devices.

> Also the spi core today doesnt have slave mode support thats a
> different discussion altogether may be we can leave it for now.

I'd rather we kept the support in the driver ready for that.

Alan

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
