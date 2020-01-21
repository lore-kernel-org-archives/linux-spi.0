From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add dt-bindings schema for Cadence XSPI
 controller driver
Date: Tue, 21 Jan 2020 12:01:58 -0600
Message-ID: <20200121180158.GA2461@bogus>
References: <20200120125443.9523-1-konrad@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Konrad Kociolek <konrad@cadence.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200120125443.9523-1-konrad@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 20 Jan 2020 13:54:31 +0100, Konrad Kociolek wrote:
> Add dt-bindings documentation for Cadence XSPI controller to support
> SPI based flash memories.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/spi/cdns,xspi.yaml: $id: path/filename 'spi/cadence,xspi.yaml' doesn't match actual filename
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/spi/cdns,xspi.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/spi/cdns,xspi.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1225933
Please check and re-submit.
