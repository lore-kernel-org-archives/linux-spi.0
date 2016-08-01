From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Mon, 1 Aug 2016 12:02:54 -0700
Message-ID: <579F9CDE.5050207@caviumnetworks.com>
References: <20160728083144.16625-1-jglauber@cavium.com> <20160728083144.16625-3-jglauber@cavium.com> <20160801172838.GW10376@sirena.org.uk> <579F958F.9020508@caviumnetworks.com> <20160801184931.GB10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160801184931.GB10376-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/01/2016 11:49 AM, Mark Brown wrote:
> On Mon, Aug 01, 2016 at 11:31:43AM -0700, David Daney wrote:
>> On 08/01/2016 10:28 AM, Mark Brown wrote:
>>> On Thu, Jul 28, 2016 at 10:31:44AM +0200, Jan Glauber wrote:
>
>>>> +	p->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(p->clk))
>>>> +		goto out_unmap;
>
>>> We're now just using the normal clock API which is good but I'm now
>>> unclear what is going to ensure that the clock is there - is there some
>>> other change elsewhere that I'm not aware of?
>
>> The clock is an integral part of the SoC and is always running, so it will
>> always be there.  All we want to know is the frequency, which is supplied by
>> the device tree clock-bindings framework
>
> So there's something there that registers the clock?

Yes, when using OF device tree, standard device probing registers the clock.

> What is that thing on ACPI systems?

I don't know if it works ACPI, or if ACPI even has support for the clock 
framework.  But does it matter?  We are not currently using ACPI on 
systems where this driver is used.

In the future, if we ever need ACPI support, we will add support for it.

David.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
