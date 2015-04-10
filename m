From: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Fri, 10 Apr 2015 17:31:15 +0200
Message-ID: <5527ECC3.1000209@biot.com>
References: <1428285263-15135-1-git-send-email-bert@biot.com> <20150406163905.GL6023@sirena.org.uk> <5526EFA0.2010108@biot.com> <20150409215047.GE6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150409215047.GE6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/09/2015 11:50 PM, Mark Brown wrote:
> On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:
>>  The m25p80-compatible boot flash and (some models) MMC use regular SPI,
>>  bitbanged as required by the SoC. However the SPI-connected CPLD has
>>  a "fast write" mode, in which two bits are transferred by SPI clock
>>  cycle. The second bit is transmitted with the SoC's CS2 pin.
> 
>>  Protocol drivers using this fast write facility signal this by setting
>>  the cs_change flag on transfers.
> 
>> The cs_change flag is used here instead of the openwrt version's
>> spi_transfer.fast_write flag. The CPLD driver sets this flag on a
>> per-transfer basis.
> 
> No, this is broken - it's abusing a standard API in a way that's
> completly incompatible with the meaning of that API which is obviously a
> very bad idea, especially since good practice is to offload the
> implementation of that standard API to the core.  It *sounds* like
> you're just trying to implement two wire mode which does have a standard
> API, please use that.

Can you please advise what kind of solution would be acceptable then? I need
to signal from an SPI protocol driver to an SPI master on a per-transfer basis.

Adding a flag to struct spi_transfer for this one driver, as openwrt does,
seems stupid -- I agree. And sure, using spi_transfer.cs_change is a little
dodgy. But I don't see a standard way to do it otherwise, and I don't really
want to keep trying things until you approve of one. So tell me how you
would do it, and I'll implement it that way. I just want to get this code in.

Also, I have no idea what you mean by two-wire mode. This "fast mode" is SPI
+ one extra pin.


-- 
Bert Vermeulen        bert-Nh2F35Ii2RQ@public.gmane.org          email/xmpp
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
