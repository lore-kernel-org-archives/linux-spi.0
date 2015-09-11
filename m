From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/bcm63xx: document device tree bindings
Date: Fri, 11 Sep 2015 12:28:20 +0200
Message-ID: <CAOiHx=k=dC=Y_MAPdmOxQJYe0th87k0+NAeH-1cBTN3rZTLsGQ@mail.gmail.com>
References: <1441898975-22540-1-git-send-email-jogo@openwrt.org>
 <1441898975-22540-2-git-send-email-jogo@openwrt.org> <55F1D754.9000101@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55F1D754.9000101-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 10, 2015 at 9:17 PM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> On 10/09/15 08:29, Jonas Gorski wrote:
>> Add documentation for the bindings of the low speed SPI controller found
>> on most bcm63xx SoCs.
>>
>> Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/spi/spi-bcm63xx.txt        | 33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
>> new file mode 100644
>> index 0000000..1a60bb9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
>> @@ -0,0 +1,33 @@
>> +Binding for Broadcom BCM6348/BCM6358 SPI controller
>> +
>> +Required properties:
>> +- compatible: must contain one of "brcm,bcm6348-spi", "brcm,bcm6458-spi".
>
> Typo, the second compatible should "brcm,bcm6358-spi", other than that:

Oops, will fix that in v2.

>
> Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Jonas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
