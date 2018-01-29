From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH 1/4] pinctrl: mcp23s08: IRQ behavior for open-drain =?iso-8859-1?Q?interrupts?=
Date: Mon, 29 Jan 2018 11:27:52 +0100
Message-ID: <77ac8e65-1742-4e0e-9f96-8445de92c6c6@cesnet.cz>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
 <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat@cesnet.cz>
 <621e8caf-3591-9748-dcdd-7ae8f7222e80@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Phil Reid <preid@electromag.com.au>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <621e8caf-3591-9748-dcdd-7ae8f7222e80@electromag.com.au>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> I submitted a patch for this in November, But haven't followed=20
> up on the last review as yet.
> See: https://patchwork.ozlabs.org/cover/839923/

Hi Phil, that looks nice. Sorry for duplicating your work. I would have=20
sworn I haven't seen your patch, but I *think* I actually read that IRQ=20
polarity discussion. Strange, perhaps I just forgot that it was about=20
MCP23xxx.

> I used exactly the same dt in my first propsal. But you'll see=20
> form the discussions that series
> This needs to be the standard 'drive-open-drain' flag

I wasn't aware of that one.

> The original code does the same thing.
> open drain is active-low.
> Sharing can also be achieved by AND / OR gates with push-pull drivers.
> So no need to treat that differently.

That's a good point. I agree that decoupling the irq-controller's=20
configuration from this chip's IRQ output lane configuration (and hence=20
moving the IRQ_SHARED etc to the DT) makes sense.

My change also writes to the MCP_IOCON unconditionally. For example, the=20
old code would fail if "something" configured the chip for irq-open-drain=20
before the kernel got a chance to run.

Will you have time to re-spin the series anytime soon? I can help if you'd=20=

like to.

Cheers,
Jan
