From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Add spi controller driver support for NUC900
Date: Thu, 19 Nov 2009 09:02:04 +0000
Message-ID: <20091119090204.GB13376@n2100.arm.linux.org.uk>
References: <4B024748.9080001@gmail.com> <20091118142109.ff2c5ef6.akpm@linux-foundation.org> <e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com> <20091118234928.8d86a9f9.akpm@linux-foundation.org> <e68bb3470911190040v2c14bbcfi46177cd58649e1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-spi <spi-devel-general@lists.sourceforge.net>,
	David Brownell-sourceforge <dbrownell@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Wan ZongShun <mcuos.com@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757290AbZKSJCp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e68bb3470911190040v2c14bbcfi46177cd58649e1c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 19, 2009 at 04:40:50PM +0800, Wan ZongShun wrote:
> 2009/11/19 Andrew Morton <akpm@linux-foundation.org>:
> > I don't know, because I don't know what operation the hardware need=
s to
> > stop it from generating interrupts. =A0Perhaps that's clk_disable()=
?
>=20
> The interrupt will be not occur as long as I run clk_disable().
>=20
> > Once you've stopped the source of interrupts then the code should w=
ait
> > for the IRQ handler to complete if it's running on another CPU. =A0=
Yes,
> > free_irq() does that.
>=20
> So, regarding my system of single CPU, maybe I need put this
> 'clk_disable()' in the front of function of w90p910_spi_remove().
>=20
> right?

Depending on the hardware, that's not the right answer.  If turning off
the clock also causes register accesses to the device to abort, it is
a very dangerous thing to do.

It can also be dangerous if the clock is used to synchronise the interr=
upt
output - it can lead to the output being permanently asserted if the cl=
ock
is turned off with it asserted.

Normally devices have an "interrupt enable" register.  You should disab=
le
all interrupts from the device using this register after unregistering
the driver from the (SPI) subsystem.
