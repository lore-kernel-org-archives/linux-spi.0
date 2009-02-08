From: roel kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa2xx_spi: spi_bfin5xx: limit reaches -1
	rather than 0
Date: Sun, 8 Feb 2009 17:59:10 +0100
Message-ID: <25e057c00902080859w3d9973a1u1e73450d37e20459@mail.gmail.com>
References: <498F0004.1030709@gmail.com>
	<200902080807.29237.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200902080807.29237.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/2/8 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:
> On Sunday 08 February 2009, Roel Kluin wrote:
>> vi drivers/spi/pxa2xx_spi.c +919
>> vi drivers/spi/spi_bfin5xx.c +645
>>
>>         if (flush(drv_data) == 0) {
>>                 dev_err(&drv_data->pdev->dev, "pump_transfers: flush failed\n");
>>                 message->status = -EIO;
>>                 giveback(drv_data);
>>                 return;
>>         }
>>
>> But with a postfix decrement limit reaches -1 rather than 0.
>>
>> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

could you please review the patch at http://lkml.org/lkml/2009/2/8/72
instead? I initially overlooked two similar issues in the same file.

> Although, note that if the *actual* count mattered here,
> the correect patch would be to test "flush() < 0)" ...
> except when using a "do {...} while (--limit)" idiom.

True. You can also increase the limit with 1 when changing post- to
prefix for the while (--limit) {...} idiom.

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
