From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 1/1] spi: bcm2835: no dev_err() on clk_get()
 -EPROBE_DEFER
Date: Mon, 16 Dec 2019 15:11:18 -0800
Message-ID: <98362740-2ce9-41f2-a053-80ade1e72a1b@gmail.com>
References: <20191216230802.45715-1-jquinlan@broadcom.com>
 <20191216230802.45715-2-jquinlan@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216230802.45715-2-jquinlan@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/16/19 3:08 PM, Jim Quinlan wrote:
> Use dev_dbg() on -EPROBE_DEFER and dev_err() on all
> other errors.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/spi/spi-bcm2835.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index fb61a620effc..e4b57b751ce2 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1305,7 +1305,10 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
>  	bs->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(bs->clk)) {
>  		err = PTR_ERR(bs->clk);
> -		dev_err(&pdev->dev, "could not get clk: %d\n", err);
> +		if (err == -EPROBE_DEFER)
> +			dev_dbg(&pdev->dev, "could not get clk: %d\n", err);
> +		else
> +			dev_err(&pdev->dev, "could not get clk: %d\n", err);
>  		goto out_controller_put;
>  	}
>  
> 


-- 
Florian
