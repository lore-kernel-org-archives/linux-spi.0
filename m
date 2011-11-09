From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 3/6] spi/pl022: disable the PL022 block when unused
Date: Wed, 9 Nov 2011 16:23:24 +0530
Message-ID: <4EBA5BA4.8030504@st.com>
References: <1320835146-31268-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	Virupax SADASHIVPETIMATH <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1320835146-31268-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
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
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> Make sure we clear the enable bit when the block is not used.
> This will save some energy in certain hardware versions.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-pl022.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 305f2ba..fa3eaae 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -512,6 +512,11 @@ static void giveback(struct pl022 *pl022)
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> +
> +	/* disable the SPI/SSP operation */
> +	writew((readw(SSP_CR1(pl022->virtbase)) &
> +		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> +
>  	/* This message is completed, so let's turn off the clocks & power */
>  	pm_runtime_put(&pl022->adev->dev);
>  }

Reviewed-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

-- 
viresh

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
