From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 13:27:04 +0200
Message-ID: <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Doug Anderson <dianders@google.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801111541.917256884@infradead.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


cc'ing Doug as he might be really interested on this patch

On 1/8/19 13:13, Peter Zijlstra wrote:
> The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> 

You say below that is not a suitable default but there is any other reason? Did
you observed problems with this?

> FIFO-99 is the very highest priority available to SCHED_FIFO and
> it not a suitable default; it would indicate the SPI work is the
> most important work on the machine.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c |    2 +-
>  drivers/spi/spi.c                     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
>  					   struct cros_ec_spi *ec_spi)
>  {
>  	struct sched_param sched_priority = {
> -		.sched_priority = MAX_RT_PRIO - 1,
> +		.sched_priority = MAX_RT_PRIO / 2,
>  	};
>  	int err;
>  
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1434,7 +1434,7 @@ static void spi_pump_messages(struct kth
>   */
>  static void spi_set_thread_rt(struct spi_controller *ctlr)
>  {
> -	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
> +	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
>  
>  	dev_info(&ctlr->dev,
>  		"will run message pump with realtime priority\n");
> 
> 
