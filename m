From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
Date: Sun, 24 Mar 2019 05:15:03 +0100
Message-ID: <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jan Kotas <jank@cadence.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> (1) c1c04cea13dc gpio: of: Fix logic inversion
>
> together with the basic patch
>
> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>
> leads to a severe regression for our GTA04 board.

Sorry! :(

I found the same problem on my Nomadik board.

But I fixed it in that case by introducing a spi-cs-high into the DTS file:
https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2

> I learned that it tries to handle a legacy "spi-cs-high" property of SPI slaves, but was stopped
> from doing so by a bug (1). So only with both patches, the legacy handler becomes active which
> explains why it was not noticed earlier.
>
> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written without any legacy spi properties
> in mind

I'm sorry about that, however if you look at the DT binding document:
Documentation/devicetree/bindings/spi/spi-bus.txt

You will see that spi-cs-high is mandatory. So these DTS files are
incorrect.

> Therefore I would suggest:
> * revert both patches as soon as possible (v5.1-rc series) to remove the unexpected spi legacy
>   code handler from the gpio subsystem.
> * replace all uses of spi-cs-high by correct cs-gpios flags - unless they already are there.
>   fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS candidates.
> * fix spi-bus.txt documentation to describe this potential pitfall.

This does not work because there are devices that requires spi-cs-high to be
respected and the DTS second cell GPIO flag to be ignored.

Jan Kotas reported this problem.

They might have deployed DTB binaries that need to keep working, so we
cannot change it to ignore spi-cs-high like this. (I might give in if it can be
proven that all of them just recompile the DTS all the time and no
DTBs are in flash.)

I think in this case the oldest binding wins. The spi-cs-high was there before
we came up with the scheme to use the flags cell with GPIO phandles.

I think you simply have to patch these GTA04 DTS files to use
spi-cs-high.

But I'm open to other ideas, let's discuss this.

Yours,
Linus Walleij
