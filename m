From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
 deasserting CS on PIO mode
Date: Mon, 18 Aug 2008 14:53:09 -0400
Message-ID: <48A9C515.3000908@whoi.edu>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808171553i3f64b667t18fcea589d94411a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Daniel Ribeiro wrote:
> Hi,
> 
> I am converting a driver from ssp.c API to pxa2xx_spi. But
> when using PIO mode i am getting bogus rx data.
> 
> I did some tests, and it looks like CS is being deasserted
> before the IO is done.
> 
> The following patch solved the issue for me.

Can you be more specific about your problem?  If CS is not being
asserted/deasserted at the right times, then that needs to be fixed.
What are you using for CS; this driver only works correctly when a GPIO
pin is assigned for CS, and is controlled with the cs_control() callback.

The below patch seems to paper over some other problem.
wait_ssp_rx_stall() is used to recover from errors, by flushing and
discarding words from the RX fifo.  Also, int_transfer_complete() is
only called from places where we know that all expected characters have
been received and transferred to memory.

This patch would "fix" a situation where extra words are in the RX FIFO
after the expected number have been read.  If there are more characters
in the FIFO than were transmitted, then that needs to be fixed and not
ignored.

Can you provide a patch or more information that addresses the
underlying problem?

> pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode
> 
> Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index 0c452c4..4a9c34e 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -593,6 +593,10 @@ static void int_transfer_complete(struct driver_data *drv_data)
>  {
>  	void __iomem *reg = drv_data->ioaddr;
>  
> +	if (wait_ssp_rx_stall(drv_data->ioaddr) == 0)
> +		dev_err(&drv_data->pdev->dev,
> +			"interrupt_transfer: ssp rx stall failed\n");
> +
>  	/* Stop SSP */
>  	write_SSSR(drv_data->clear_sr, reg);
>  	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
> 
> 


-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
