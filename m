From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
Date: Wed, 8 May 2019 09:02:17 +0200
Message-ID: <CAMuHMdX7KjJf4yDiEBBXLogHGbo9LcfTM5TvCHAXu_0Bvf0uzA@mail.gmail.com>
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-spi <linux-spi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tue, May 7, 2019 at 4:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > The SPI controllers have a bunch of generic options that are needed in a
> > device tree. Add a YAML schemas for those.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

> > index 1f6e86f787ef..000000000000
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ /dev/null

> > -In master mode, the SPI controller node requires the following additional
> > -properties:
> > -- #address-cells  - number of cells required to define a chip select
> > -               address on the SPI bus.
> > -- #size-cells     - should be zero.
> > -
> > -In slave mode, the SPI controller node requires one additional property:
> > -- spi-slave       - Empty property.

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml

> > +  spi-slave:
> > +    $ref: /schemas/types.yaml#/definitions/flag
>
> "type: boolean" is sufficient here. Maybe we should just remove
> 'flag'. OTOH, maybe consistency with other types and the abstraction
> is better as we could add to the flag schema.
>
> > +    description:
> > +      The SPI controller acts as a slave, instead of a master.
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
>
> Only if there are child nodes...

... and spi-slave is not present.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
