From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] ARM: Add spi controller driver support for NUC900
Date: Thu, 19 Nov 2009 16:40:50 +0800
Message-ID: <e68bb3470911190040v2c14bbcfi46177cd58649e1c@mail.gmail.com>
References: <4B024748.9080001@gmail.com>
	 <20091118142109.ff2c5ef6.akpm@linux-foundation.org>
	 <e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
	 <20091118234928.8d86a9f9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <spi-devel-general@lists.sourceforge.net>,
	David Brownell-sourceforge <dbrownell@users.sourceforge.net>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754185AbZKSIkp@vger.kernel.org>
In-Reply-To: <20091118234928.8d86a9f9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/11/19 Andrew Morton <akpm@linux-foundation.org>:
> On Thu, 19 Nov 2009 14:23:49 +0800 Wan ZongShun <mcuos.com@gmail.com>=
 wrote:
>
>> >> +static int __devexit w90p910_spi_remove(struct platform_device *=
dev)
>> >> +{
>> >> + __ __ struct w90p910_spi *hw =3D platform_get_drvdata(dev);
>> >> +
>> >> + __ __ platform_set_drvdata(dev, NULL);
>> >> +
>> >> + __ __ spi_unregister_master(hw->master);
>> >> +
>> >> + __ __ clk_disable(hw->clk);
>> >> + __ __ clk_put(hw->clk);
>> >
>> > As far as I can tell, a hardware interrupt could still be pending,=
 or
>> > be under service while the above code is executing?
>> >
>> > If so, I expect bad things will happen?
>>
>> Do you mean that I should put this 'free_irq()' in the front of
>> w90p910_spi_remove___
>>
>> such as:
>> "
>> free_irq(hw->irq, hw);
>>
>> platform_set_drvdata(dev, NULL);
>>
>> spi_unregister_master(hw->master);
>>
>> clk_disable(hw->clk);
>> clk_put(hw->clk);
>
> I don't know, because I don't know what operation the hardware needs =
to
> stop it from generating interrupts. =C2=A0Perhaps that's clk_disable(=
)?

The interrupt will be not occur as long as I run clk_disable().

> Once you've stopped the source of interrupts then the code should wai=
t
> for the IRQ handler to complete if it's running on another CPU. =C2=A0=
Yes,
> free_irq() does that.

So, regarding my system of single CPU, maybe I need put this
'clk_disable()' in the front of function of w90p910_spi_remove().

right?

> It's only after the clk_disable() and the free_irq() that you can
> guarantee that no interrupt handler will run and attempt to access th=
e
> device and its associated data structures.
>
>



--=20
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
