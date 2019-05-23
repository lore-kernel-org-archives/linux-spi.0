From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Date: Thu, 23 May 2019 11:04:33 +0530
Message-ID: <20190523053433.GU15118@vkoul-mobl>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
 <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 22-05-19, 10:00, Robin Gong wrote:
> Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
> check ignore such special case without dma channel enabled, which caused
> ecspi1 rx works failed. Actually, no need to check event_id0/event_id1
> and replace checking 'event_id1' with 'DMA_DEV_TO_DEV', so that configure
> event_id1 only in case DEV_TO_DEV.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
