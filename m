From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi-imx: Implements handling of the SPI_READY mode flag.
Date: Sun, 23 Apr 2017 20:43:52 +0200
Message-ID: <CAOiHx==nngQcOBQwvTEu4DZEBizh8NDkcjyCu19x=cNMV3xj2Q@mail.gmail.com>
References: <20170423111837.19460-1-Leif.Middelschulte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170423111837.19460-1-Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 23 April 2017 at 13:18, Leif Middelschulte
<leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Leif Middelschulte <leif.middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> This patch implements consideration of the SPI_READY mode flag as
> defined in spi.h. It extends the device tree bindings to support
> the values defined by the reference manual for the DRCTL field.
>
> Thus supporting edge-triggered and level-triggered bursts.
>
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  5 +++++
>  drivers/spi/spi-imx.c                              | 23 ++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 8bc95e2fc47f..890b3ff3325f 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

You are modifying device tree documentation, you need to CC the
appropriate mailing list as well (as I now did).

> @@ -23,6 +23,10 @@ See the clock consumer binding,
>  Obsolete properties:
>  - fsl,spi-num-chipselects : Contains the number of the chipselect
>
> +Optional properties:
> +- fsl,spi-drctl: Integer, representing the value of DRCTL. Note that to
> +enable the DRCTL consideration, the SPI_READY mode-flag needs to be set.

Maybe document the valid values here as well? Also spi-drctl isn't
really a nice name, maybe something human understandable that doesn't
require looking into the datasheet?

> +
>  Example:
>
>  ecspi@70010000 {
> @@ -35,4 +39,5 @@ ecspi@70010000 {
>                    <&gpio3 25 0>; /* GPIO3_25 */
>         dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
>         dma-names = "rx", "tx";
> +       fsl,spi-drctl = <1>;
>  };
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 9a7c62f471dc..647a4bf18705 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -95,6 +95,7 @@ struct spi_imx_data {
>         unsigned int spi_bus_clk;
>
>         unsigned int bytes_per_word;
> +       unsigned int spi_drctl;
>
>         unsigned int count;
>         void (*tx)(struct spi_imx_data *);
> @@ -246,6 +247,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  #define MX51_ECSPI_CTRL_XCH            (1 <<  2)
>  #define MX51_ECSPI_CTRL_SMC            (1 << 3)
>  #define MX51_ECSPI_CTRL_MODE_MASK      (0xf << 4)
> +#define MX51_ECSPI_CTRL_DRCTL(drctl)   ((drctl) << 16)
>  #define MX51_ECSPI_CTRL_POSTDIV_OFFSET 8
>  #define MX51_ECSPI_CTRL_PREDIV_OFFSET  12
>  #define MX51_ECSPI_CTRL_CS(cs)         ((cs) << 18)
> @@ -355,6 +357,12 @@ static int mx51_ecspi_config(struct spi_device *spi,
>          */
>         ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
>
> +       /*
> +        * Enable SPI_RDY handling (falling edge/level triggered).
> +        */
> +       if (spi->mode & SPI_READY)
> +               ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
> +
>         /* set clock speed */
>         ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
>         spi_imx->spi_bus_clk = clk;
> @@ -1173,7 +1181,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>         struct spi_master *master;
>         struct spi_imx_data *spi_imx;
>         struct resource *res;
> -       int i, ret, irq;
> +       int i, ret, irq, spi_drctl;
>
>         if (!np && !mxc_platform_info) {
>                 dev_err(&pdev->dev, "can't get the platform data\n");
> @@ -1181,6 +1189,15 @@ static int spi_imx_probe(struct platform_device *pdev)
>         }
>
>         master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
> +       ret = of_property_read_u32(np, "fsl,spi-drctl", &spi_drctl);
> +       if ((ret < 0) || (spi_drctl == 0x3)) {
> +               // '11' is reserved

Don't use C99 comments, use /* */ comments.

> +               spi_drctl = 0;

Here you say '11' is reserved and force 0 if set

> +       } else {
> +               // only the values '00', '01' and '11' are valid

And here you say '11' is valid. So which is it? Did you mean '10'?

> +               spi_drctl &= 0x3;

Also with this code flow if fsl,spi-drctl is set to <7>, it will cause
spi_drctl set to '11' / 0x3.

Maybe it would be easier to do

       if (ret < 0 || spi_drctl >= 0x3)
              spi_drctl = 0;

to only accept valid values. Assuming '11' is the invalid one and not '10'.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
