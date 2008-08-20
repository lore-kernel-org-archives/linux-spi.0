From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
	delay, cs change, transfer length
Date: Wed, 20 Aug 2008 20:34:43 -0300
Message-ID: <6669365c0808201634h616224e9m3169c562d7f676bd@mail.gmail.com>
References: <48AB900A.3070503@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48AB900A.3070503-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 20, 2008 at 12:31 AM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> My next message of this subject contains a patch for many of the issues
> raised by the threads:
>
> [PATCH] atmel_spi: support zero length transfer, 2/22/08
> [PATCH] pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode,
> 8/18/08
> pxa2xx_spi with SFRM, 8/7/08

I tested the patch regarding the CS problems, and it works fine.

Thanks Ned.

-- 
Daniel Ribeiro

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
