From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: mcp23s08: IRQ behavior for open-drain
 interrupts
Date: Tue, 30 Jan 2018 10:24:15 +0800
Message-ID: <f32083de-bf9b-5db3-61b5-bd7d1369f008@electromag.com.au>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
 <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat@cesnet.cz>
 <621e8caf-3591-9748-dcdd-7ae8f7222e80@electromag.com.au>
 <77ac8e65-1742-4e0e-9f96-8445de92c6c6@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
To: =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <77ac8e65-1742-4e0e-9f96-8445de92c6c6-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Content-Language: en-AU
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29/01/2018 18:27, Jan Kundrát wrote:
>> I submitted a patch for this in November, But haven't followed up on the last review as yet.
>> See: https://patchwork.ozlabs.org/cover/839923/
> 
> Hi Phil, that looks nice. Sorry for duplicating your work. I would have sworn I haven't seen your patch, but I *think* I actually read that IRQ polarity 
> discussion. Strange, perhaps I just forgot that it was about MCP23xxx.
> 
>> I used exactly the same dt in my first propsal. But you'll see form the discussions that series
>> This needs to be the standard 'drive-open-drain' flag
> 
> I wasn't aware of that one.
> 
>> The original code does the same thing.
>> open drain is active-low.
>> Sharing can also be achieved by AND / OR gates with push-pull drivers.
>> So no need to treat that differently.
> 
> That's a good point. I agree that decoupling the irq-controller's configuration from this chip's IRQ output lane configuration (and hence moving the IRQ_SHARED 
> etc to the DT) makes sense.
> 
> My change also writes to the MCP_IOCON unconditionally. For example, the old code would fail if "something" configured the chip for irq-open-drain before the 
> kernel got a chance to run.
Yeah I don't like that conditional logic for setting the config.
Tricky to change without potentially breaking something as you say.
But if you don't want mirror set and something is setting it before hand then things are broken.


> 
> Will you have time to re-spin the series anytime soon? I can help if you'd like to.
> 

I'll try and respin the open drain bit in the next week or so.
The other part of my series is a little more work I think.

Gives me some motivation to have a look at it.


-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
