From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Wed, 10 Apr 2019 14:05:38 +0000
Message-ID: <6eeaf42f4d3f42c58546c429194213b8@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410125612.GR6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> On Wed, Apr 10, 2019 at 02:51:36PM +0200, Flavio Suligoi wrote:
> > With dw_dmac, sometimes the request of a DMA channel fails because
> > the DMA driver is not ready, so an explicit dependency request
> > is necessary.
> 
> While this isn't going to hurt anything and might actually help so it's
> fine doesn't this also suggest that there's an issue with deferred probe
> going on as well?

I think that the problem could be related to how the DMA channel is requested.
At the moment the function used are:

pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
--> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
--> dma_request_chan

Actually the final function "dma_request_chan" return
the channel number or "-EPROBE_DEFER" if it's not ready.
But this information ("-EPROBE_DEFER") is lost in the penultimate function 
"dma_request_slave_channel", which return only the chann, if all is ok, or
NULL, in case of errors.
So the deferral mechanism is not used.

Flavio
