From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] spi:spi-gpio: fixed space coding styple issue
Date: Mon, 05 Jan 2015 04:36:03 -0800
Message-ID: <1420461363.2652.6.camel@perches.com>
References: <1420459263-2190-1-git-send-email-nizamhaider786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: nizamhaider786@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420459263-2190-1-git-send-email-nizamhaider786@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2015-01-05 at 17:31 +0530, nizamhaider786@gmail.com wrote:
> From: Nizam Haider <nizamhaider786@gmail.com>
> 
> fixed a coding style issue

This is a checkpatch defect and not a coding styple (style) issue.

Please don't blindly take checkpatch messages as dicta.

btw: The "From: " line in your email message body isn't necessary 
     or desired.  Please be careful with spelling/typos too.

> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
[]
> @@ -92,7 +92,7 @@ struct spi_gpio {
>  
>  /*----------------------------------------------------------------------*/
>  
> -static inline struct spi_gpio * __pure
> +static inline struct spi_gpio *__pure
