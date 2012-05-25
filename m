From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Keep chipselect assertion during one message
Date: Fri, 25 May 2012 16:56:11 -0600
Message-ID: <20120525225611.719313E0908@localhost>
References: <00a001cd38e0$57efde60$07cf9b20$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Kyoungil Kim' <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00a001cd38e0$57efde60$07cf9b20$%kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 23 May 2012 21:34:06 +0900, Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> During all transfers in one message, the device will not be chagned.
> So we don't need to deassert chipselect during one message.
> 
> Signed-off-by: Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-s3c64xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 972a94c..0f79f5b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -745,8 +745,6 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>  			if (list_is_last(&xfer->transfer_list,
>  						&msg->transfers))
>  				cs_toggle = 1;
> -			else
> -				disable_cs(sdd, spi);
>  		}
>  
>  		msg->actual_length += xfer->len;
> -- 
> 1.7.1
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
