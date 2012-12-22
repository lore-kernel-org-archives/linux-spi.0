From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: use request_threaded_irq() to fix deadlock
Date: Sat, 22 Dec 2012 10:08:03 +0000
Message-ID: <20121222100803.88FCE3E0AD0@localhost>
References: <1356120806-27964-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Thomas Gleixner <tglx-ypw0egVD2fIeQtMskbmMgg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356120806-27964-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 21 Dec 2012 15:13:26 -0500, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> With RT pre-empt patch applied to Linux kernel, the irq handler will be
> force converted to an irq thread. spi driver can get back to back messages
> from the slave device. In such cases, IRQ thread doesn't get a chance to
> run to read the slave data. Hence the irq handler must be run in hard irq
> context to read/write data from slave device. Otherwise, the kernel goes
> into a deadlock. This patch fixes this issue when PREEMPT_RT_FULL is
> enabled in the kernel. A dummy thread function is provided to satisfy the
> request_threaded_irq() API. Passing a NULL for function also causes the
> irq handler to be executed in the thread context.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>

Thomas, would you mind taking a look at this for me. My gut feel is that
this is the wrong way to solve the problem that Murali is having and
that it really just hacks something that works.

It seems to me that what the driver should do is disable the irq
in the handler, and then perform the regular work in the thread. After
all the pending data is processed, then it should reenable the interrupts.

Passing in a dummy thread function just looks wrong.

g.

> ---
>  drivers/spi/spi-davinci.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 50bd2cd..8234d22 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -702,6 +702,19 @@ err_alloc_dummy_buf:
>  }
>  
>  /**
> + * dummy_thread_fn - dummy thread function
> + * @irq: IRQ number for this SPI Master
> + * @context_data: structure for SPI Master controller davinci_spi
> + *
> + * This is to satisfy the request_threaded_irq() API so that the irq
> + * handler is called in interrupt context.
> + */
> +static irqreturn_t dummy_thread_fn(s32 irq, void *data)
> +{
> +	return IRQ_HANDLED;
> +}
> +
> +/**
>   * davinci_spi_irq - Interrupt handler for SPI Master Controller
>   * @irq: IRQ number for this SPI Master
>   * @context_data: structure for SPI Master controller davinci_spi
> @@ -899,8 +912,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  		goto unmap_io;
>  	}
>  
> -	ret = request_irq(dspi->irq, davinci_spi_irq, 0, dev_name(&pdev->dev),
> -									dspi);
> +	ret = request_threaded_irq(dspi->irq, davinci_spi_irq, dummy_thread_fn,
> +				 0, dev_name(&pdev->dev), dspi);
>  	if (ret)
>  		goto unmap_io;
>  
> -- 
> 1.7.9.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
