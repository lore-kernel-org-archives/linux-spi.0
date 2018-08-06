From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] spi: orion: cosmetics - alias long direct_access
 variables
Date: Mon, 6 Aug 2018 21:09:12 +0200
Message-ID: <20180806190912.GJ9372@lunn.ch>
References: <20180806185158.2382-1-zertsekel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
To: Kosta Zertsekel <zertsekel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806185158.2382-1-zertsekel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>  
>  	/* Scan all SPI devices of this controller for direct mapped devices */
>  	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		struct orion_direct_acc *dacc;

I would prefer direct_access, but it looks like this is too long to
put the devm_ioremap on one line. But it should be enough to fix the
odd indentation of r->start and PAGE_SIZE.

    Andrew

>  		u32 cs;
>  
>  		/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
>  		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>  		 * support, once this gets implemented.
>  		 */
> -		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
> -							    r->start,
> -							    PAGE_SIZE);
> -		if (!spi->child[cs].direct_access.vaddr) {
> +		dacc = &spi->child[cs].direct_access;
> +		dacc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +		if (!dacc->vaddr) {
>  			status = -ENOMEM;
>  			goto out_rel_axi_clk;
>  		}
> -		spi->child[cs].direct_access.size = PAGE_SIZE;
> +		dacc->size = PAGE_SIZE;
>  
>  		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>  	}
> -- 
> 2.17.1
> 
