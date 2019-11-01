From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] spi: sifive: disable clk when probe fails and remove
Date: Fri, 01 Nov 2019 16:07:29 -0700 (PDT)
Message-ID: <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
References: <20191101121745.13413-1-hslester96@gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: hslester96@gmail.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, broonie@kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
To: hslester96@gmail.com
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191101121745.13413-1-hslester96@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, 01 Nov 2019 05:17:45 PDT (-0700), hslester96@gmail.com wrote:
> The driver forgets to disable and unprepare clk when probe fails and
> remove.
> Add the calls to fix the problem.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/spi/spi-sifive.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 35254bdc42c4..f7c1e20432e0 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -357,14 +357,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	if (!cs_bits) {
>  		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	num_cs = ilog2(cs_bits) + 1;
>  	if (num_cs > SIFIVE_SPI_MAX_CS) {
>  		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	/* Define our master */
> @@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  			       dev_name(&pdev->dev), spi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
> @@ -402,11 +402,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "spi_register_master failed\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	return 0;
>
> +disable_clk:
> +	clk_disable_unprepare(spi->clk);
>  put_master:
>  	spi_master_put(master);
>
> @@ -420,6 +422,7 @@ static int sifive_spi_remove(struct platform_device *pdev)
>
>  	/* Disable all the interrupts just in case */
>  	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
> +	clk_disable_unprepare(spi->clk);
>
>  	return 0;
>  }

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
