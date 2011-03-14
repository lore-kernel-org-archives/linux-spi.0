From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Support DMA transfers larger than 65535
	words
Date: Mon, 14 Mar 2011 13:25:11 +0300
Message-ID: <4D7DED07.7020000@mvista.com>
References: <1300026862-1179-1-git-send-email-michael.williamson@criticallink.com>
	<1300026862-1179-2-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1300026862-1179-2-git-send-email-michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello.

On 13-03-2011 17:34, Michael Williamson wrote:

> The current davinci SPI driver, in DMA mode, is limited to 65535
> words for a single transfer.  Modify the driver by configuring a
> 3 dimensional EDMA transfer to support up to 65535x65535
> words.

> Signed-off-by: Michael Williamson<michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
[...]

> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 037ba82..411cc32 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
[...]
> @@ -599,14 +600,30 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
>   			}
>   		}
>
> +		/*
> +		 * If number of words is greater than 65535, then we need
> +		 * to configure a 3 dimension transfer.  Use the BCNTRLD
> +		 * feature to allow for transfers that aren't even multiples
> +		 * of 65535 (or any other possible b size) by first transferring
> +		 * the remainder amount then grabbing the next N blocks of
> +		 * 65535 words.
> +		 */
> +
> +		c = dspi->wcount/(SZ_64K-1);	/* N 65535 count Blocks */
> +		b = dspi->wcount-c*(SZ_64K-1);	/* Remainder */

    The driver style (and general Linux kernel style) assumes spaces around 
operators.

WRB, Sergei
