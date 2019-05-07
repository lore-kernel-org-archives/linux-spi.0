From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
Date: Tue, 7 May 2019 17:13:53 +0200
Message-ID: <20190507151353.ns2i72ii5cw6z7lz@flea>
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-spi <linux-spi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

Hi,

On Tue, May 07, 2019 at 09:35:28AM -0500, Rob Herring wrote:
> On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The SPI controllers have a bunch of generic options that are needed in a
> > device tree. Add a YAML schemas for those.
>
> I'd started on this one, but was planning to move it to the schema
> repository. The issue there is re-licensing (adding BSD 2 clause).
> Maybe better to just move it later.

I just found out that dt-doc-validate also chokes on the reference
URI. Maybe I should just submit it to the repo then once that is
settled?

> > +properties:
> > +  $nodename:
> > +    pattern: "^spi(@[a-zA-Z0-9]+)?$"
>
> I think we want just "(@.*)". At a minimum, you need to allow for ','.
> It would be the a bus schema for the parent which should validate unit
> addresses, so we should pretty much just allow anything here.

The issue with this is that it will also match any node starting with
spi. In the Allwinner case, that also means the pinctrl nodes with spi
pins in them, but I'm sure we can find more corner cases.

> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  cs-gpios:
> > +    description: |
> > +      GPIOs used as chip selects.
> > +      If that property is used, the number of chip selects will be
> > +      increased automatically with max(cs-gpios, hardware chip selects).
> > +
> > +      So if, for example, the controller has 2 CS lines, and the
> > +      cs-gpios looks like this
> > +        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
> > +
> > +      Then it should be configured so that num_chipselect = 4, with
> > +      the following mapping
> > +        cs0 : &gpio1 0 0
> > +        cs1 : native
> > +        cs2 : &gpio1 1 0
> > +        cs3 : &gpio1 2 0
> > +
> > +  num-cs:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Total number of chip selects.
> > +
> > +  spi-slave:
> > +    $ref: /schemas/types.yaml#/definitions/flag
>
> "type: boolean" is sufficient here. Maybe we should just remove
> 'flag'. OTOH, maybe consistency with other types and the abstraction
> is better as we could add to the flag schema.

I was trying to be consistent. Do you want me to remove it?

> > +      spi-rx-bus-width:
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [ 1, 2, 4, 8 ]
>
> Is the old doc out of date and 8 is allowed now?

It's not, it's a copy and paste mistake.

I'll respin this with your fixes, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
