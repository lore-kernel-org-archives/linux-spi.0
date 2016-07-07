From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: do not disable the clock while configuring
 the spi
Date: Thu, 07 Jul 2016 18:58:41 +0900
Message-ID: <20160707095840.GH23620@samsunx.samsung>
References: <CGME20160707072419epcas1p3ba881fb9b3270eb8cde87380aea7bcf9@epcas1p3.samsung.com>
 <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-disposition: inline
In-reply-to: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
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

>  	if (sdd->port_conf->clk_from_cmu) {
> -		/* Configure Clock */
> -		/* There is half-multiplier before the SPI */
>  		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);

sorry, I will re-send it because I should not remove the comments
above.... in the future someone might wonder why it's multiplied
by 2.

That's called auto review and auto-nack :)

Andi

> -		/* Enable Clock */
> -		clk_prepare_enable(sdd->src_clk);
>  	} else {
>  		/* Configure Clock */
>  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
> -- 
> 2.8.1
> 
