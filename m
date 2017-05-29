From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] spi: add null check before pointer dereference
Date: Mon, 29 May 2017 12:59:25 +0900
Message-ID: <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
References: <CGME20170523002511epcas4p3b7737552432363b089e4a9018e43f6f5@epcas4p3.samsung.com>
        <20170523002507.GA16670@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20170523002507.GA16670@embeddedgus>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Gustavo,

>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>  				       dma->direction, DMA_PREP_INTERRUPT);
>  
> +	if (!desc) {
> +		dev_err(&sdd->master->dev,
> +			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
> +		return;
> +	}
> +

I'm sorry, I would nack this patch for now. There was a smilar I
sent before, but, as Krzysztof said, this needs more testing and
a proper solution.

That's anyway in my todo list.

Thanks,
Andi
