From: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Subject: Re: [uClinux-dev] [PATCH] m68knommu: Coldfire QSPI platform support
Date: Fri, 10 Dec 2010 08:46:35 -0800
Message-ID: <201012100846.36080.sfking@fdwdc.com>
References: <201001221243.04045.sfking@fdwdc.com>
	<4CA17F2D.7000407@snapgear.com>
	<6C2434209962DC46B88345CA85C334A2A434E65AF7@Courier.syntech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	'Greg Ungerer' <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>
To: Jate Sujjavanich <jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6C2434209962DC46B88345CA85C334A2A434E65AF7-sZuHJe4yGqVM6S7uvVHM8UB+6BGkLq7r@public.gmane.org>
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

On Wednesday 29 September 2010 06:44:32 Jate Sujjavanich wrote:
> Here's a patch for your review.
>
>
> After grabbing a msg from the msgq, the mcfqspi_work function calls
> list_del_init on the mcfqspi->msgq which unintentionally deletes the rest
> of the list before it can be processed. If qspi call was made using
> spi_sync, this can result in a process hang.
>
> Signed-off by Jate Sujjavanich<jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>
> -----------
> diff --git a/drivers/spi/coldfire_qspi.c b/drivers/spi/coldfire_qspi.c
> index 59be3ef..0aa00af 100644
> --- a/drivers/spi/coldfire_qspi.c
> +++ b/drivers/spi/coldfire_qspi.c
> @@ -316,7 +316,7 @@ static void mcfqspi_work(struct work_struct *work)
>                  msg = container_of(mcfqspi->msgq.next, struct spi_message,
>                                     queue);
> -               list_del_init(&mcfqspi->msgq);
> +               list_del_init(&msg->queue);
>                  spin_unlock_irqrestore(&mcfqspi->lock, flags);
>                  spi = msg->spi;
>


A belated ack.

Grant, can we still get this into .37?

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
