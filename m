From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 4/4] spi: sprd: Add DMA mode support
Date: Wed, 16 Jan 2019 10:34:05 +0800
Message-ID: <CAMz4kuKOceVJ9vjq6Z3pZUXSg28RLXHhguJKSvyZPYFLYj_hWw@mail.gmail.com>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
 <20190115143042.GB5522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115143042.GB5522@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Tue, 15 Jan 2019 at 22:30, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 15, 2019 at 09:46:53PM +0800, Baolin Wang wrote:
> > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> >
> > Add DMA mode support for the Spreadtrum SPI controller, and we will enable
> > SPI interrupt to help to complete the SPI transfer work in DMA mode.
>
> Again this looks good, one thing to check though:
>
> > +static bool sprd_spi_can_dma(struct spi_controller *sctlr,
> > +                          struct spi_device *spi, struct spi_transfer *t)
> > +{
> > +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
> > +
> > +     return ss->dma.enable;
> > +}
>
> Is it always a benefit to use DMA?  One reason this is a function rather
> than just a property is that even if the device can DMA any size of
> transfer often for short transfers the performance is better if you use
> PIO since the overhead of setting up the DMA controller, waiting and
> then taking the interrupt when it finishes ends up being more than the
> cost of just reading and writing directly to the FIFOs for PIO.

Firstly we want to simplify the transfer, once we enable the DMA, we
always want to use DMA mode. But I think you are reasonable, we will
optimize the can_dma() ops for short transfers to improve the
performance. Thanks for your comments.

-- 
Baolin Wang
Best Regards
