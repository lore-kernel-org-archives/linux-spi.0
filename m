From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [patch 2.6.25-git] pxa2xx_spi clock resume
 bugfix
Date: Tue, 29 Apr 2008 21:13:16 -0400
Message-ID: <4817C7AC.7050609@whoi.edu>
References: <200804291608.53088.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Eric BENARD <ebenard-GANU6spQydw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804291608.53088.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
> From: Eric BENARD <ebenard-GANU6spQydw@public.gmane.org>
> 
> There is a typo in pxa2xx_spi.c, comment says "Enable the SSP clock", 
> code says: clk_disable ... so after resume, the SSP is dead.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/spi/pxa2xx_spi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a.orig/drivers/spi/pxa2xx_spi.c	2008-04-28 21:56:43.000000000 -0700
> +++ a/drivers/spi/pxa2xx_spi.c	2008-04-29 16:02:10.000000000 -0700
> @@ -1567,7 +1567,7 @@ static int pxa2xx_spi_resume(struct plat
>  	int status = 0;
>  
>  	/* Enable the SSP clock */
> -	clk_disable(ssp->clk);
> +	clk_enable(ssp->clk);
>  
>  	/* Start the queue running */
>  	status = start_queue(drv_data);

Quite right.  The original pxa2xx_spi.c had this right, but the patch by
Eric Miao, merged on 2008/1/26, introduced this error.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
