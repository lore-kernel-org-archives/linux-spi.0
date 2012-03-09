From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi-topcliff-pch: fix -Wuninitialized warning
Date: Fri, 09 Mar 2012 14:43:37 -0700
Message-ID: <20120309214337.A06483E0880@localhost>
References: <1329230103-26465-1-git-send-email-danny.kukawka@bisect.de>
Content-Type: multipart/mixed; boundary="===============0872061310869337100=="
Cc: Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Danny Kukawka <dkukawka-l3A5Bk7waGM@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Danny Kukawka <danny.kukawka-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1329230103-26465-1-git-send-email-danny.kukawka-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============0872061310869337100==

On Tue, 14 Feb 2012 15:35:03 +0100, Danny Kukawka <danny.kukawka-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org> wrote:
> Fix for:
> drivers/spi/spi-topcliff-pch.c: In function ‘pch_spi_handler_sub’:
> drivers/spi/spi-topcliff-pch.c:325:17: warning: ‘bpw_len’ may be
>   used uninitialized in this function [-Wuninitialized]
> drivers/spi/spi-topcliff-pch.c:325:42: warning: ‘rx_index’ may be
>   used uninitialized in this function [-Wuninitialized]
> drivers/spi/spi-topcliff-pch.c:325:42: warning: ‘tx_index’ may be
>   used uninitialized in this function [-Wuninitialized]
> 
> Move usage of tx_index, rx_index and bpw_len into the same
> block as where they are set to prevent uninitialized usage.
> 
> v2: instead of init variables with 0 move the whole block
> 
> Signed-off-by: Danny Kukawka <danny.kukawka-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>

Applied, thanks

g.

> ---
>  drivers/spi/spi-topcliff-pch.c |   33 +++++++++++++++----------------
>  1 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 10182eb..1107469 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -318,22 +318,23 @@ static void pch_spi_handler_sub(struct pch_spi_data *data, u32 reg_spsr_val,
>  		data->tx_index = tx_index;
>  		data->rx_index = rx_index;
>  
> -	}
> -
> -	/* if transfer complete interrupt */
> -	if (reg_spsr_val & SPSR_FI_BIT) {
> -		if ((tx_index == bpw_len) && (rx_index == tx_index)) {
> -			/* disable interrupts */
> -			pch_spi_setclr_reg(data->master, PCH_SPCR, 0, PCH_ALL);
> -
> -			/* transfer is completed;
> -			   inform pch_spi_process_messages */
> -			data->transfer_complete = true;
> -			data->transfer_active = false;
> -			wake_up(&data->wait);
> -		} else {
> -			dev_err(&data->master->dev,
> -				"%s : Transfer is not completed", __func__);
> +		/* if transfer complete interrupt */
> +		if (reg_spsr_val & SPSR_FI_BIT) {
> +			if ((tx_index == bpw_len) && (rx_index == tx_index)) {
> +				/* disable interrupts */
> +				pch_spi_setclr_reg(data->master, PCH_SPCR, 0,
> +						   PCH_ALL);
> +
> +				/* transfer is completed;
> +				   inform pch_spi_process_messages */
> +				data->transfer_complete = true;
> +				data->transfer_active = false;
> +				wake_up(&data->wait);
> +			} else {
> +				dev_err(&data->master->dev,
> +					"%s : Transfer is not completed",
> +					__func__);
> +			}
>  		}
>  	}
>  }
> -- 
> 1.7.7.3
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.


--===============0872061310869337100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============0872061310869337100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0872061310869337100==--
