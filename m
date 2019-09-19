From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Date: Thu, 19 Sep 2019 19:23:50 +0200
Message-ID: <20190919172350.GZ21254@piout.net>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
 <20190919160315.GQ3642@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919160315.GQ3642@sirena.co.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 19/09/2019 17:03:15+0100, Mark Brown wrote:
> On Thu, Sep 19, 2019 at 05:38:47PM +0200, Gregory CLEMENT wrote:
> 
> > With this patch, when using a gpio CS, the hardware CS0 is always
> > used. Thanks to this, there is no more limitation for the number of
> > gpio CS we can use.
> 
> This is going to break any system where we use both a GPIO chip select
> and chip select 0.  Ideally we'd try to figure out an unused chip select
> to use here...

The point is that this use case is already broken and this patch fixes
the crash and is easily backportable.

Fixing the CS + gpio CS should probably be done in a separate patch.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
