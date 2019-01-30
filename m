From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 5/9] spi: atmel-quadspi: return appropriate error code
Date: Wed, 30 Jan 2019 18:21:00 +0100
Message-ID: <20190130182100.3429fa36@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-6-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-6-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
> the error in atmel_qspi_exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/spi/atmel-quadspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 3643f0c851b0..e6de6e3d1345 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -208,7 +208,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
>  		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
>  			return i;
>  
> -	return -1;
> +	return -ENOTSUPP;
>  }
>  
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
> @@ -239,7 +239,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
> -		return -ENOTSUPP;
> +		return mode;
>  
>  	ifr |= sama5d2_qspi_modes[mode].config;
>  
