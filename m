From: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Sun, 22 Mar 2015 12:25:24 +0100
Message-ID: <550EA6A4.6010206@biot.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com> <1426853793-24454-2-git-send-email-bert@biot.com> <20150320125139.GJ2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150320125139.GJ2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/20/2015 01:51 PM, Mark Brown wrote:

Mark,

Thanks very much for your detailed review. I'll fix things according to your
comments. However...

> On Fri, Mar 20, 2015 at 01:16:32PM +0100, Bert Vermeulen wrote:
>> +static void do_spi_byte(void __iomem *base, unsigned char byte)
>> +{
>> +	do_spi_clk(base, byte >> 7);
>> +	do_spi_clk(base, byte >> 6);
>> +	do_spi_clk(base, byte >> 5);
>> +	do_spi_clk(base, byte >> 4);
>> +	do_spi_clk(base, byte >> 3);
>> +	do_spi_clk(base, byte >> 2);
>> +	do_spi_clk(base, byte >> 1);
>> +	do_spi_clk(base, byte);
> 
> This looks awfully like it's bitbanging the value out, can we not use
> spi-bitbang here?
> 

[...]

>> +static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1,
>> +				   unsigned bit2)
> 
> Why would we ever want the slow version?

It is bitbanging, at least on write. The hardware has a shift register that
is uses for reads. The generic spi for this board's architecture (ath79)
indeed uses spi-bitbang.

This "fast SPI" thing is what makes this one different: the boot flash and
MMC use regular SPI on the same bus as the CPLD. This CPLD needs this fast
SPI: a mode where it shifts in two bits per clock. The second bit is
apparently sent via the CS2 pin.

So I don't think spi-bitbang will do. I need to see about reworking things
to use less custom queueing -- I'm not that familiar with this yet.


-- 
Bert Vermeulen        bert-Nh2F35Ii2RQ@public.gmane.org          email/xmpp
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
