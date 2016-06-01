From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: [PATCH] spi-imx: imx6q add single burst transfer support
Date: Wed, 1 Jun 2016 15:09:13 +0800
Message-ID: <574E8A19.3020603@gtsys.com.hk>
References: <1464756628-25463-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20160601065437.GI31666@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160601065437.GI31666-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, June 01, 2016 02:54 PM, Sascha Hauer wrote:
> On Wed, Jun 01, 2016 at 12:50:28PM +0800, Chris Ruehl wrote:
>> The patch add support for single burst transfer where chipselect will
>> hold active until transfer completes with a limit to 2^7 words transferred.
>> The single-burst-mode need set the burstlength in ECSPI_CONREG.BURST_LENGTH
>> and clear the ecspi channel related ss_ctl flag in ECSPI_CONFIGREG.SS_CTL.
>>
>> The single-burst-mode is disabled by default. The activation from spidev
>> is implemented by set bit0 of the xfer.speed_hz, which don't break anything
>> in the mx51_ecspi_clkdiv() function.
>>
>> xfer[0].speed_hz = 2000000 | 0x1; /* enable single burst mode with 1hz */
>
> Erm, no. This is not acceptable in many ways. First of all the SPI API
> between the kernel and userspace is driver agnostic. There is simply no
> place for passing driver specific quirks from userspace to the spi-imx
> driver. Then there is no API change needed because the way SPI
> messages should be translated to the wire is well defined, the spi-imx
> driver is just doing it wrong in this case which might be worth fixing.
> This could be done without passing a "do it right" flag to the driver.

I expected AND except the "NO" on this!
But the userspace interface (xfer) does not have anything else then tx,rx-buf 
cs_change delay.. to carry infos forward to the driver.

On the other hand it's useful to have the 'native cs working' to give the
hardware manufactures a hand to fixup their stuff! And play with the
chips features. Lot of things going wrong with hardware cs, and its good
to have a fallback to GPIO chip selects when the native chip fails.

My opinion, support both ways and don't give the chip guys an excuse to
give us rubbish.

>
> As noted in my response to the previous patch, I don't think we need a
> fix for this at all, because we can always use GPIO chip selects which
> works reliably not only in this case, but also in other cases where the
> controller driven chipselect falls apart.
>
> IMO there is only a single reason to keep controller driven chip select
> support at all: On i.MX31 there is one dedicated chip select which can't
> be configured as GPIO.
>
> Sascha
>

Thank you, its worth have your opinion on this.

Chris


-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: http://www.gtsys.com.hk/email/classified.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
