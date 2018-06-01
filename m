From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 2/4] dt-bindings: Add bindings for SPI NAND devices
Date: Fri, 1 Jun 2018 16:42:26 +0200
Message-ID: <CAMuHMdUyPoDA-7+OT_yT-g7kA+zae8Sjo6PYRFTFfFkQetUqnA@mail.gmail.com>
References: <20180601131400.17634-1-boris.brezillon@bootlin.com>
 <20180601131400.17634-3-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Weinberger <richard@nod.at>, Kumar Gala <galak@codeaurora.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180601131400.17634-3-boris.brezillon@bootlin.com>
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

Hi Boris,

I became interested after reading the cover letter...

On Fri, Jun 1, 2018 at 3:13 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add bindings for SPI NAND chips.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> @@ -0,0 +1,27 @@
> +SPI NAND flash
> +
> +Required properties:
> +- compatible: should be "spi-nand"
> +- reg: should encode the chip-select line used to access the NAND chip
> +
> +Optional properties
> +- spi-max-frequency: maximum frequency of the SPI bus the chip can operate at.
> +                    This should encode board limitations (i.e. max freq can't
> +                    be achieved due to crosstalk on IO lines).
> +                    When unspecified, the driver assumes the chip can run at
> +                    the max frequency defined in the spec (information
> +                    extracted chip detection time).

This is a standard property according to
Documentation/devicetree/bindings/spi/spi-bus.txt. Can't you just refer
to that file, or just omit it, as it applies to all SPI slaves anyway?

> +- spi-tx-bus-width: The bus width (number of data wires) that is used for MOSI.
> +                   Only encodes the board constraints (i.e. when not all IO
> +                   signals are routed on the board). Device constraints are
> +                   extracted when detecting the chip, and controller
> +                   constraints are exposed by the SPI mem controller. If this
> +                   property is missing that means no constraint at the board
> +                   level.
> +- spi-rx-bus-width: The bus width (number of data wires) that is used for MISO.
> +                   Only encodes the board constraints (i.e. when not all IO
> +                   signals are routed on the board). Device constraints are
> +                   extracted when detecting the chip, and controller
> +                   constraints are exposed by the SPI mem controller. If this
> +                   property is missing that means no constraint at the board
> +                   level.

This does not match Documentation/devicetree/bindings/spi/spi-bus.txt,
which says the default is 1.

As these properties are handled by the SPI core in of_spi_parse_dt, why
would you want to deviate?

Commenting to the question in the cover letter: what would be the
purpose of spi-max-bus-width?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
