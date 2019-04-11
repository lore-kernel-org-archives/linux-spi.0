From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Thu, 11 Apr 2019 07:14:06 +0000
Message-ID: <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
 <20190410152820.GT6106@sirena.org.uk>
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
In-Reply-To: <20190410152820.GT6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> > I think that the problem could be related to how the DMA channel is
> requested.
> > At the moment the function used are:
> 
> > pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
> > --> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
> > --> dma_request_chan
> 
> > Actually the final function "dma_request_chan" return
> > the channel number or "-EPROBE_DEFER" if it's not ready.
> > But this information ("-EPROBE_DEFER") is lost in the penultimate
> function
> > "dma_request_slave_channel", which return only the chann, if all is ok,
> or
> > NULL, in case of errors.
> > So the deferral mechanism is not used.
> 
> Right, yes - that analysis seems correct.  The interfaces seem a bit
> weird here but fixing them looks like the most complete and robust fix.

Ok Mark, I'll fix this problem as soon as I can, using EPROBE_DEFER.
For now, in my application, I use the patch that I already sent,
with the "softdep" workaround:

MODULE_SOFTDEP("pre: dw_dmac");

I tested it a lot, with more than 2000 cold reboot (automatic
switch on/off using a controlled power supply) and it always worked good.

Thanks for your help!

Flavio
