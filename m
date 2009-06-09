From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/9] SPI: xilinx_spi: Added platform
 driver and support for DS570
Date: Tue, 9 Jun 2009 16:09:54 -0700
Message-ID: <20090609160954.ae0bda8e.akpm@linux-foundation.org>
References: <4A292043.70704@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4A292043.70704-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 05 Jun 2009 15:40:19 +0200
Richard R__jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org> wrote:

> This patch splits xilinx_spi into three parts, an OF and a platform
> driver and generic part.
> 
> The generic part now also works on X86 and also supports the Xilinx
> SPI IP DS570

Unfortunately we already have two fairly significant
drivers/spi/xilinx_spi.c patches queued in -mm:
spi-move-more-spi_setup-functionality-into-core.patch and
spi-move-common-spi_setup-functionality-into-core.patch.  Applying this
patch on top of those makes rather a mess.

Hopefully things will still be OK if I skip this patch.  You didn't
identify the dependencies between those nine patchs.  Can you please
explain that?


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
