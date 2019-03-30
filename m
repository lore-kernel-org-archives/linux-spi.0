From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support
 breaks modern chip select and whitens the GTA04 LCD panel
Date: Sat, 30 Mar 2019 19:33:06 +0100
Message-ID: <20190330193259.5054655e@aktux>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
        <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
        <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
        <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        kernel@pyra-handheld.com
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 24 Mar 2019 07:56:17 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Linus,
> 
> > Am 24.03.2019 um 05:15 schrieb Linus Walleij <linus.walleij@linaro.org>:
> > 
> > On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >   
> >> (1) c1c04cea13dc gpio: of: Fix logic inversion
> >> 
> >> together with the basic patch
> >> 
> >> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
> >> 
> >> leads to a severe regression for our GTA04 board.  
> > 
> > Sorry! :(
> > 
> > I found the same problem on my Nomadik board.
> > 
> > But I fixed it in that case by introducing a spi-cs-high into the DTS file:
> > https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2  
> 
> Yes, that of course works and is our temporary solution.
> 
> And I see that you also have it on the controller node and not the slave node.
> 
So if I get it right is a check added for undocumented properties
(nothing about  spi-cs-high  in controller node in the bindings
documentation, only in the slave node) in the two patches mentioned.

And then you add that undocumented property to a dts file in your "fix".

That all sounds strange to me.

> >   
> >> I learned that it tries to handle a legacy "spi-cs-high" property of SPI slaves, but was stopped
> >> from doing so by a bug (1). So only with both patches, the legacy handler becomes active which
> >> explains why it was not noticed earlier.
> >> 
> >> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written without any legacy spi properties
> >> in mind  
> > 
> > I'm sorry about that, however if you look at the DT binding document:
> > Documentation/devicetree/bindings/spi/spi-bus.txt  
> 
> Shouldn't it be a property of the slave node and not the controller node?
> 
> > 
> > You will see that spi-cs-high is mandatory. So these DTS files are
> > incorrect.  
> 
> How do you read that it is mandatory from
> 
> "All slave nodes can contain the following optional properties:
> - spi-cs-high     - Empty property indicating device requires chip select
> 		    active high."
> 
> I read it as optional and indicative. Equal priority to cs-gpios.
> 
Well, it is in the list of optional properties. So the question is how
that "optional" is interpreted. Is it optional because you only use it
if cs is active high or is it optional because you can either indicate
that fact here or via gpio definition.

But again that flags makes no sense in the controller node.

Regards,
Andreas
