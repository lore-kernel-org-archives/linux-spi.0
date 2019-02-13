From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 3/3] spi: sprd: spi: sprd: Add DMA mode support
Date: Wed, 13 Feb 2019 20:35:06 +0800
Message-ID: <CAMz4kuJL2OTkeik5gR1NnxzSAxY6QcQp9wRTcft-DX8oknY+eg@mail.gmail.com>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
 <20190213122012.GE7540@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213122012.GE7540@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 13 Feb 2019 at 20:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 03:36:11PM +0800, Baolin Wang wrote:
>
> > +enum sprd_spi_dma_channel {
> > +     SPI_RX,
> > +     SPI_TX,
> > +     SPI_MAX,
> > +};
>
> It'd have been better to namespace these (SPRD_SPI_ or something) in
> case of conflicts.  That's really minor though and everything else looks
> good so I'll go ahead and apply, thanks!

Yes, I'll send one incremental patch ASAP. Thanks for your reviewing.

-- 
Baolin Wang
Best Regards
