From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [spi-devel-general] SPI-ADC
Date: Sat, 13 Feb 2010 14:48:22 +0100
Message-ID: <63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux kernel <linux-kernel@vger.kernel.org>
To: arjun rath <rath.arjun@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/2/13 arjun rath <rath.arjun@gmail.com>:

> can anybody share how to start a spi based ADC linux driver.I am havi=
ng a
> MAXIM 1242 ADC chip.

The =E1=B8=B1ernel does not contain any generic ADC subsystem abstracti=
on (I
think it would be good if it did), instead most drivers using ADC have
their ADC portions stored inside a driver for something else, e.g.
drivers/hwmon for ADCs used in temperature monitoring, or
drivers/power for ADCs used in monitoring of currents and voltages
for power supplies/batteries.

This is a bit bad for driving a generic ADC like this using spidev and,
even if it was to be accessed from userspace only, having it under
drivers/spi is rather counterintuitive, what happens when the next ADC
using I2C turns up? drivers/i2c/chips?

I would suggest creating subsystem drivers/adc if you have time and
energy, other ideas?

Linus Walleij
