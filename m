From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: [PATCH] spi-imx: imx6q add single burst transfer support
Date: Thu, 2 Jun 2016 09:27:25 +0800
Message-ID: <574F8B7D.9010707@gtsys.com.hk>
References: <1464756628-25463-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20160601065437.GI31666@pengutronix.de> <574E8A19.3020603@gtsys.com.hk>
 <20160601143213.GA2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160601143213.GA2282-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, June 01, 2016 10:32 PM, Mark Brown wrote:
> On Wed, Jun 01, 2016 at 03:09:13PM +0800, Chris Ruehl wrote:
>> On Wednesday, June 01, 2016 02:54 PM, Sascha Hauer wrote:
>
>>>> The patch add support for single burst transfer where chipselect will
>>>> hold active until transfer completes with a limit to 2^7 words transferred.
>>>> The single-burst-mode need set the burstlength in ECSPI_CONREG.BURST_LENGTH
>>>> and clear the ecspi channel related ss_ctl flag in ECSPI_CONFIGREG.SS_CTL.
>
>>>> The single-burst-mode is disabled by default. The activation from spidev
>
>>> Erm, no. This is not acceptable in many ways. First of all the SPI API
>>> between the kernel and userspace is driver agnostic. There is simply no
>>> place for passing driver specific quirks from userspace to the spi-imx
>>> driver. Then there is no API change needed because the way SPI
>>> messages should be translated to the wire is well defined, the spi-imx
>>> driver is just doing it wrong in this case which might be worth fixing.
>>> This could be done without passing a "do it right" flag to the driver.
>
>> I expected AND except the "NO" on this!
>> But the userspace interface (xfer) does not have anything else then
>> tx,rx-buf cs_change delay.. to carry infos forward to the driver.
>
> That's absolutely fine.  The "new" behaviour which you are introducing
> is the standard behaviour, the fact that the driver currently does
> anything different is just a very bad bug in the driver.  Instead of
> introducing a new option to provide a driver specific "make it work"
> quirk that users must activate you should fix the driver to perform
> correctly as standard.
>

Mark,

thanks for that explanation. I did not feel in the position to overrule
the current behaviour of the driver.
So if you agree that the change I did is acceptable as standard I going
to update the patch in the way to do so.

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
