From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC v2 1/7] spi: Document DT bindings for SPI controllers
 in slave mode
Date: Thu, 22 Sep 2016 16:13:36 -0500
Message-ID: <20160922211336.GB29078@rob-hp-laptop>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
 <1473713446-30366-2-git-send-email-geert+renesas@glider.be>
 <20160920150058.GA29078@rob-hp-laptop>
 <CAMuHMdU_YnhFTPiuTEeka+4H0ft+4vjeSAhbu8wHU2PPr4exHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_YnhFTPiuTEeka+4H0ft+4vjeSAhbu8wHU2PPr4exHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 21, 2016 at 02:47:50PM +0200, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Sep 20, 2016 at 5:00 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Sep 12, 2016 at 10:50:40PM +0200, Geert Uytterhoeven wrote:
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> v2:
> >>   - Do not create a child node in SPI slave mode. Instead, add an
> >>     "spi-slave" property, and put the mode properties in the controller
> >>     node.
> >> ---
> >>  Documentation/devicetree/bindings/spi/spi-bus.txt | 34 ++++++++++++++---------
> >>  1 file changed, 21 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> >> index 17822860cb98c34d..1ae28d7cafb68dc5 100644
> >> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> >> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> >> @@ -1,17 +1,23 @@
> >>  SPI (Serial Peripheral Interface) busses
> >>
> >> -SPI busses can be described with a node for the SPI master device
> >> -and a set of child nodes for each SPI slave on the bus.  For this
> >> -discussion, it is assumed that the system's SPI controller is in
> >> -SPI master mode.  This binding does not describe SPI controllers
> >> -in slave mode.
> >> +SPI busses can be described with a node for the SPI controller device
> >> +and a set of child nodes for each SPI slave on the bus.  The system's SPI
> >> +controller may be described for use in SPI master mode or in SPI slave mode,
> >> +but not for both at the same time.
> >>
> >> -The SPI master node requires the following properties:
> >> +The SPI controller node requires the following properties:
> >> +- compatible      - name of SPI bus controller following generic names
> >> +             recommended practice.
> >
> > We'll probably need some way to define what interface/protocol
> > the slave has. Perhaps the most specific compatible should be the
> > protocol the slave uses? Maybe that is how you use a child node?
> 
> That was indeed an advantage of using a child node (which you suggested
> _not_ doing in your review of v1?): you can specify which protocol to use.

Yeah, maybe V1 was better... One thing though, the child node should be 
optional IMO. Maybe you keep "spi-slave" too to define the controller is 
in slave mode, but the protocol is not defined. Or maybe no child nodes 
is sufficient?

> In v2, the protocol is specified through sysfs, like for i2c slave.

That's fine, because it may be purely a s/w decision what the protocol 
is. If it is fixed, then in DT is fine.

> Note that SPI is different than I2C: an SPI slave is connected to a single
> master, and can assume a single role only, while I2C is a shared bus, and
> a slave can assume multiple roles (an I2C slave can respond to multiple
> addresses, and can e.g. provide more than one software I2C EEPROM).
> So you could argue the protocol is fixed by the hardware topology, cfr.
> my v1.

If the protocol is s/w on both sides, then the protocol could easily 
change.


> >> +In master mode, the SPI controller node requires the following additional
> >> +properties:
> >>  - #address-cells  - number of cells required to define a chip select
> >>               address on the SPI bus.
> >>  - #size-cells     - should be zero.
> >> -- compatible      - name of SPI bus controller following generic names
> >> -             recommended practice.
> >> +
> >> +In slave mode, the SPI controller node requires one additional property:
> >> +- spi-slave       - Empty property.
> >> +
> >>  No other properties are required in the SPI bus node.  It is assumed
> >>  that a driver for an SPI bus device will understand that it is an SPI bus.
> >>  However, the binding does not attempt to define the specific method for
> >> @@ -21,7 +27,7 @@ assumption that board specific platform code will be used to manage
> >>  chip selects.  Individual drivers can define additional properties to
> >>  support describing the chip select layout.
> >>
> >> -Optional properties:
> >> +Optional properties (master mode only):
> >>  - cs-gpios     - gpios chip select.
> >>  - num-cs       - total number of chipselects.
> >>
> >> @@ -41,12 +47,14 @@ cs1 : native
> >>  cs2 : &gpio1 1 0
> >>  cs3 : &gpio1 2 0
> >>
> >> -SPI slave nodes must be children of the SPI master node and can
> >> -contain the following properties.
> >> -- reg             - (required) chip select address of device.
> >> +In master mode, SPI slave nodes must be children of the SPI controller node.
> >> +In slave mode, the (single) slave device is represented by the controller node
> >> +itself. SPI slave nodes can contain the following properties.
> >
> > I find this a bit confusing as you talk about master mode, then slave
> > mode, then slave nodes (master mode again).
> 
> The last part is actually about both master and slave mode: in slave mode,
> the properties apply to the controller node itself, instead of to child nodes.
> 
> I wanted to reuse as much of the existing text as possible.
> But I agree the description could use some refactoring.

Even with a child node, I think it is better to just have 2 sections and 
list common properties twice.

Rob
