From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: Add bindings for SPI NAND devices
Date: Fri, 1 Jun 2018 22:32:31 +0200
Message-ID: <20180601223231.022005f7@bbrezillon>
References: <20180601131400.17634-1-boris.brezillon@bootlin.com>
 <20180601131400.17634-3-boris.brezillon@bootlin.com>
 <CAMuHMdUyPoDA-7+OT_yT-g7kA+zae8Sjo6PYRFTFfFkQetUqnA@mail.gmail.com>
 <20180601190902.17cf5f6f@bbrezillon>
 <CAL_JsqKBn9g95irT71fgwWneLCM0jLAKuSPUkNxA_+73Rm8pVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Weinberger <richard@nod.at>, Kumar Gala <galak@codeaurora.org>,
 linux-spi <linux-spi@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqKBn9g95irT71fgwWneLCM0jLAKuSPUkNxA_+73Rm8pVA@mail.gmail.com>
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

Hi Rob,

On Fri, 1 Jun 2018 14:18:35 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Fri, Jun 1, 2018 at 12:09 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Hi Geert,
> >
> > On Fri, 1 Jun 2018 16:42:26 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >> Hi Boris,
> >>
> >> I became interested after reading the cover letter...
> >>
> >> On Fri, Jun 1, 2018 at 3:13 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:
> >> > Add bindings for SPI NAND chips.
> >> >
> >> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>
> >> Thanks for your patch!
> >
> > And thanks for reviewing it ;-).
> >
> >>
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> >> > @@ -0,0 +1,27 @@
> >> > +SPI NAND flash
> >> > +
> >> > +Required properties:
> >> > +- compatible: should be "spi-nand"
> 
> Seems awfully generic if you expect this alone. No chips with quirks
> yet?

Believe it or not, but it seems that NAND vendors agreed on a common
instruction set, made the READID instruction mandatory, and the 2 bytes
returned by this operation seem to be unique and allow us to reliably
extract information about he SPI NAND chip. I'm not saying this will
keep going like that (I'm pretty sure they'll screw up the READID
detection and start re-using IDs for different NANDs at some point),
but so far it seems to work.

> Is there a standard for detection like jedec?

Not that I know of. Some NANDs embed an ONFi table, which is usually
used on parallel/raw NANDs, but this is not mandatory.

> 
> >> > +- reg: should encode the chip-select line used to access the NAND chip
> 
> "see spi.txt" should be enough.

Okay.

> 
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
> > spi-max-frequency is when the board design impose such restrictions,
> > hence the precision I give here.
> 
> This should always be the case. The operating frequency should be
> min(host max, device max) unless the board has restrictions and needs
> to set spi-max-frequency (and we really should have used
> 'bus-frequency' here).

That was my feeling too.

> No doubt though, that is not what has been
> done.

Definitely not, actually, I'm not even sure that this sort if
negotiation is supported by the framework. Right now, the SPI NAND
driver does not try to set max device freq, but that's something I was
planning to work on at some point, and since bindings are supposed to
be set in stone I thought I would clarify the meaning of
spi-max-frequency for the SPI NAND use case.

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
> 
> Like frequency, this should have been similar. I imagine for the
> common case, the number of host and device lines are 1 so it doesn't
> really apply as this was added later on. Perhaps we can reword the
> common definition to work for both?

Do you have a suggestion? Also, I fear that globally changing the
meaning of these props will make most implementations not compliant
with this new definition.

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
