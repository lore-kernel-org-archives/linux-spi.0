From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support
 breaks modern chip select and whitens the GTA04 LCD panel
Date: Tue, 2 Apr 2019 11:18:39 +0700
Message-ID: <CACRpkdaqz+_j_n0kuduGqOb38W6ETyOzUgaiZVX3CQWXN2_zbQ@mail.gmail.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <20190330193259.5054655e@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
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

On Sun, Mar 31, 2019 at 1:33 AM Andreas Kemnade <andreas@kemnade.info> wrote:

> > > But I fixed it in that case by introducing a spi-cs-high into the DTS file:
> > > https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2
> >
> > Yes, that of course works and is our temporary solution.
> >
> > And I see that you also have it on the controller node and not the slave node.
> >
> So if I get it right is a check added for undocumented properties
> (nothing about  spi-cs-high  in controller node in the bindings
> documentation, only in the slave node) in the two patches mentioned.
>
> And then you add that undocumented property to a dts file in your "fix".
>
> That all sounds strange to me.

Yeah it sounds strange because it is strange :)

I was simply confused and wrong. Sometimes we all do very uniformed
things, today it was me.

The flag should of course be on the slave node.

So now I have to fix my fix.

Yours,
Linus Walleij
