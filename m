From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Date: Wed, 3 Jul 2019 12:43:38 +0200
Message-ID: <20190703104338.m5vfkbyq4fhqmjh4@wunner.de>
References: <20190628123023.4696-1-nuno.sa@analog.com>
 <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
 <20190628190022.vya4h2lihm6x2xpb@wunner.de>
 <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
 <20190701115506.42rr4o4hbuvwytjc@wunner.de>
 <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "wahrenst@gmx.net" <wahrenst@gmx.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-rpi-kernel@lists.infradead.org"
        <linux-rpi-kernel@lists.infradead.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: "Sa, Nuno" <Nuno.Sa@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 01, 2019 at 02:21:21PM +0000, Sa, Nuno wrote:
> On Mon, 2019-07-01 at 13:55 +0200, Lukas Wunner wrote:
> > I see.  In that case, try:
> > 
> >  	/* handle all the 3-wire mode */
> > -	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
> > +	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf != ctlr->dummy_rx))
> >  		cs |= BCM2835_SPI_CS_REN;
> >  	else
> >  		cs &= ~BCM2835_SPI_CS_REN;
> 
> This worked fine. Also, I did a quick backport of the state of your
> driver's (both spi-bcm2835 and bcm2835-dma) in revpi_staging and it
> also worked fine with my device.
> So, as far as I understand, the above suggestion (or my patch) is not
> intended to be upstreamed, right? It is just a temporary fix that I can
> use while your patchset gets upstream.

Thanks for testing.  I've just submitted the above as a fix for 5.3.
(Actually with a small change, the check for (tfr->rx_buf) needs to
be preserved in case DMA is disabled.)

The patch can be backported to 5.2 and older stable kernels if "ctlr"
is replaced by "master", we can inform Greg about that once the patch
lands in Linus' tree.  And I've amended my patch set to revert this
patch when dropping MUST_RX.

Thanks,

Lukas
