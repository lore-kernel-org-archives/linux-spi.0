From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 05/16] watchdog: lantiq: add device tree binding
 documentation
Date: Wed, 31 May 2017 22:11:04 +0200
Message-ID: <036b0b9c-a6dd-7d11-70a9-f7e8d4eb36be@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-6-hauke@hauke-m.de>
 <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/31/2017 10:00 PM, Rob Herring wrote:
> On Sun, May 28, 2017 at 08:39:55PM +0200, Hauke Mehrtens wrote:
>> The binding was not documented before, add the documentation now.
>>
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> ---
>>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> new file mode 100644
>> index 000000000000..675c30e23b65
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> @@ -0,0 +1,28 @@
>> +Lantiq WTD watchdog binding
>> +============================
>> +
>> +This describes the binding of the Lantiq watchdog driver.
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible		: Should be one of
>> +				"lantiq,wdt"
>> +				"lantiq,wdt-xrx100"
>> +				"lantiq,wdt-falcon"
>> +
>> +Optional properties:
>> +- regmap		: A phandle to the RCU syscon
>> +- offset-status		: Offset of the reset cause register
>> +- mask-status		: Mask of the reset cause register value
> 
> These 2 should be implied by the compatible. But if already used in 
> upstream dts files, then it's okay.

This is new.
Should I hard code the offsets of the register and the actual bits
depending on the compatible string in the driver instead of configuring
it in the device tree?

>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the watchdog on the xRX200 SoCs:
>> +		watchdog@803F0 {
> 
> Lowercase hex please.
> 
>> +			compatible = "lantiq,wdt-xrx200", "lantiq,wdt-xrx100";
> 
> Doesn't match the documentation.
> 
>> +			reg = <0x803F0 0x10>;
> 
> Lowercase hex please.
> 
>> +
>> +			regmap = <&rcu0>;
>> +			offset-status = <0x14>;
>> +			mask-status = <0x80000000>;
>> +		};
>> -- 
>> 2.11.0
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
