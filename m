From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 6/8] arm: dts: Add bcm-nsp and bcm958625k support
Date: Tue, 2 Aug 2016 15:51:17 -0400
Message-ID: <CAC=U0a2wmmo19WfFWPm1YRAT8QVt8OKg5KzSzVhgP6uyydHi9A@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-7-git-send-email-kdasu.kdev@gmail.com> <CAOiHx=n8a64d-2LGGFHuyBQBg3Cz=ALVXEbvPRHxTyzFjWRMXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	vigneshr-l0cyMroinI0@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOiHx=n8a64d-2LGGFHuyBQBg3Cz=ALVXEbvPRHxTyzFjWRMXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Jonas,

"You remove the rng node, is this intentional?"

Not intentional,  was a bad rebase merge to the latest sources, will
fix this in next version of the patch.

"The address is 0xa0000 so this should be partition@a0000.
 etc."

Will fix this as well.

Thanks
Kamal

On Mon, Aug 1, 2016 at 11:09 AM, Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On 30 July 2016 at 00:13, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Adding qspi node compatible with the new spi-bcm-qspi
>> driver for the broadcom's northstar SoC.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/bcm-nsp.dtsi   | 33 +++++++++++++++++++++++++++++----
>>  arch/arm/boot/dts/bcm958625k.dts | 34 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
>> index 6a40ed7..26c863e 100644
>> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
>> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
>> @@ -160,7 +160,7 @@
>>
>>         axi {
>>                 compatible = "simple-bus";
>> -               ranges = <0x00000000 0x18000000 0x0011ba08>;
>> +               ranges = <0x00000000 0x18000000 0x0011c40a>;
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>
>> @@ -206,9 +206,34 @@
>>                         brcm,nand-has-wp;
>>                 };
>>
>> -               rng: rng@33000 {
>> -                       compatible = "brcm,bcm-nsp-rng";
>> -                       reg = <0x33000 0x14>;
>
> You remove the rng node, is this intentional?
>
>> +               qspi: qspi@27200 {
>> +                       compatible = "brcm,spi-bcm-qspi";
>> +                       reg = <0x027200 0x184>,
>> +                             <0x027000 0x124>,
>> +                             <0x11c408 0x004>,
>> +                             <0x0273a0 0x01c>;
>> +                       reg-names = "mspi", "bspi", "intr_regs",
>> +                                   "intr_status_reg";
>> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "spi_lr_fullness_reached",
>> +                                         "spi_lr_session_aborted",
>> +                                         "spi_lr_impatient",
>> +                                         "spi_lr_session_done",
>> +                                         "spi_lr_overhead",
>> +                                         "mspi_done",
>> +                                         "mspi_halted";
>> +                       clocks = <&iprocmed>;
>> +                       clock-names = "iprocmed";
>> +                       clock-frequency = <12500000>;
>> +                       num-cs = <2>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>>                 };
>>
>>                 ccbtimer0: timer@34000 {
>> diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
>> index 2d84226..ab7ba8f 100644
>> --- a/arch/arm/boot/dts/bcm958625k.dts
>> +++ b/arch/arm/boot/dts/bcm958625k.dts
>> @@ -126,3 +126,37 @@
>>                 groups = "nand_grp";
>>         };
>>  };
>> +
>> +&qspi {
>> +       bspi-sel = <0>;
>> +       flash: m25p80@0 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               compatible = "m25p80";
>> +               reg = <0x0>;
>> +               spi-max-frequency = <12500000>;
>> +               m25p,fast-read;
>> +               spi-cpol;
>> +               spi-cpha;
>> +
>> +               partition@0 {
>> +                       label = "boot";
>> +                       reg = <0x00000000 0x000a0000>;
>> +               };
>
> these should be enclosed by a partitions node with compatible
> "fixed-partitions", see
> Documentation/devicetree/bindings/mtd/partition.txt.
>
>> +
>> +               partition@1 {
>
> The address is 0xa0000 so this should be partition@a0000.
>
>> +                       label = "env";
>> +                       reg = <0x000a0000 0x00060000>;
>> +               };
>> +
>> +               partition@2 {
>
> likewise.
>
>> +                       label = "system";
>> +                       reg = <0x00100000 0x00600000>;
>> +               };
>> +
>> +               partition@3 {
>
> etc.
>
>> +                       label = "rootfs";
>> +                       reg = <0x00700000 0x01900000>;
>> +               };
>> +       };
>> +};
>
>
> Regards
> Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
