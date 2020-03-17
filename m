From: Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Date: Tue, 17 Mar 2020 10:02:44 +0100
Message-ID: <20200317090244.jmucfw5pkxzrce7e@gilmour.lan>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316204850.gggeyjulgiy53i7x@gilmour.lan>
 <20200316214346.GA23637@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="56oevq6iibsekfv4"
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Fr
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316214346.GA23637-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--56oevq6iibsekfv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Mar 16, 2020 at 10:43:46PM +0100, Sam Ravnborg wrote:
> On Mon, Mar 16, 2020 at 09:48:50PM +0100, Maxime Ripard wrote:
> > Hi Sam,
> >
> > On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> > > Independent bindings can be SPI slaves which for example is
> > > the case for several panel bindings.
> > >
> > > Move SPI slave properties to spi-slave.yaml so the independent
> > > SPI slave bindings can include spi-slave.yaml rather than
> > > duplicating the properties.
> > >
> > > Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> > > Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> > > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > ---
> > >  .../bindings/spi/spi-controller.yaml          | 63 +-------------
> > >  .../devicetree/bindings/spi/spi-slave.yaml    | 83 +++++++++++++++++++
> > >  2 files changed, 86 insertions(+), 60 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > index 1e0ca6ccf64b..99531c8d10dd 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > @@ -67,71 +67,14 @@ patternProperties:
> > >    "^.*@[0-9a-f]+$":
> > >      type: object
> > >
> > > +    allOf:
> > > +      - $ref: spi-slave.yaml#
> > > +
> > >      properties:
> > >        compatible:
> > >          description:
> > >            Compatible of the SPI device.
> > >
> > > -      reg:
> > > -        minimum: 0
> > > -        maximum: 256
> > > -        description:
> > > -          Chip select used by the device.
> > > -
> > > -      spi-3wire:
> > > -        $ref: /schemas/types.yaml#/definitions/flag
> > > -        description:
> > > -          The device requires 3-wire mode.
> > > -
> > > -      spi-cpha:
> > > -        $ref: /schemas/types.yaml#/definitions/flag
> > > -        description:
> > > -          The device requires shifted clock phase (CPHA) mode.
> > > -
> > > -      spi-cpol:
> > > -        $ref: /schemas/types.yaml#/definitions/flag
> > > -        description:
> > > -          The device requires inverse clock polarity (CPOL) mode.
> > > -
> > > -      spi-cs-high:
> > > -        $ref: /schemas/types.yaml#/definitions/flag
> > > -        description:
> > > -          The device requires the chip select active high.
> > > -
> > > -      spi-lsb-first:
> > > -        $ref: /schemas/types.yaml#/definitions/flag
> > > -        description:
> > > -          The device requires the LSB first mode.
> > > -
> > > -      spi-max-frequency:
> > > -        $ref: /schemas/types.yaml#/definitions/uint32
> > > -        description:
> > > -          Maximum SPI clocking speed of the device in Hz.
> > > -
> > > -      spi-rx-bus-width:
> > > -        allOf:
> > > -          - $ref: /schemas/types.yaml#/definitions/uint32
> > > -          - enum: [ 1, 2, 4, 8 ]
> > > -          - default: 1
> > > -        description:
> > > -          Bus width to the SPI bus used for MISO.
> > > -
> > > -      spi-rx-delay-us:
> > > -        description:
> > > -          Delay, in microseconds, after a read transfer.
> > > -
> > > -      spi-tx-bus-width:
> > > -        allOf:
> > > -          - $ref: /schemas/types.yaml#/definitions/uint32
> > > -          - enum: [ 1, 2, 4, 8 ]
> > > -          - default: 1
> > > -        description:
> > > -          Bus width to the SPI bus used for MOSI.
> > > -
> > > -      spi-tx-delay-us:
> > > -        description:
> > > -          Delay, in microseconds, after a write transfer.
> > > -
> >
> > I can see what you're trying to do, but you don't really need to.
> >
> > All the SPI devices will be declared under a spi controller node that
> > will validate its child nodes (and thus the devices) already.
>
> This was the missing piece - thanks.
> And as Mark put it "why is this suddenly an issue"?
> Turns out this is already properly handled and I made up an issue.
> Maybe Mark tried to explian it to me already...

Yeah, the schemas multi-layering thing is pretty difficult to get used
to :)

> >
> > Doing it this way would actually make all the checks happen twice,
> > once as part of the SPI controller, once as part of the SPI device
> > binding, without any good reason.
>
> I had focus on validating the example in the binding
> file and not the full picture.
>
> One thing I do not see properly addressed, but maybe I just miss it.
> What triggers that we catch properties that are not supposed to be
> present?
>
> If we see a unsupported property "foobar":
>
> spi {
>     ...
>     panel {
>        ....
>        foobar = <1>;
>     };
> };
>
> somewhere in a SPI slave binding we should catch this.
> If for no other reasons that it could be a simple spelling mistake
> that otherwise could go undetected for a long time.
> But maybe this is really not feasible to do?

So you have multiple things here you can do.

Like I said, the schemas are all run as some kind of layers, and each
schema must validate, so you'll want to make a schema that will
validate only what's it supposed to be validating.

Let's use your SPI panel as an example. The SPI controller schema has
a description of what a controller is supposed to look like, and the
properties that are useful to that controller in the devices (things
like the chip-select number, phase settings, etc).

However, at the controller level, you have no idea what devices are
connected, and thus you cannot limit the number of properties a child
is going to have.

The second layer that comes in is the device binding itself. Here,
you'll know what the device itself needs, but you don't really care
about the SPI controller setting itself, since you could have pretty
much each combination in various DTs.

The main property to restrict the allowed properties is
additionalProperties, and setting it to false will raise an error for
each property encountered that isn't part of the *current*
schema. This means that we can't set it for the spi controller
binding, and we would need to duplicate the list of all the generic
SPI properties in each and every binding to avoid spurious error
messages: this is not really ideal, but some (early) schemas are doing
this.

The next spec of the schema language introduces a new property though
that is unevaluatedProperties, which works pretty much like
additionalProperties, but will emit an error only if no schema defines
it. Like I said, the library implementing the schema validation logic
doesn't implement that new spec yet, but the tools allow that property
to be set (but it's ignored). It would be best to simply use
unevaluatedProperties in your panel patch, and when the tools will be
updated you'll get the behaviour you want.

Maxime

--56oevq6iibsekfv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnCSMwAKCRDj7w1vZxhR
xQpBAQCzJQpBBdk2qaPu4qnorbl8NuYMcRaciNqgdZamW5q/RwD+PBN6+gHkJfCD
qcUMZw1ZhBg+hyE3e1klr2RL+Dj9Fwo=
=0O15
-----END PGP SIGNATURE-----

--56oevq6iibsekfv4--
