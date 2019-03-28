From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
Date: Thu, 28 Mar 2019 20:55:22 +0100
Message-ID: <20190328205522.272e1da6@collabora.com>
References: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <bbrezillon@kernel.org>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 28 Mar 2019 16:46:24 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Call spi_mem_default_supports_op() first, before calling controller
> specific ctlr->supports_op().
> With this, controller drivers can drop checking the buswidths again.

No, this was done on purpose, in case the controller does not want the
default check to be applied (say it does not need bus-width props to
be defined and has another way to check if a device can be accessed in
dual, quad or octal mode).
Just call spi_mem_default_supports_op() from your driver
->supports_op() hook if needed.

> 
> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Details can be found at https://lkml.org/lkml/2019/3/1/183
> ---
>  drivers/spi/spi-mem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 5217a56..56aa158 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -189,11 +189,14 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
>  					 const struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	bool ret;
> +
> +	ret = spi_mem_default_supports_op(mem, op);
>  
>  	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
> -		return ctlr->mem_ops->supports_op(mem, op);
> +		ret =  ctlr->mem_ops->supports_op(mem, op);
>  
> -	return spi_mem_default_supports_op(mem, op);
> +	return ret;
>  }
>  
>  /**
