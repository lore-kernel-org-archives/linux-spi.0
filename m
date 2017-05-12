From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/6] spi: sh-msiof: Add slave mode support
Date: Fri, 12 May 2017 10:14:34 -0500
Message-ID: <20170512151434.bwzak7rqna3racdq@rob-hp-laptop>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be>
 <1493919951-32122-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493919951-32122-5-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, May 04, 2017 at 07:45:49PM +0200, Geert Uytterhoeven wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Add slave mode support to the MSIOF driver, in both PIO and DMA mode.
> 
> For now this only supports the transmission of messages with a size
> that is known in advance.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> [geert: Timeout handling cleanup, spi core integration, cancellation,
> 	rewording]
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v3:
>   - Clear TIF_SIGPENDING when interrupted to fix cancellation,
>   - Extract sh_msiof_wait_for_completion(),
>   - Add #include <linux/sched/signal.h>,
>   - Convert to use spi_alloc_slave(),
> 
> v2:
>   - Document "spi-slave" property in DT bindings,
>   - Use spi_controller_is_slave() helper,
>   - Check for "spi-slave" property instead of "slave" child node,
>   - Replace SPI_MASTER_IS_SLAVE by SPI_CONTROLLER_IS_SLAVE,
>   - Implement cancellation.
> ---
>  Documentation/devicetree/bindings/spi/sh-msiof.txt |   2 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/spi/spi-sh-msiof.c                         | 121 +++++++++++++++------
>  include/linux/spi/sh_msiof.h                       |   6 +
>  3 files changed, 96 insertions(+), 33 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
