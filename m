From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Date: Thu, 14 Nov 2019 11:12:30 +0200
Message-ID: <20191114091230.GB1249@jack.zhora.eu>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
 <20191113234049.GA1249@jack.zhora.eu>
 <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jonathanh@nvidia.com, alexandre.belloni@bootlin.com, s.hauer@pengutronix.de,
 linux-arm-msm@vger.kernel.org, radu_nicolae.pirea@upb.ro, broonie@kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, linux-spi@vger.kernel.org,
 vkoul@kernel.org, kgene@kernel.org, ldewangan@nvidia.com, agross@kernel.org,
 Andi Shyti <andi@etezian.org>, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
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

Hi Peter,

> >>  	if (!is_polling(sdd)) {
> >>  		/* Acquire DMA channels */
> >> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
> >> -								  "rx");
> >> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
> > 
> > I have a little concern here. We have two funcions
> > 'dma_request_chan' and  'dma_request_channel' don't we end up
> > making some confusion here?
> > 
> > Wouldn't it make more sense renaming 'dma_request_chan' to
> > 'dma_request_slave_channel_reason'?
> 
> The dma_request_channel() should go away. It was the old API before we
> got the dma_slave_map for non DT (and non ACPI) platforms so we can get
> rid of the filter function exports from DMA drivers to clients all over
> the place.

Yes, I agree... thanks!

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
