From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Sun, 07 Sep 2014 22:14:16 +1000
Message-ID: <540C4C18.5030903@uclinux.org>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org> <CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com> <5409057A.6090900@uclinux.org> <CAMuHMdWf6_yBhpNgK=wJcQqzLNJvTnC95SrqrcZyRH+jGL93vA@mail.gmail.com> <5409B68A.7010604@uclinux.org> <20140906120600.GA11500@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140906120600.GA11500-nAQHv47ARr+vIlHkl8J1cg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ezequiel,

On 06/09/14 22:06, Ezequiel Garcia wrote:
> Hi Greg,
>
> (Ccing mvebu guys, full discussion here: http://www.spinics.net/lists/devicetree/msg47806.html)
>
> On 05 Sep 11:11 PM, Greg Ungerer wrote:
>> On 05/09/14 17:36, Geert Uytterhoeven wrote:
>>> No, the other way around (from most-specific to least-specific):
>>>
>>>      compatible = "marvell,armada-spi", "marvell,orion-spi"
>>>
>>> So the Armada version is used if available, and the Orion version
>>> is used as a fallback.
> Since you are doing another spin, please split this in two patches.
> The driver and devicetree binding documentation should be in one patch,
> and the devicetree .dtsi change in another patch.
>
> By following Geert's request about the compatible, you make sure both
> patches can be merged through different maintainers, and that an old devicetree
> blob can be used safely.

Sure, yes, I would prefer that too. I didn't do it for this because 
checkpatch
complained for the spi-orion.c change in its own:

WARNING: DT compatible string "marvell,armada-spi" appears un-documented 
-- check ./Documentation/devicetree/bindings/
#170: FILE: drivers/spi/spi-orion.c:412:
+    { .compatible = "marvell,armada-spi", .data = &armada_spi_dev_data, },

But I am happy to ignore that :-)


>>>   Also what about armada370-xp, armada375, armada380
>>> and any other variants out there?
>> I don't know. I don't have access to functional specs for anything
>> other than the 370. I expect they are probably the same though.
>> (Can anyone confirm?)
>>
> Confirmed. Judging from the specs, seems the same SPI IP is on all the
> Armada SoCs; you can do the 'armada-spi' compatible addition on 375 and 38x.
>
> Did a few tests on the AXP-GP board (which has an SPI flash) using
> 'orion-spi' and 'armada-spi' compatibles.
>
> Tested-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks, appreciate that.


> I haven't been able to spot any speed difference, though (perhaps my
> test is too limited?), so I wonder if there's any improvement with this
> patch?

Try setting a speed like 2MHz for an SPI device. It will fail because that
is below the minimum divisor it can calculate with the old orion style
behavior. I have an armada 370 based board with an ethernet switch
that is controlled by SPI. Its typical SPI bus speed is 2MHz, that is how I
came up against this.

Regards
Greg

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
