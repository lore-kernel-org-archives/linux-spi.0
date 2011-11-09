From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 5/6] spi/pl022: move device disable to workqueue thread
Date: Wed, 9 Nov 2011 16:29:20 +0530
Message-ID: <4EBA5D08.1010107@st.com>
References: <1320835162-31337-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Christopher BLAIR <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1320835162-31337-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
> From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index bffad2a..2e3522d 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -512,13 +512,6 @@ static void giveback(struct pl022 *pl022)
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> -
> -	/* disable the SPI/SSP operation */
> -	writew((readw(SSP_CR1(pl022->virtbase)) &
> -		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> -

We added this in an earlier patch in the same patchset. It would be better
if we can shift that patch after this one.

> -	/* This message is completed, so let's turn off the clocks & power */
> -	pm_runtime_put(&pl022->adev->dev);
>  }
>  
>  /**
> @@ -1513,10 +1506,17 @@ static void pump_messages(struct work_struct *work)
>  	struct pl022 *pl022 =
>  		container_of(work, struct pl022, pump_messages);
>  	unsigned long flags;
> +	bool was_busy = false;
>  
>  	/* Lock queue and check for queue work */
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
>  	if (list_empty(&pl022->queue) || !pl022->running) {
> +		if (pl022->busy) {
> +			/* nothing more to do - disable spi/ssp and power off */
> +			writew((readw(SSP_CR1(pl022->virtbase)) &
> +				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> +			pm_runtime_put(&pl022->adev->dev);
> +		}

Probably it will look better if we add a blank line here.

-- 
viresh

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
