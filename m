From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 09/13] MIPS: lantiq: Add a GPHY driver which uses the RCU
 syscon-mfd
Date: Tue, 25 Apr 2017 09:05:03 +0200
Message-ID: <29b6b2c0-091e-b2c2-7d14-d8f7b2c458a1@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-10-hauke@hauke-m.de>
 <20170420152754.3tkjxjvoiuatbvpo@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170420152754.3tkjxjvoiuatbvpo@rob-hp-laptop>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On 04/20/2017 05:27 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:38PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> Compared to the old xrx200_phy_fw driver the new version has multiple
>> enhancements. The name of the firmware files does not have to be added
>> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
>> instead. Each GPHY can now also boot separate firmware (thus mixing of
>> GE and FE GPHYs is now possible).
>> The new implementation is based on the RCU syscon-mfd and uses the
>> reeset_controller framework instead of raw RCU register reads/writes.
>>
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |   4 +-
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++++++++++
>>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>>  5 files changed, 314 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>>  create mode 100644 drivers/soc/lantiq/gphy.c
>>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>> new file mode 100644
>> index 000000000000..d525c7ce9f0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>> @@ -0,0 +1,54 @@
>> +Lantiq XWAY SoC GPHY binding
>> +============================
>> +
>> +This binding describes a software-defined ethernet PHY, provided by the RCU
>> +module on newer Lantiq XWAY SoCs (xRX200 and newer).
>> +This depends on binary firmware blobs which must be provided by userspace.
> 
> Where the blobs come from is not relevant. 
> 
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (controller (parent) node):
>> +- compatible		: Should be one of
>> +				"lantiq,xrx200a1x-rcu-gphy"
>> +				"lantiq,xrx200a2x-rcu-gphy"
>> +				"lantiq,xrx300-rcu-gphy"
>> +				"lantiq,xrx330-rcu-gphy"
>> +- lantiq,rcu-syscon	: A phandle and offset to the GPHY address registers in
>> +			  the RCU
>> +- resets		: Must reference the RCU GPHY reset bit
>> +- reset-names		: One entry, value must be "gphy" or optional "gphy2"
>> +
>> +Optional properties (port (child) node):
>> +- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
>> +			  <dt-bindings/mips/lantiq_xway_gphy.h>
>> +- clocks		: A reference to the (PMU) GPHY clock gate
>> +- clock-names		: If clocks is given then this must be "gphy"
> 
> Kind of pointless to have a name for a single clock.

The documentation misses the 2. clock. ;-) Will add it.
> 
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the GPHys on the xRX200 SoCs:
>> +
>> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
>> +	gphy0: rcu_gphy@0 {
> 
> Use generic node names: phy@...

I will change this

> 
>> +		compatible = "lantiq,xrx200a2x-rcu-gphy";
>> +		reg = <0>;
>> +
>> +		lantiq,rcu-syscon = <&rcu0 0x20>;
> 
> Could the phy just be a child of the rcu? Then you don't need a phandle 
> here and 0x20 becomes the reg address.

The RCU is a register block which does many things. This register is
specific to this ghpy, but there are some register in the RCU block
which are shared between multiple drivers. Can I support both, provide
some parts of this block as syscon and some as direct register blocks?

> 
>> +		resets = <&rcu_reset0 31>, <&rcu_reset1 7>;
>> +		reset-names = "gphy", "gphy2";
>> +		lantiq,gphy-mode = <GPHY_MODE_GE>;
>> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
>> +		clock-names = "gphy";
>> +	};
>> +
>> +	gphy1: rcu_gphy@1 {
>> +		compatible = "lantiq,xrx200a2x-rcu-gphy";
>> +		reg = <0>;
>> +
>> +		lantiq,rcu-syscon = <&rcu0 0x68>;
>> +		resets = <&rcu_reset0 29>, <&rcu_reset1 6>;
>> +		reset-names = "gphy", "gphy2";
>> +		lantiq,gphy-mode = <GPHY_MODE_FE>;
>> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
>> +		clock-names = "gphy";
>> +	};
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
