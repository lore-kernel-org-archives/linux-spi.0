From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: Add bindings for SPI NAND devices
Date: Mon, 4 Jun 2018 12:04:51 +0200
Message-ID: <20180604120451.70fa75db@bbrezillon>
References: <20180601131400.17634-1-boris.brezillon@bootlin.com>
 <20180601131400.17634-3-boris.brezillon@bootlin.com>
 <CAMuHMdUyPoDA-7+OT_yT-g7kA+zae8Sjo6PYRFTFfFkQetUqnA@mail.gmail.com>
 <20180601190902.17cf5f6f@bbrezillon>
 <CAMuHMdWqa4++tdrpWCAsdqjqN26CHB1+eudnCtsP2vcrzmkA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Weinberger <richard@nod.at>, Kumar Gala <galak@codeaurora.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdWqa4++tdrpWCAsdqjqN26CHB1+eudnCtsP2vcrzmkA_w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, 1 Jun 2018 19:40:00 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Jun 1, 2018 at 7:09 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Fri, 1 Jun 2018 16:42:26 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> >> On Fri, Jun 1, 2018 at 3:13 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:  
> >> > Add bindings for SPI NAND chips.  
> 
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> >> > @@ -0,0 +1,27 @@
> >> > +SPI NAND flash
> >> > +
> >> > +Required properties:
> >> > +- compatible: should be "spi-nand"
> >> > +- reg: should encode the chip-select line used to access the NAND chip
> >> > +
> >> > +Optional properties
> >> > +- spi-max-frequency: maximum frequency of the SPI bus the chip can operate at.
> >> > +                    This should encode board limitations (i.e. max freq can't
> >> > +                    be achieved due to crosstalk on IO lines).
> >> > +                    When unspecified, the driver assumes the chip can run at
> >> > +                    the max frequency defined in the spec (information
> >> > +                    extracted chip detection time).  
> >>
> >> This is a standard property according to
> >> Documentation/devicetree/bindings/spi/spi-bus.txt. Can't you just refer
> >> to that file, or just omit it, as it applies to all SPI slaves anyway?  
> >
> > The thing is, the maximum frequency supported by a SPI NAND is directly
> > encoded in the NAND device ID and can be auto-detected. Why should we
> > define spi-max-frequency in the DT when we can automatically detect
> > this information? The only reason one might want to override  
> 
> Because that's how we dealt with this traditionally. Or at least I thought so.
> But include/linux/spi/spi.h says:
> 
>  * @max_speed_hz: Maximum clock rate to be used with this chip
>  *      (on this board); may be changed by the device's driver.
>  *      The spi_transfer.speed_hz can override this for each transfer.
> 
> and many drivers seem to do so.
> 
> > spi-max-frequency is when the board design impose such restrictions,
> > hence the precision I give here.  
> 
> Which is exactly the meaning of the standard property, isn't it?
> 
> So I think it can just be omitted here anyway.  If it's present, the SPI
> core will make sure it's taken into account.
> 
> >> > +- spi-tx-bus-width: The bus width (number of data wires) that is used for MOSI.
> >> > +                   Only encodes the board constraints (i.e. when not all IO
> >> > +                   signals are routed on the board). Device constraints are
> >> > +                   extracted when detecting the chip, and controller
> >> > +                   constraints are exposed by the SPI mem controller. If this
> >> > +                   property is missing that means no constraint at the board
> >> > +                   level.
> >> > +- spi-rx-bus-width: The bus width (number of data wires) that is used for MISO.
> >> > +                   Only encodes the board constraints (i.e. when not all IO
> >> > +                   signals are routed on the board). Device constraints are
> >> > +                   extracted when detecting the chip, and controller
> >> > +                   constraints are exposed by the SPI mem controller. If this
> >> > +                   property is missing that means no constraint at the board
> >> > +                   level.  
> >>
> >> This does not match Documentation/devicetree/bindings/spi/spi-bus.txt,
> >> which says the default is 1.  
> >
> > Yes, I know.
> >  
> >> As these properties are handled by the SPI core in of_spi_parse_dt, why
> >> would you want to deviate?  
> >
> > Because, again, this information can be extracted from the NAND ID, and
> > the only reason we might want to override the information extracted
> > from the NAND ID is when the board design adds extra restrictions
> > (like, only 2 SIO lines wired on the 4 available).  
> 
> In struct spi_device, this is specified using the SPI_[RT]_X_{DUAL,QUAD}
> bits in the mode field. Documentation says:
> 
>  * @mode: The spi mode defines how data is clocked out and in.
>  *      This may be changed by the device's driver.
>  *      The "active low" default for chipselect mode can be overridden
>  *      (by specifying SPI_CS_HIGH) as can the "MSB first" default for
>  *      each word in a transfer (by specifying SPI_LSB_FIRST).
> 
> So this may also be specified by the device driver, but it seems no driver
> does so for the dual/quad bits, except for drivers/mtd/spi-nor/nxp-spifi.c
> (for rx only).
> 
> But here we do have the generic SPI DT bindings saying the default is 1.
> So personally, I wouldn't go for the option of the least surprise, and
> don't deviate from the generic bindings.
> 
> >> Commenting to the question in the cover letter: what would be the
> >> purpose of spi-max-bus-width?  
> >
> > Defining how many IO lines are wired on the board design. If this
> > property is missing we would assume all IO lines are wired and the
> > restrictions would be negotiated between the controller and the device
> > without requiring explicit description in the DT.  
> 
> Which is exactly the meaning of the standard property, except for the
> default of all vs. 1.
> 
> I'll have to defer to Mark (broonie) for his opinion about deviating from
> the way this is handled traditionally, and assuming different defaults...

I think I'll drop the extra description on spi-max-frequency and
spi-{rx,tx}-bus-width props for now. Those are anyway not taken into
account by the SPI NAND driver yet.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
