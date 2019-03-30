From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
Date: Sat, 30 Mar 2019 21:10:47 +0100
Message-ID: <14098F3F-0DDD-42AA-A7AD-DC35FD4C1F23@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com> <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <20190330193259.5054655e@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        kernel@pyra-handheld.com
To: Andreas Kemnade <andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330193259.5054655e@aktux>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andreas,

> Am 30.03.2019 um 19:33 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Sun, 24 Mar 2019 07:56:17 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi Linus,
>>=20
>>> Am 24.03.2019 um 05:15 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>>>=20
>>> On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>>> (1) c1c04cea13dc gpio: of: Fix logic inversion
>>>>=20
>>>> together with the basic patch
>>>>=20
>>>> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>>>>=20
>>>> leads to a severe regression for our GTA04 board. =20
>>>=20
>>> Sorry! :(
>>>=20
>>> I found the same problem on my Nomadik board.
>>>=20
>>> But I fixed it in that case by introducing a spi-cs-high into the =
DTS file:
>>> https://marc.info/?l=3Dlinux-arm-kernel&m=3D155292310015309&w=3D2 =20=

>>=20
>> Yes, that of course works and is our temporary solution.
>>=20
>> And I see that you also have it on the controller node and not the =
slave node.
>>=20
> So if I get it right is a check added for undocumented properties
> (nothing about  spi-cs-high  in controller node in the bindings
> documentation, only in the slave node) in the two patches mentioned.
>=20
> And then you add that undocumented property to a dts file in your =
"fix".
>=20
> That all sounds strange to me.

>=20
>>>=20
>>>> I learned that it tries to handle a legacy "spi-cs-high" property =
of SPI slaves, but was stopped
>>>> from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
>>>> explains why it was not noticed earlier.
>>>>=20
>>>> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already =
written without any legacy spi properties
>>>> in mind =20
>>>=20
>>> I'm sorry about that, however if you look at the DT binding =
document:
>>> Documentation/devicetree/bindings/spi/spi-bus.txt =20
>>=20
>> Shouldn't it be a property of the slave node and not the controller =
node?
>>=20
>>>=20
>>> You will see that spi-cs-high is mandatory. So these DTS files are
>>> incorrect. =20
>>=20
>> How do you read that it is mandatory from
>>=20
>> "All slave nodes can contain the following optional properties:
>> - spi-cs-high     - Empty property indicating device requires chip =
select
>> 		    active high."
>>=20
>> I read it as optional and indicative. Equal priority to cs-gpios.
>>=20
> Well, it is in the list of optional properties. So the question is how
> that "optional" is interpreted. Is it optional because you only use it
> if cs is active high or is it optional because you can either indicate
> that fact here or via gpio definition.
>=20
> But again that flags makes no sense in the controller node.

I have already prepared some fix for this controller/slave node issue =
and
a new CONFIG option to enable the legacy "spi-cs-high" only if needed.
Seems to be common practice that legacy API support (and legacy DTB
compatibility is also "API") is only enabled by CONFIGs on demand.

This can then replace our current GTA04 hack. Will post ASAP to LKML.

BR,
Nikolaus
