From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the
 FSL QSPI driver
Date: Thu, 12 Jul 2018 09:20:45 -0600
Message-ID: <CAL_JsqLYiiLNabGWnriL7UoUpVmYfAii+3y-o8od6wU7=xpz1A@mail.gmail.com>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
 <20180711160521.GA16884@rob-hp-laptop> <9fd871dd-3d10-044c-db80-d65df161a7d9@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: MTD Maling List <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, david.wolfe@nxp.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Han Xu <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9fd871dd-3d10-044c-db80-d65df161a7d9@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 12, 2018 at 2:14 AM Frieder Schrempf
<frieder.schrempf@exceet.de> wrote:
>
> Hi Rob,
>
> On 11.07.2018 18:05, Rob Herring wrote:
> > On Thu, Jul 05, 2018 at 01:15:01PM +0200, Frieder Schrempf wrote:
> >> Adjust the documentation of the new SPI memory interface based
> >> driver to reflect the new drivers settings.
> >
> > Bindings shouldn't change (other than new properties) due to driver
> > changes.
>
> Right, I added an explanation below, why I think the changes are necessary.
>
> >
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> >> ---
> >> Changes in v2:
> >> ==============
> >> * Split the moving and editing of the dt-bindings in two patches
> >>
> >>   .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
> >>   1 file changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> >> index 483e9cf..8b4eed7 100644
> >> --- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> >> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> >> @@ -3,9 +3,8 @@
> >>   Required properties:
> >>     - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
> >>               "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
> >> -             "fsl,ls1021a-qspi"
> >> +             "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
> >>               or
> >> -             "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
> >>               "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
> >
> > So the 2080a h/w was compatible with the 1021a h/w, but now it is not?
> > How did the h/w change?
>
> I guess this should be posted as a separate fix. Formerly there was only
> "fsl,ls1021a-qspi" handled in the driver and the bindings here claimed
> that "fsl,ls2080a-qspi" is compatible.
>
> Some time ago a separate entry for "fsl,ls2080a-qspi" was added to the
> driver [1] and it adds a quirk, that is not set for "fsl,ls1021a-qspi".
> That's why I concluded, that these two are actually not compatible.

So before the driver change, the driver didn't work at all on the
ls2080a? If so, then removing is appropriate. If not, then removing
breaks all kernel versions before the change if you use a newer DT.


> >>     - reg : the first contains the register location and length,
> >>             the second contains the memory mapping address and length
> >> @@ -15,14 +14,15 @@ Required properties:
> >>     - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
> >>
> >>   Optional properties:
> >> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
> >> -                              Each bus can be connected with two NOR flashes.
> >> -                          Most of the time, each bus only has one NOR flash
> >> -                          connected, this is the default case.
> >> -                          But if there are two NOR flashes connected to the
> >> -                          bus, you should enable this property.
> >> -                          (Please check the board's schematic.)
> >
> > You can't just remove properties without explanation. Why is this no
> > longer needed? What about backwards compatibility with existing dtbs?
>
> You're right, the explanation is missing here.
>
> The "old" driver was using this property to select one of two dual chip
> setups (two chips on one bus or two chips on separate buses). And it
> used the order in which the subnodes are defined in the dt to select the
> CS, the chip is connected to.
>
> Both methods are wrong and in fact the "reg" property should be used to
> determine which bus and CS a chip is connected to. This also enables us
> to use different setups than just single chip, or symmetric dual chip.
>
> So the porting of the driver from the MTD to the SPI framework actually
> enforces the use of the "reg" properties and makes
> "fsl,qspi-has-second-chip" superfluous.
>
> As all boards that have "fsl,qspi-has-second-chip" set, also have
> correct "reg" properties, the removal of this property shouldn't lead to
> any incompatibilities.
>
> The only compatibility issues I can see are with imx6sx-sdb.dts and
> imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
> (see explanation here: [2]), all other boards should stay compatible.

Add this to the commit msg.

> >> -  - big-endian : That means the IP register is big endian
> >> +  - big-endian : That means the IP registers format is big endian
> >
> > This is a standard property so it doesn't really need to be redefined
> > here, but just reference the definition.
>
> So I will change that to:
>
>         big-endian : See common-properties.txt for a definition

You can drop "for a definition"

Rob
