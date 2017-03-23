From: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 11:51:33 +0100
Message-ID: <8946695.jF9BQzhoEd@ws-stein>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de> <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

interesting, but why is this property specific to bcm2835 when the priority is 
used in generic code only?

Best regards,
Alexander

On Thursday 23 March 2017 11:36:45, Lukas Wunner wrote:
> Revolution Pi (a set of IoT products based on the Raspberry Pi and
> geared towards industrial usage) uses the bcm2835's SPI master to
> interface with an IEC 61158 fieldbus, which requires its kworker thread
> to run at a realtime priority.  To this end, allow the platform to
> specify the desired priority.
> 
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt | 4 ++++
>  drivers/spi/spi-bcm2835.c                                  | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
> b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt index
> f11f295c8450..13ffc2b15e7d 100644
> --- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
> @@ -10,6 +10,10 @@ Required properties:
>  - interrupts: Should contain interrupt.
>  - clocks: The clock feeding the SPI controller.
> 
> +Optional properties:
> +- bcm2835,rt_prio: Realtime priority of the message pump to minimize
> latency +                   on the bus (0..99).
> +
>  Example:
> 
>  spi@20204000 {
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index f35cc10772f6..319523686f73 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -755,6 +755,8 @@ static int bcm2835_spi_probe(struct platform_device
> *pdev) master->handle_err = bcm2835_spi_handle_err;
>  	master->prepare_message = bcm2835_spi_prepare_message;
>  	master->dev.of_node = pdev->dev.of_node;
> +	of_property_read_u32(pdev->dev.of_node,
> +			     "bcm2835,rt_prio", &master->rt_prio);
> 
>  	bs = spi_master_get_devdata(master);

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
