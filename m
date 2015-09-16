From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation
 for bcm2835-aux
Date: Tue, 15 Sep 2015 21:12:18 -0700
Message-ID: <55F8EC22.7020909@wwwdotorg.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
 <55DD1A13.7010705@wwwdotorg.org>
 <9D45476C-88E2-4F76-AB55-9D0C7194E29C@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9D45476C-88E2-4F76-AB55-9D0C7194E29C-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/04/2015 01:26 AM, Martin Sperl wrote:
> 
>> On 26.08.2015, at 03:44, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> On 08/24/2015 02:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>
>>> +Example:
>>> +
>>> +aux_enable: aux_enable@0x7e215004 {
>>> +	compatible = "bcrm,bcm2835-aux";
>>> +	reg = <0x7e215004 0x04>;
>>
>> I'd expect that to be <0x7e215000 0x8>;
> 
> The reason is that we just handle enable with this driver,
> which just requires access to the 0x7e215004 register.
> 
> The 0x7e215000 register (interrupt mask) could be used by a
> cascaded interrupt-controller, but as the spi and uart drivers
> can run with shared interrupts this is not a necessity.

The DT is supposed to describe the HW, not any particular SW's use of
the HW. If the HW block has 2 registers, so must the DT reg property.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
