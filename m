From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bitbang: support the new
	SPI_BOARD_FLAG_RELEASE_CS flag
Date: Sat, 17 Mar 2012 22:42:13 +0000
Message-ID: <20120317224213.ED0FF3E03CC@localhost>
References: <Pine.LNX.4.64.1203152228430.2988@axis700.grange>
	<Pine.LNX.4.64.1203152230190.2988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1203152230190.2988-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 15 Mar 2012 22:32:14 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> By supporting the new SPI_BOARD_FLAG_RELEASE_CS flag we let underlying
> hardware drivers implement more efficient runtime power-management.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/spi/spi-bitbang.c |   22 ++++++++++------------
>  1 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index fe06e1b..c895d85 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -347,17 +347,14 @@ static void bitbang_work(struct work_struct *work)
>  			if (t->delay_usecs)
>  				udelay(t->delay_usecs);
>  
> -			if (!cs_change)
> -				continue;
> -			if (t->transfer_list.next == &m->transfers)
> -				break;
> -
> -			/* sometimes a short mid-message deselect of the chip
> -			 * may be needed to terminate a mode or command
> -			 */
> -			ndelay(nsecs);
> -			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> -			ndelay(nsecs);
> +			if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
> +				/* sometimes a short mid-message deselect of the chip
> +				 * may be needed to terminate a mode or command
> +				 */
> +				ndelay(nsecs);
> +				bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> +				ndelay(nsecs);
> +			}
>  		}
>  
>  		m->status = status;
> @@ -367,7 +364,8 @@ static void bitbang_work(struct work_struct *work)
>  		 * cs_change has hinted that the next message will probably
>  		 * be for this chip too.
>  		 */
> -		if (!(status == 0 && cs_change)) {
> +		if (!(status == 0 && cs_change) ||
> +		    spi->flags & SPI_BOARD_FLAG_RELEASE_CS) {

That's rather heavy handed, and will probably break drivers that lock the spi
bus to guarantee concurrent messages (like the MMC layer).  I don't think you
can do it this way.

It might be okay to force CS disable if the spi bus hasn't been exclusively
locked.  I know the comment talks about hinting (possibly for performance reasonse),
but I'm more interested in correctness at this point.

g.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
