From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Thu, 27 Feb 2020 11:07:48 -0600
Message-ID: <20200227170748.GA19661@bogus>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        david.oberhollenzer-S6VGOU4v5edDinCvNWH78Q@public.gmane.org, miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
        tudor.ambarus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Ramuthevar Vadivel Murugan
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200227062708.21544-2-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Feb 2020 14:27:07 +0800, "Ramuthevar,Vadivel MuruganX" wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 142 +++++++++++++++++++++
>  2 files changed, 142 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: ignoring, error in schema: patternProperties: cdns,read-delay
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: {'description': 'Delay in 4 microseconds, read capture logic, in clock cycles.'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: 'not' is a required property

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1245559
Please check and re-submit.
