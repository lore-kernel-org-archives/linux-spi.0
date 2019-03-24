From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
Date: Sun, 24 Mar 2019 07:56:17 +0100
Message-ID: <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Jan Kotas <jank@cadence.com>, LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

> Am 24.03.2019 um 05:15 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> (1) c1c04cea13dc gpio: of: Fix logic inversion
>>=20
>> together with the basic patch
>>=20
>> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>>=20
>> leads to a severe regression for our GTA04 board.
>=20
> Sorry! :(
>=20
> I found the same problem on my Nomadik board.
>=20
> But I fixed it in that case by introducing a spi-cs-high into the DTS =
file:
> https://marc.info/?l=3Dlinux-arm-kernel&m=3D155292310015309&w=3D2

Yes, that of course works and is our temporary solution.

And I see that you also have it on the controller node and not the slave =
node.

>=20
>> I learned that it tries to handle a legacy "spi-cs-high" property of =
SPI slaves, but was stopped
>> from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
>> explains why it was not noticed earlier.
>>=20
>> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written =
without any legacy spi properties
>> in mind
>=20
> I'm sorry about that, however if you look at the DT binding document:
> Documentation/devicetree/bindings/spi/spi-bus.txt

Shouldn't it be a property of the slave node and not the controller =
node?

>=20
> You will see that spi-cs-high is mandatory. So these DTS files are
> incorrect.

How do you read that it is mandatory from

"All slave nodes can contain the following optional properties:
- spi-cs-high     - Empty property indicating device requires chip =
select
		    active high."

I read it as optional and indicative. Equal priority to cs-gpios.

>=20
>> Therefore I would suggest:
>> * revert both patches as soon as possible (v5.1-rc series) to remove =
the unexpected spi legacy
>>  code handler from the gpio subsystem.
>> * replace all uses of spi-cs-high by correct cs-gpios flags - unless =
they already are there.
>>  fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS =
candidates.
>> * fix spi-bus.txt documentation to describe this potential pitfall.
>=20
> This does not work because there are devices that requires spi-cs-high =
to be
> respected and the DTS second cell GPIO flag to be ignored.

Then, those should be fixed...

>=20
> Jan Kotas reported this problem.

Thanks for adding him to the discussion.

>=20
> They might have deployed DTB binaries that need to keep working,

Well, that is a weak argument. What if the GTA04 would have the DTB in =
FLASH
and would need it working (fortunately we always reflash kernel + dtbs)?

> so we
> cannot change it to ignore spi-cs-high like this. (I might give in if =
it can be
> proven that all of them just recompile the DTS all the time and no
> DTBs are in flash.)

BTW, on which node do these invariable DTBs have the spi-cs-high flag?
In the controller node (IMHO wrong) or the slave node (according to =
bindings doc)?

I have checked with randomly picked imx51-babbage.dts and it has it in =
the
slave node (pmic: mc13892@0). It also seems to be an example where =
different
CS lines want different settings.

If the all these DTBs have spi-cs-high in the slave node, none of them =
will
be fixed by the current code.

>=20
> I think in this case the oldest binding wins.

Ok, it is the question when such deprecated things are really removed.
There is no clear answer...

> The spi-cs-high was there before
> we came up with the scheme to use the flags cell with GPIO phandles.

>=20
> I think you simply have to patch these GTA04 DTS files to use
> spi-cs-high.

Ugly... Well, if DTS maintainers accept that?

>=20
> But I'm open to other ideas, let's discuss this.

What about a CONFIG to explicitly enable/disable this legacy support?

IMHO it will need to be enabled for les than 1% of the kernel builds and
therefore also keeps the zImage smaller for all others. And avoids DTB
changes where the gpio flags are already correct.

BR and thanks,
Nikolaus
