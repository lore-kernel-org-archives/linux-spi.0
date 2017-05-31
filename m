From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Date: Wed, 31 May 2017 16:04:17 -0500
Message-ID: <CAL_JsqL=iapYifAhDcYSLRGyevx7RxGiUtji72NJD-uYCQnCdw@mail.gmail.com>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-8-hauke@hauke-m.de>
 <20170531200540.joludfqpy35yc5yy@rob-hp-laptop> <6b8bb1cd-c090-435d-d150-d53edf04d2df@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6b8bb1cd-c090-435d-d150-d53edf04d2df-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 31, 2017 at 3:13 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> On 05/31/2017 10:05 PM, Rob Herring wrote:
>> On Sun, May 28, 2017 at 08:39:57PM +0200, Hauke Mehrtens wrote:
>>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>
>>> This adds the initial documentation for the RCU module (a MFD device
>>> which provides USB PHYs, reset controllers and more).
>>>
>>> The RCU register range is used for multiple purposes. Mostly one device
>>> uses one or multiple register exclusively, but for some registers some
>>> bits are for one driver and some other bits are for a different driver.
>>> With this patch all accesses to the RCU registers will go through
>>> syscon.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 97 ++++++++++++++++++++++
>>>  1 file changed, 97 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>> new file mode 100644
>>> index 000000000000..3e2461262218
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>> @@ -0,0 +1,97 @@
>>> +Lantiq XWAY SoC RCU binding
>>> +===========================
>>> +
>>> +This binding describes the RCU (reset controller unit) multifunction device,
>>> +where each sub-device has it's own set of registers.
>>> +
>>> +The RCU register range is used for multiple purposes. Mostly one device
>>> +uses one or multiple register exclusively, but for some registers some
>>> +bits are for one driver and some other bits are for a different driver.
>>> +With this patch all accesses to the RCU registers will go through
>>> +syscon.
>>> +
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Required properties:
>>> +- compatible        : The first and second values must be: "simple-mfd", "syscon"
>>> +- reg               : The address and length of the system control registers
>>> +
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Example of the RCU bindings on a xRX200 SoC:
>>> +    rcu0: rcu@203000 {
>>> +            compatible = "lantiq,rcu-xrx200", "simple-mfd", "syscon";
>>> +            reg = <0x203000 0x100>;
>>> +            big-endian;
>>> +
>>> +            gphy0: gphy@0 {
>>
>> Unit address without reg address is not valid.
>>
>>> +                    compatible = "lantiq,xrx200a2x-rcu-gphy";
>>> +
>>> +                    regmap = <&rcu0>;
>>> +                    offset = <0x20>;
>>
>> Does reg not work instead?
>
> Is it ok to access some registers in this range with a reg = <0x20 0x04>
> setting and some others through syscon? This specific register is only
> used by this gphy, but the reset controller shares the register with
> some other drivers like the watchdog driver.

Yes. The main thing is you need to use reg where you have unit addresses.

For the syscon-reboot, you could also just not describe in DT and have
the reset ctrlr driver register reboot driver. DT is not the only way
to instantiate drivers.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
