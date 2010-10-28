From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v4 01/12] misc: add driver for sequencer serial port
Date: Thu, 28 Oct 2010 11:49:06 -0400
Message-ID: <AANLkTi=rDep3jkp2QAjVsgjZ7JQ0ysnse4TARv29fyHm@mail.gmail.com>
References: <1288124308-14999-1-git-send-email-cyril@ti.com>
	<1288124308-14999-2-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davinci-linux-open-source@linux.davincidsp.com,
	spi-devel-general@lists.sourceforge.net,
	broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk,
	dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rpurdie@rpsys.net, Samuel Ortiz <sameo@linux.intel.com>
To: Cyril Chemparathy <cyril@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288124308-14999-2-git-send-email-cyril@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/10/26 Cyril Chemparathy <cyril@ti.com>:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of s=
erial port
> device. =A0It has a built-in programmable execution engine that can b=
e programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others)=
=2E
>
> This patch adds a driver for this controller device. =A0The driver do=
es not
> expose a user-land interface. =A0Protocol drivers built on top of thi=
s layer are
> expected to remain in-kernel.

Why is this thing in drivers/misc?

drivers/mfd is IMHO the apropriate place for a driver like this, and
the subdrivers should be migrated to use mfd cells and platform
drivers for the subdevices.

All functions and abstractions you create here look suspiciously
lot like other MFD devices.

But please, beat me up if I'm wrong!

Yours,
Linus Walleij
