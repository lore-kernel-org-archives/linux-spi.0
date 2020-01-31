From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date: Fri, 31 Jan 2020 08:12:03 -0600
Message-ID: <CAL_JsqLO4DT1s-q_5n23pLJw7PgnVNC6W3aAwkLFB_QdtV721w@mail.gmail.com>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz> <20200131023433.12133-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200131023433.12133-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 30, 2020 at 8:34 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v3:
>     - make dt_binding_check clean (properly this time)
>
>     Changes in v2:
>     - update license
>     - make dt_binding_check clean
>
>  .../devicetree/bindings/spi/spi-mux.yaml      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
