From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: spi-bfin5xx: flush spi after each transfer
Date: Fri, 27 Apr 2012 12:35:01 -0600
Message-ID: <20120427183501.16C8E3E171B@localhost>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<1335219493-24184-6-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-6-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 23 Apr 2012 18:18:13 -0400, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This can make sure last bit has been shifted out of register.
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Okay, so I have a few issues about the way this series was
submitted, but I've gone ahead and applied them anyway to get them off
my plate since they look like bug fixes.

The problem is that the commit text is far from complete.  Take for
example the commit text from this patch:

> This can make sure last bit has been shifted out of register.

So, what does that tell me?  Not a whole lot.  It tells me that a bit
needs to be shifted out, but nothing about when or where that is
needed.  I can *guess* that this is a bug fix, but there is nowhere
that says that is what it does.

The commit text needs to give a lot more information about why a patch
is needed.  It should answer the following questions:
1) What is the problem
2) how does the problem occur; what are the symptoms
3) A description of the fix and/or how this patch fixes the problem
4) some details about how the patch was tested.

So, for example, I might write something like this for the commit
text (I'm guessing at details here for the purpose of an example):

	The bfin5xx spi driver has a bug where the last bit of a
	transfer does not get properly shifted out onto the bus until
	another transfer gets scheduled.  This means that the last
	transfer sent will stall and never complete if there aren't
	any other transfers ready to be sent.

	This patch fixes the problem by calling the bfin_spi_flush()
	routine at the end of each transfer which ensures that all
	bits get properly shifted out when a transfer completes.

	Tested on the ACME Magic 8-ball blackfin board attached to a
	spi LED strip.

See?  That tells me immediately that this is a bug fix and specific
problem it solves which helps me decide whether or not I need to apply
it for -next or -merge.  It also helps anyone in the future if they
need to bisect changes on this driver.

For future changes, I expect the commit text to be more complete.

Thanks,
g.

> ---
>  drivers/spi/spi-bfin5xx.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
> index 432d019..9bb4d4a 100644
> --- a/drivers/spi/spi-bfin5xx.c
> +++ b/drivers/spi/spi-bfin5xx.c
> @@ -587,6 +587,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  	if (message->state == DONE_STATE) {
>  		dev_dbg(&drv_data->pdev->dev, "transfer: all done!\n");
>  		message->status = 0;
> +		bfin_spi_flush(drv_data);
>  		bfin_spi_giveback(drv_data);
>  		return;
>  	}
> @@ -870,8 +871,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  		message->actual_length += drv_data->len_in_bytes;
>  		/* Move to next transfer of this msg */
>  		message->state = bfin_spi_next_transfer(drv_data);
> -		if (drv_data->cs_change)
> +		if (drv_data->cs_change && message->state != DONE_STATE) {
> +			bfin_spi_flush(drv_data);
>  			bfin_spi_cs_deactive(drv_data, chip);
> +		}
>  	}
>  
>  	/* Schedule next transfer tasklet */
> -- 
> 1.7.0.4
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
