From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] ARM: Add spi controller driver support for NUC900
Date: Thu, 19 Nov 2009 17:49:22 +0800
Message-ID: <e68bb3470911190149k3bc77ef6h26475bc7272784b8@mail.gmail.com>
References: <4B024748.9080001@gmail.com>
	 <20091118142109.ff2c5ef6.akpm@linux-foundation.org>
	 <e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
	 <20091118234928.8d86a9f9.akpm@linux-foundation.org>
	 <e68bb3470911190040v2c14bbcfi46177cd58649e1c@mail.gmail.com>
	 <20091119090204.GB13376@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-spi <spi-devel-general@lists.sourceforge.net>,
	David Brownell-sourceforge <dbrownell@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754755AbZKSJtS@vger.kernel.org>
In-Reply-To: <20091119090204.GB13376@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Nov 19, 2009 at 04:40:50PM +0800, Wan ZongShun wrote:
>> 2009/11/19 Andrew Morton <akpm@linux-foundation.org>:
>> > I don't know, because I don't know what operation the hardware nee=
ds to
>> > stop it from generating interrupts. =C2=A0Perhaps that's clk_disab=
le()?
>>
>> The interrupt will be not occur as long as I run clk_disable().
>>
>> > Once you've stopped the source of interrupts then the code should =
wait
>> > for the IRQ handler to complete if it's running on another CPU. =C2=
=A0Yes,
>> > free_irq() does that.
>>
>> So, regarding my system of single CPU, maybe I need put this
>> 'clk_disable()' in the front of function of w90p910_spi_remove().
>>
>> right?
>
> Depending on the hardware, that's not the right answer. =C2=A0If turn=
ing off
> the clock also causes register accesses to the device to abort, it is
> a very dangerous thing to do.
>
> It can also be dangerous if the clock is used to synchronise the inte=
rrupt
> output - it can lead to the output being permanently asserted if the =
clock
> is turned off with it asserted.
>
> Normally devices have an "interrupt enable" register. =C2=A0You shoul=
d disable
> all interrupts from the device using this register after unregisterin=
g
> the driver from the (SPI) subsystem.

sir, so I need implement a API to disable spi device interrupt by
"interrupt enable" register?
but I did not find the operation in other ARM platform when they close
your spi driver.

or something I missed?

>



--=20
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
