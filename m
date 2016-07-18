From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 2/7] bindings: spi-samsung: document the clocks and the
 clock-name property
Date: Mon, 18 Jul 2016 12:30:07 +0200
Message-ID: <578CAFAF.9060704@samsung.com>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-3-git-send-email-andi.shyti@samsung.com>
 <20160716203044.GA13087@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Rob Herring <robh@kernel.org>, Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <20160716203044.GA13087@rob-hp-laptop>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/16/2016 10:30 PM, Rob Herring wrote:
>> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt 
>> b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> > index 57d5539..f45c6eb 100644
>> > --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> > +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> > @@ -24,6 +24,15 @@ Required SoC Specific Properties:
>> >  - dma-names: Names for the dma channels. There must be at least one channel
>> >    named "tx" for transmit and named "rx" for receive.
>> >  
>> > +- clocks: specifies the clock IDs provided to the SPI controller; they are
>> > +  required for interacting with the controller itself, for synchronizing the bus
>> > +  and as I/O clock (the latter is required by exynos5433 and exynos7).
>> > +
>> > +- clock-names: string names of the clocks in the 'clocks' property; for all the
>> > +  the devices the names must be "spi", "spi_busclkN" (where N is determined by
>> > +  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
>
> This sounds like you are describing the configuration of the clocks, not 
> the connections. The binding here should list clocks for all possible 
> vaules of N as those are all the input clocks to the block.
> 
>> > +  "spi_ioclk" for the I/O clock.

I agree we should list all possible spi_busclkN, I must admit  I might
have introduced some confusion by suggesting wording for clock-names 
similar to the above while discussing those things internally.  Afterwards 
I came to a similar conclusion all possible input clocks should be listed
These will differ depending  on the compatible.  I checked in documentation 
of most of related SoCs and for "samsung,s3c6410-spi" or older compatibles 
possible N is 0..2 (PCLK, USBCLK, PLL clock), for "samsung,s5pv210-spi" 
and newer possible N is 0 (SCLK_SPI).  

It's important to have all the input clocks listed so we have a list 
of parent clocks to the SPI controller's internal clocks, should we 
ever decide to model them with the clk API.

--
Thanks, 
Sylwester
