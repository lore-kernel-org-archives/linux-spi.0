From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Wed, 21 Nov 2012 17:44:21 +0530
Message-ID: <CAM=Q2cu6ReS-6sJxdacnw=FYGdoFed9bM1gA6yFEtmVjs8KQTA@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353464203.20353.6.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 21, 2012 at 7:46 AM, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> +       /* Create the PM_QOS request */
> +       if (drv_context->quirks & QUIRKS_USE_PM_QOS)
> +               pm_qos_add_request(&drv_context->pm_qos_req,
> +               PM_QOS_CPU_DMA_LATENCY,
> +               PM_QOS_DEFAULT_VALUE);
>

What happens if the flag is not set if it is absolutely necessary for the
driver it should not be a
configurable option?
------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
