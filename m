From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
Date: Thu, 4 Sep 2014 19:32:31 +0200
Message-ID: <CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
	<1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
	<CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
	<20140904170630.GL29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anders Berg <anders.berg@avagotech.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140904170630.GL29327@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 4, 2014 at 7:06 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 04, 2014 at 07:04:44PM +0200, Linus Walleij wrote:
>> I need an ACK from Mark Brown on this before I apply.
>> The driver seems to do what it should, but I need Mark to
>> be OK with exporting the CS signals from an SSP/SPI block
>> to be exposed to Linux as GPIOs.
>>
>> (Top-posting and quoting patch verbatim so Mark gets it.)
>
> I don't see any sort of reasoning for this?

Maybe there was some earlier, but this is an excellent opportunity
to repeat it... So Anders: why do you want to do this?

Yours,
Linus Walleij
