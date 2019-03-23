From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
Date: Sat, 23 Mar 2019 15:40:29 +0100
Message-ID: <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,
I am sorry to report that your patch

(1) c1c04cea13dc gpio: of: Fix logic inversion

together with the basic patch

(2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings

leads to a severe regression for our GTA04 board. The symptom was easy =
to see but really difficult
to understand: the LCD panel stopped working (did only show white =
pixels) after upgrading from
v5.0 to v5.1-rc1.

In a long bisect session, I was able to identify patch (1) as the first =
bad commit and started
to analyse what the code is supposed to do and then found the older =
patch (2).

I learned that it tries to handle a legacy "spi-cs-high" property of SPI =
slaves, but was stopped
from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
explains why it was not noticed earlier.

Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written =
without any legacy spi properties
in mind

(3) c2e138bc8ed80 ARM: dts: omap3-gta04: Add display support

So it has no spi-cs-high property and just defines constant 0 for the =
flags (GPIO_ACTIVE_HIGH after
some fix from 2015) assuming that this is sufficient. And it was until =
before v5.1-rc1.

This is now wrongly turned into an GPIO_ACTIVE_LOW by your legacy fix =
which makes the panel
stop feeling responsible to receive any initialization data over SPI.

Yes, there is a new message in the boot log for this case, but to be =
honest, nobody did see it
before I found the code that does print it. A non-working LCD panel was =
a too distracting indicator
and could have been everything (most likely drm or the panel driver or =
clock or regulator or
dma setup or whatever)...

So your assumption that this case is the exception as stated in commit =
message of (2) seems not
to be true. IMHO it should be standard (at least since 2015) that there =
is GPIO_ACTIVE_HIGH and
no spi-cs-high. So your patch (2) gives a legacy property a new priority =
over modern style.

BTW: the spi-cs-high is described as optional and indicative in the =
bindings document. But it
now appears to be required to get a cs-high.

By the way, the detection of spi-cs-high still seems to be wrong as of =
v5.1-rc1. Shouldn't it
look at the child node for "spi-cs-high" and not the controller node =
pointer? As far as I understand
the current code, all such legacy flags are therefore ignored and should =
break all boards that
use spi-cs-high and GPIO_ACTIVE_HIGH.

Of course, adding spi-cs-high; (at the controller node!) of our device =
tree can make it work,
but I do not like to be forced to introduce a legacy property to our DTS =
file, just because
gpio-lib tries to fix a legacy problem in the SPI subsystem (quite =
mind-twisting cross-subsystem
dependencies, aren't they?).

The real problem seems to be that the legacy spi-cs-high property itself =
still exists although
it should not be needed for ca. 5 years. =46rom all this I conclude that =
nobody really needs this
legacy support or does test it. And if he/she does, they should better =
fix the cs-gpios entries
in the DTS and remove spi-cs-high completely.

Therefore I would suggest:
* revert both patches as soon as possible (v5.1-rc series) to remove the =
unexpected spi legacy
  code handler from the gpio subsystem.
* replace all uses of spi-cs-high by correct cs-gpios flags - unless =
they already are there.
  fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS =
candidates.
* fix spi-bus.txt documentation to describe this potential pitfall.

Then we can leave our GTA04 display and device tree untouched as from =
v3.16-rc1 up to v5.0.x.

BR and thanks,
Nikolaus
