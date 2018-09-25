From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Fix inverted logic in op sanity check
Date: Tue, 25 Sep 2018 11:58:23 +0200
Message-ID: <20180925115823.3dd07cda@bbrezillon>
References: <20180925094655.11438-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925094655.11438-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 25 Sep 2018 11:46:55 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> On r8a7791/koelsch:
> 
>     m25p80 spi0.0: error -22 reading 9f
>     m25p80: probe of spi0.0 failed with error -22
> 
> Apparently the logic in spi_mem_check_op() is wrong, rejecting the
> spi-mem operation if any buswidth is valid, instead of invalid.
> 
> Fixes: 380583227c0c7f52 ("spi: spi-mem: Add extra sanity checks on the op param")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Sorry for the mess :-/, and thanks for reporting/fixing it.

> ---
>  drivers/spi/spi-mem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index cc3d425aae56c634..62a7b80801d22098 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -169,10 +169,10 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
>  	    (op->data.nbytes && !op->data.buswidth))
>  		return -EINVAL;
>  
> -	if (spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
> -	    spi_mem_buswidth_is_valid(op->addr.buswidth) ||
> -	    spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
> -	    spi_mem_buswidth_is_valid(op->data.buswidth))
> +	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
> +	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
> +	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
> +	    !spi_mem_buswidth_is_valid(op->data.buswidth))
>  		return -EINVAL;
>  
>  	return 0;
