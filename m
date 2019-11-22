From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3] spi: pic32: Retire dma_request_slave_channel_compat()
Date: Fri, 22 Nov 2019 10:04:02 +0530
Message-ID: <20191122043402.GJ82508@vkoul-mobl>
References: <20191121092703.30465-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, geert@linux-m68k.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191121092703.30465-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21-11-19, 11:27, Peter Ujfalusi wrote:
> There is no reason to use the dma_request_slave_channel_compat() as no
> filter function and parameter is provided.
> 
> Switch the driver to use dma_request_chan() instead and add support for
> deferred probing against DMA channel.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
