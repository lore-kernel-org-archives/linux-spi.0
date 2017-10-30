From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 3/3] spi: spi-axi: take extra controller reference before
 deregistration
Date: Mon, 30 Oct 2017 10:57:26 +0100
Message-ID: <20171030095726.GA7223@localhost>
References: <20171029115625.32385-1-johan@kernel.org>
 <20171029115625.32385-3-johan@kernel.org>
 <2a83c1f1-9203-eb97-5595-7a8da7261128@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a83c1f1-9203-eb97-5595-7a8da7261128@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 30, 2017 at 10:48:23AM +0100, Lars-Peter Clausen wrote:
> On 10/29/2017 12:56 PM, Johan Hovold wrote:
> > Take an extra reference to the controller to avoid use-after-free in
> > free_irq() which is called only after the controller has been
> > deregistered and freed.
> > 
> > Note that this is not an issue for this particular driver which does not
> > use shared interrupts, but free_irq() could otherwise end up accessing
> > the freed controller when CONFIG_DEBUG_SHIRQ is set.
> 
> Strictly speaking there is no guarantee that the IRQ handler does not run
> until free_irq() has been called. And since the SPI master is referenced in
> the IRQ handler there could be an use-after-free condition. So there is kind
> of a real issue here as well. But it should be really really hard to trigger
> it unless the hardware misbehaves.

You're right of course. Let me update the commit message in a v2 of the
series.

> > Defer controller release until free_irq() returns to prevent this
> > from ever becoming an issue should this code be replicated in other
> > drivers.
> > 
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks,
Johan
