From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when
 it's not ours
Date: Fri, 23 Aug 2019 13:30:27 +0300
Message-ID: <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
References: <20190822211514.19288-1-olteanv@gmail.com> <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190823102816.GN23391@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 23 Aug 2019 at 13:28, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 23, 2019 at 12:15:11AM +0300, Vladimir Oltean wrote:
> > The DSPI interrupt can be shared between two controllers at least on the
> > LX2160A. In that case, the driver for one controller might misbehave and
> > consume the other's interrupt. Fix this by actually checking if any of
> > the bits in the status register have been asserted.
>
> It would be better to have done this as the first patch before
> the restructuring, that way we could send this as a fix - the
> refactoring while good doesn't really fit with stable.

Did you see this?
https://lkml.org/lkml/2019/8/22/1542

Regards,
-Vladimir
