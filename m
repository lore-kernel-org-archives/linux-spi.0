From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [spi-devel-general] SPI-ADC
Date: Sat, 13 Feb 2010 22:20:06 +0100
Message-ID: <63386a3d1002131320u5afbc35ak2bc3533aab3f1e54@mail.gmail.com>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
	 <63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
	 <4B76D8AE.7040102@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: arjun rath <rath.arjun@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux kernel <linux-kernel@vger.kernel.org>
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B76D8AE.7040102@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/2/13 Jonathan Cameron <kernel@jic23.retrosnub.co.uk>:

>>> can anybody share how to start a spi based ADC linux driver.I am ha=
ving a
>>> MAXIM 1242 ADC chip.
>>
>> The =E1=B8=B1ernel does not contain any generic ADC subsystem abstra=
ction
>> (...)
>
> That's not entirely true. =C2=A0These are covered by the IIO subsyste=
m which
> is admittedly currently in staging as some elements still need cleani=
ng up.
> (...)
> ADC drivers are under drivers/staging/iio/adc.

Great stuff. I knew about IIO and then it fell out of my mind, how
could I...

What strikes me especially about IIO is the underlying assumption, whic=
h I
think ought to be written in clear somewhere where I missed it, and tha=
t
is that all IIO drivers are supposed to deliver values and be controlle=
r from
userspace with this nice ABI, and nothing's wrong with that of course.

But I'm hinting about a few in-kernel uses: for AB3100 we have a batter=
y
charging mechanism, which use a (calibrated) ADC value supporting the
bulk of the driver in the power/ subsystem.

As it looks today IIO is not intended for the case where another subsys=
tem
needs to grab and use and ADC for its own purposes. Is this correct or =
did
I get it all wrong?

Would you say it'd be a good idea to hack the IIO ADC interface (for
example) to be used also internally in the kernel, or would that violat=
e
the idea behind IIO?

If these are disparate categories it would warrant a separate adc/
subsystem, see.

> Currently all discussions take place on LKML, but we are working on a=
 more
> focused alternative list which I'll announce once it is sorted out.

LKML is just fine with me, for one.

Yours,
Linus Walleij
