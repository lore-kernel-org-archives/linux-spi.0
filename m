From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: resend: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Tue, 14 Sep 2010 16:45:57 +0200
Message-ID: <AANLkTim4a7eha6Z3pjrZ0kg9VNRcuH52Qs2h4XydsXi4@mail.gmail.com>
References: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk@mail.gmail.com>
	<083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Wells <wellsk40@gmail.com>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>,
	"rabin.vincent@stericsson.com" <rabin.vincent@stericsson.com>,
	"srinidhi.kasagar@stericsson.com" <srinidhi.kasagar@stericsson.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"tj@kernel.org" <tj@kernel.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"Lukasz.Baj@tieto.com" <Lukasz.Baj@tieto.com>
To: Kevin Wells <kevin.wells@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/9/13 Kevin Wells <kevin.wells@nxp.com>:

> SSP_CR0_MASK_SPH (SPHA) should use bit 7, not bit 6.
> Should be:
> =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 7);
>
>> +
>> =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SS=
P_CR0_MASK_SCR,
>> 8);
>> =A0 =A0 =A0 =A0/* Loopback is available on all versions except PL023=
 */

That's it!

With this correction it starts working, so
Acked-by/Tested-by/Reviewed-by: Linus Walleij <linus.walleij@stericsson=
=2Ecom>

Please submit the whole patch series with corrections and my tag
so Grant can pick it up, and thanks for doing this because I think
it is a great improvement to the driver!

Yours,
Linus Walleij
