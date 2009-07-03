From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Fix "not ready" timeout
	after write in at25
Date: Thu, 2 Jul 2009 18:48:36 -0700
Message-ID: <200907021848.36757.david-b@pacbell.net>
References: <4A2CE07F.2060302@who-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4A2CE07F.2060302-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 08 June 2009, Sebastian Heutling wrote:
> Under certain circumstances msleep(1) within the loop, which waits
> for the EEPROM to be finished, might take longer than the timeout.
> On the next loop the status register might return to be ready and 
> therefore the loop finishes. The following check now tests if
> a timeout occurred and if so returns an error although the device
> reported to be finished.
> This fix replaces testing the occurrence of the timeout by testing
> the "not ready" bit in the status register.
> The patch is against 2.6.29.2.

This got badly mangled by your mailer.  Care to re-send?

> 
> Signed-off-by: Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>
> 
> ---
>   drivers/misc/eeprom/at25.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 290dbe9..ea83604 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -160,6 +160,7 @@ at25_ee_write(struct at25_data *at25, char *buf, 
> loff_t off, size_t count)
>   	bounce[0] = AT25_WRITE;
>   	mutex_lock(&at25->lock);
>   	do {
> +		int	sr;
>   		unsigned long	timeout, retries;
>   		unsigned	segment;
>   		unsigned	offset = (unsigned) off;
> @@ -205,7 +206,6 @@ at25_ee_write(struct at25_data *at25, char *buf, 
> loff_t off, size_t count)
>   		timeout = jiffies + msecs_to_jiffies(EE_TIMEOUT);
>   		retries = 0;
>   		do {
> -			int	sr;
>    			sr = spi_w8r8(at25->spi, AT25_RDSR);
>   			if (sr < 0 || (sr & AT25_SR_nRDY)) {
> @@ -219,7 +219,7 @@ at25_ee_write(struct at25_data *at25, char *buf, 
> loff_t off, size_t count)
>   				break;
>   		} while (retries++ < 3 || time_before_eq(jiffies, timeout));
>   -		if (time_after(jiffies, timeout)) {
> +		if ((sr < 0) || (sr & AT25_SR_nRDY)) {
>   			dev_err(&at25->spi->dev,
>   				"write %d bytes offset %d, "
>   				"timeout after %u msecs\n",
> -- 
> 1.6.3.2

------------------------------------------------------------------------------
