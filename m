From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA mode
Date: Wed, 16 Jan 2019 10:21:42 +0800
Message-ID: <CAMz4ku+nky4YSFjjQ5BGJRCFQHCnXysh+_C7FmFF5YpdpDbZuA@mail.gmail.com>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
 <20190115142452.GA5522@sirena.org.uk>
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
In-Reply-To: <20190115142452.GA5522@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Tue, 15 Jan 2019 at 22:25, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 15, 2019 at 09:46:51PM +0800, Baolin Wang wrote:
>
> This looks good, just one small issue and a thing to check:
>
> > +static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
> > +{
> > +     struct sprd_spi *ss = (struct sprd_spi *)data;
> > +     u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
> > +
> > +     if (val & SPRD_SPI_MASK_TX_END) {
> > +             writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> > +             if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
> > +                     complete(&ss->xfer_completion);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     if (val & SPRD_SPI_MASK_RX_END) {
> > +             writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> > +             complete(&ss->xfer_completion);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
>
> This will return IRQ_HANDLED no matter if there was an interrupt
> actually handled.  That means that if something goes wrong due to some
> bug or a hardware change (eg, a new version of the IP) and there's
> another interrupt fired we won't clear it and the interrupt core won't
> be able to detect that it's a spurious interrupt and use its own error
> handling.  It's better to return IRQ_NONE in that case.

Yes, you are correct and will fix in next version.

> > +     ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
> > +                             0, pdev->name, ss);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
> > +                     ss->irq, ret);
>
> Are you sure it's safe to use devm_request_irq(), especially when
> unloading the driver?  Using it means that we will only disable the
> interrupt after the driver's remove function has finished so there's a
> danger of an interrupt firing when some of the resources the hander has
> used are still in use.  I didn't spot any issues, just something to
> check especially with the later patches building on top of this.

Yes, we missed this issue, thanks for pointing out this. After some
discussion with Lanqing, we think we need call the
spi_controller_suspend() manually in remove function to avoid this
issue.

Thanks for your comments.

-- 
Baolin Wang
Best Regards
