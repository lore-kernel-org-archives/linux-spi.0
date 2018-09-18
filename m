From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO
 size
Date: Tue, 18 Sep 2018 16:41:54 +0200
Message-ID: <20180918164154.28d7a31c@bbrezillon>
References: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180709233427.1a714de7@bbrezillon>
        <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        prabhakar.kushwaha@nxp.com, linux-mtd@lists.infradead.org,
        han.xu@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        festevam@gmail.com
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 18 Sep 2018 12:51:51 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> I want to revive the discussion about this patch. Meanwhile we have 
> received confirmation from NXP, that the hardware can't handle writing 
> data chunks bigger than the TX buffer size, even when we use DMA to 
> refill the buffer [1].
> 
> This means, that this patch is required to get the FSL QSPI driver 
> working with the SPI mem framework.
> 
> Could you please reconsider this patch?

I'm all for taking this patch, just waiting for a green light from
Marek.
