From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date: Mon, 27 Jan 2020 07:56:11 -0600
Message-ID: <CAL_JsqJHYwH28jkg4h0GivOz=GywxFkGpxLywt9HEqKy3pdVRQ@mail.gmail.com>
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
 <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
 <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com> <651803fbdea412ecde7cd352b080d41d9f0a2a33.camel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <651803fbdea412ecde7cd352b080d41d9f0a2a33.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jan 26, 2020 at 2:24 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> On Thu, 2020-01-23 at 07:51 -0600, Rob Herring wrote:
> > On Wed, Jan 22, 2020 at 7:24 PM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > Add binding documentation for the spi-mux driver. This allows a generic
> > > multiplexer to be used to provide access to multiple SPI devices.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >
> > > Notes:
> > >     Changes in v2:
> > >     - update license
> > >     - make dt_binding_check clean
> >
> > Sure about that?
> >
>
> I was when I wrote that, but now I think I need to consult my spell
> book.
>
> It appears the incantation I should be using is
>
>   make ARCH=arm defconfig
>   make ARCH=arm dt_binding_check \
>      DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-mux.yaml

Note that you need to run this also without DT_SCHEMA_FILES set so the
example is checked against all schema. With that, the 'spi' node is
going to need #address-cells and #size-cells.

>
> I can see the simple failures (not sure how I missed them). But one
> that remains is:
>
> Warning (spi_bus_bridge): /example-0/spi/spi-mux@0: node name for SPI
> buses should be 'spi'
>
> I could fix that by having
>
>  spi {
>     spi@0 {
>        compatible = "spi-mux";
>     };
>  };
>
> Is that what we want? Or should I be adding awareness of spi-muxes to
> dtc?

We should probably relax dtc, but for now I'd just use 'spi'.

Rob
