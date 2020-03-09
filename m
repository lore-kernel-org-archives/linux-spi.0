From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: spi-fsl-dspi: Add support for LS1028A
Date: Mon, 09 Mar 2020 19:38:48 +0100
Message-ID: <02a2816d2f39bf621dfee543ed612ae0@walle.cc>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-5-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309145624.10026-5-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> 
> This is similar to the DSPI instantiation on LS1028A, except that:
>  - The A-011218 erratum has been fixed, so DMA works
>  - The endianness is different, which has implications on XSPI mode
> 
> Some benchmarking with the following command:
> 
> spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter
> 10000000 --speed 20000000
> 
> shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
> mode, the same command goes up to 4700 kbps. This is somewhat to be
> expected, since the DMA buffer size is extremely small at 8 bytes, the
> winner becomes whomever can prepare the buffers for transmission
> quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
> been chosen as the operating mode for this chip.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 5624b9ee77db..264d184e7296 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -131,6 +131,7 @@ struct fsl_dspi_devtype_data {
>  enum {
>  	LS1021A,
>  	LS1012A,
> +	LS1028A,
>  	LS1043A,
>  	LS1046A,
>  	LS2080A,
> @@ -163,6 +164,14 @@ static const struct fsl_dspi_devtype_data
> devtype_data[] = {
>  		.pushr_cmd		= 0,
>  		.pushr_tx		= 2,
>  	},
> +	[LS1028A] = {
> +		.trans_mode		= DSPI_DMA_MODE,

shouldn't this be DSPI_XSPI_MODE according to your cover letter?

-michael

> +		.dma_bufsize		= 8,
> +		.max_clock_factor	= 8,
> +		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
> +	},
>  	[LS1043A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
> @@ -1113,6 +1122,9 @@ static const struct of_device_id 
> fsl_dspi_dt_ids[] = {
>  	}, {
>  		.compatible = "fsl,ls1012a-dspi",
>  		.data = &devtype_data[LS1012A],
> +	}, {
> +		.compatible = "fsl,ls1028a-dspi",
> +		.data = &devtype_data[LS1028A],
>  	}, {
>  		.compatible = "fsl,ls1043a-dspi",
>  		.data = &devtype_data[LS1043A],
