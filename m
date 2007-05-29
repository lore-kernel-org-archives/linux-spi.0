From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.22-rc2-git] spidev compiler
	warning gone
Date: Tue, 29 May 2007 15:02:14 -0700
Message-ID: <20070529150214.75204439.akpm@linux-foundation.org>
References: <200705251035.10587.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200705251035.10587.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 25 May 2007 10:35:07 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> Get rid of annoying GCC warning on 32-bit platforms.  The trick is to
> add an extra cast using "ptrdiff_t" to convert the u64 to the correct
> size integer, and only then casting it into a "void *" pointer.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/spi/spidev.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- g26.orig/drivers/spi/spidev.c	2007-05-24 12:04:46.000000000 -0700
> +++ g26/drivers/spi/spidev.c	2007-05-25 10:31:56.000000000 -0700
> @@ -181,7 +181,8 @@ static int spidev_message(struct spidev_
>  		}
>  		if (u_tmp->tx_buf) {
>  			k_tmp->tx_buf = buf;
> -			if (copy_from_user(buf, (const u8 __user *)u_tmp->tx_buf,
> +			if (copy_from_user(buf, (const u8 __user *)
> +						(ptrdiff_t) u_tmp->tx_buf,
>  					u_tmp->len))
>  				goto done;
>  		}
> @@ -213,7 +214,8 @@ static int spidev_message(struct spidev_
>  	buf = spidev->buffer;
>  	for (n = n_xfers, u_tmp = u_xfers; n; n--, u_tmp++) {
>  		if (u_tmp->rx_buf) {
> -			if (__copy_to_user((u8 __user *)u_tmp->rx_buf, buf,
> +			if (__copy_to_user((u8 __user *)
> +					(ptrdiff_t) u_tmp->rx_buf, buf,
>  					u_tmp->len)) {
>  				status = -EFAULT;
>  				goto done;

This seems overly tricky.  The way we normally squish that warning is
via a (long) cast.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
