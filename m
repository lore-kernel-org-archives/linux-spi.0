From: luhua xu <luhua.xu@mediatek.com>
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date: Thu, 24 Oct 2019 14:25:19 +0800
Message-ID: <1571898319.4311.3.camel@mbjsdccf07>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
         <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
         <20191023151121.GC5723@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023151121.GC5723@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2019-10-23 at 16:11 +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 08:38:42AM -0400, Luhua Xu wrote:
> > From: "luhua.xu" <luhua.xu@mediatek.com>
> 
> > Use runtime PM to power spi when set_cs
> > As set_cs may be called from interrupt context,
> > set runtime PM IRQ safe for spi.
> 
> Why might we be trying to set the chip select state while the device is
> runtime idle?  It seems like whatever is trying to set the chip select
> should be dealing with this, not the chip select operation itself since
> that's unlikely to be happening in isolation.

Hi Mark,
Spi framework provideds  spi_setup() to modify spi settings for spi
device (maybe spi is runtime idle now), and this will call
spi_controller->set_cs() accessing registers.
Other spi_controller callbacks that need to access hardware registers,
are triggered by spi transfer. Spi framework will get and put runtime
power in __spi_pump_message().
