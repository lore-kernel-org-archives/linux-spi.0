From: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Thu, 09 Apr 2015 23:31:12 +0200
Message-ID: <5526EFA0.2010108@biot.com>
References: <1428285263-15135-1-git-send-email-bert@biot.com> <20150406163905.GL6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406163905.GL6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/06/2015 06:39 PM, Mark Brown wrote:> On Mon, Apr 06, 2015 at
03:54:23AM +0200, Bert Vermeulen wrote:
>> +		if (spi->chip_select == 1 && t->cs_change) {
>> +			/* CPLD in bulk write mode gets two bits per clock */
>> +			do_spi_byte_fast(rbspi, spi_ioc, out);
>> +			/* Don't want the real CS toggled */
>> +			t->cs_change = 0;
>> +		} else {
>> +			do_spi_byte(rbspi, spi_ioc, out);
>> +		}
> 
> This is making very little sense to me and the fact that the driver is
> messing with cs_change is definitely buggy, it'll mean that repeated use
> of the same transfer will be broken.  What is the above code supposed to
> do, both with regard to selecting "fast" mode (why would you want slow
> mode?) and with regard to the chip select?
> 
> I queried this on a previous version and asked for the code to be better
> documented...

I documented it in the commit message:

 The m25p80-compatible boot flash and (some models) MMC use regular SPI,
 bitbanged as required by the SoC. However the SPI-connected CPLD has
 a "fast write" mode, in which two bits are transferred by SPI clock
 cycle. The second bit is transmitted with the SoC's CS2 pin.

 Protocol drivers using this fast write facility signal this by setting
 the cs_change flag on transfers.

The cs_change flag is used here instead of the openwrt version's
spi_transfer.fast_write flag. The CPLD driver sets this flag on a
per-transfer basis.

I wish I could tell you more about it, but I only know what I found in this
code.

>> +	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
>> +	if (IS_ERR(ahb_clk))
>> +		return PTR_ERR(ahb_clk);
>> +
>> +	err = clk_prepare_enable(ahb_clk);
>> +	if (err)
>> +		return err;
> 
> There's no error handling (or indeed any other code) disabling the
> clock, probably this enable should happen later and those disables
> definitely need adding.  I'd also expect to see runtime PM to keep the
> clock disabled when the controller isn't in use in order to save power.

No problem disabling the clock on error/remove, but PM doesn't seem worth
doing in this case -- the ath79 platform's clock enable/disable are just
dummy functions. The ar7100 series SoCs have no power management, it seems.

I have a patch addressing all your other comments.


-- 
Bert Vermeulen        bert-Nh2F35Ii2RQ@public.gmane.org          email/xmpp
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
