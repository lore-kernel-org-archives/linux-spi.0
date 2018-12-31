From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to
 register as a clk provider
Date: Mon, 31 Dec 2018 23:56:40 +0100
Message-ID: <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
 <20181231175034.GI1846@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ben Whitten <ben.whitten@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181231175034.GI1846@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 31.12.18 um 18:50 schrieb Mark Brown:
> On Sun, Dec 30, 2018 at 11:55:46AM +0100, Andreas Färber wrote:
>> Given that observed symptoms were CPU stalls, workqueue hangs and RCU
>> problems, requiring a power-cycle to recover, I wonder whether we are
>> running into some atomic/locking issue with clk_enable()? Is it valid at
>> all to use SPI/regmap for clk_enable()? If it is, is there a known issue
>> specific to spi-sun6i (A64) in 4.20.0?
>> I already tried setting .disable_locking = true in both regmap_configs.
>> Any suggestions how to further debug?
> 
> You can't use SPI for clk_enable(), clk_enable() needs to be doable in
> atomic context since we need to wait for the bus operations to complete
> (you can start SPI transfers in atomic context but you still need to
> wait for them to complete).  Any clocks that are only accessible via a
> slow bus like I2C or SPI need to do the enable/disable in the
> prepare/unprepare operations which aren't done in atomic context.
> 
> regmap can be used in atomic contexts, though you need to configure it
> to use spinlocks instead of mutexes and ensure that no register cache
> allocations happen during I/O (eg, by providing defaults for all
> registers or by not using a cache).

We have .cache_type = REGCACHE_NONE on both bus and spi regmap_configs.

I moved the regmap_field_write() from .enable to .prepare and set
.fast_io = true on both regmap_configs to force using spinlocks, but
same hang as in .enable before...

And same if I set .disable_locking = true on both.

Given that it works with one SPI driver and not with the other,
independent of the locking options applied, I assume my symptoms are not
a regmap-layer issue.

Is it allowed during a .prepare operation to call the mentioned
clk_get_rate(), which ends up calling clk_prepare_lock()?

According to my debug output in spi-sun6i.c our hanging
regmap_field_write() ends up calling sun6i_transfer_one() three times,
the first two look okay, but the third one doesn't make it past the
clk_get_rate() or following if block. [But for now some fireworks...]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
