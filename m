From: Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: RE: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
Date: Tue, 3 Apr 2018 07:24:47 +0000
Message-ID: <1c12d20a40384fc78262bcd82c68ba6a@SFHDAG3NODE2.st.com>
References: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>, Mark Brown
 <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "Alexandre TORGUE" <alexandre.torgue@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi,

> -----Original Message-----
> From: Alexey Khoroshilov [mailto:khoroshilov@ispras.ru]
> Sent: vendredi 30 mars 2018 21:55
> To: Mark Brown <broonie@kernel.org>; Amelie DELAUNAY
> <amelie.delaunay@st.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>; linux-spi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; ldv-
> project@linuxtesting.org
> Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
> 
> clk_get_rate() is below clk_prepare_enable(), so its error should lead to goto
> err_clk_disable, not to err_master_put.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/spi/spi-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c index
> ba9743fa2326..ad1e55d3d5d5 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1129,7 +1129,7 @@ static int stm32_spi_probe(struct platform_device
> *pdev)
>  	if (!spi->clk_rate) {
>  		dev_err(&pdev->dev, "clk rate = 0\n");
>  		ret = -EINVAL;
> -		goto err_master_put;
> +		goto err_clk_disable;
>  	}
> 
>  	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> --
> 2.7.4

Thanks for the patch!

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Regards,
Amelie
