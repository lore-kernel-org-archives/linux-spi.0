From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Wed, 1 Jun 2016 09:54:39 +0800
Message-ID: <574E405F.9090000@gtsys.com.hk>
References: <574D5C2B.1000400@gtsys.com.hk>
 <CAOMZO5CiW3J+naHfitjv59i4xisYB1R3ATs2qvz4mLh_FMyf+g@mail.gmail.com>
 <20160531110608.GG31666@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160531110608.GG31666-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, May 31, 2016 07:06 PM, Sascha Hauer wrote:
> On Tue, May 31, 2016 at 07:43:37AM -0300, Fabio Estevam wrote:
>> [Adding Sascha and Anton in Cc]
>>
>> On Tue, May 31, 2016 at 6:40 AM, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org> wrote:
>>> Hi,
>>>
>>> as imx6 using multiple burst to send data to spi slaves and drop the
>>> chipselect between the words by default my sensor NXP MPL115A1 wasn't
>>> working.
>
> I generally recommend to use GPIO Chip selects. The SPI controller has
> its own ideas when to assert the chipselects which is hard to match (if
> possible at all) with what Linux SPI expects. See the cs-gpios device
> tree property.
>
> Sascha

Sascha that's a good approach to fight this problem, if you have the
choice. Sadly my hardware design is finished and I can only switch to
a gpio by run wires on the finished PCB.. and that's not what I want.

With the single burst mode patch, the logic analyser shows a very nice and
and clean and accurate chipselect clock MOSI and MISO.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
