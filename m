From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Date: Fri, 20 Sep 2019 17:27:49 +0200
Message-ID: <87a7az7zt6.fsf@FE-laptop>
References: <20190919153847.7179-1-gregory.clement@bootlin.com> <20190919160315.GQ3642@sirena.co.uk> <20190919172350.GZ21254@piout.net> <20190920105101.GA3822@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190920105101.GA3822@sirena.co.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Mark,

> On Thu, Sep 19, 2019 at 07:23:50PM +0200, Alexandre Belloni wrote:
>> On 19/09/2019 17:03:15+0100, Mark Brown wrote:
>
>> > This is going to break any system where we use both a GPIO chip select
>> > and chip select 0.  Ideally we'd try to figure out an unused chip select
>> > to use here...
>
>> The point is that this use case is already broken and this patch fixes
>> the crash and is easily backportable.
>
>> Fixing the CS + gpio CS should probably be done in a separate patch.
>
> If the GPIO is overlaid on any of the existing slots (except GPIO 0)
> then it'll cause GPIO 0 to start toggling.  I'm not convinced that the
> code doesn't currently support that.

Actually, the current code is not designed to mix CS and gpio CS, so
this patch doesn't introduce any regression on this side.

But after going further in the details of the driver, this patch could
cause a regression for on the old controllers.

I also found other issues in this driver in the chip select
management. So I will send a new series fixing all of it.

Gregory


-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
