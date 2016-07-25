From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Mon, 25 Jul 2016 09:31:15 -0700
Message-ID: <57963ED3.4090402@caviumnetworks.com>
References: <cover.1469174814.git.jglauber@cavium.com> <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com> <20160724210452.GB6345@sirena.org.uk> <20160725155122.GA2710@hardcore> <20160725161632.GD11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160725161632.GD11806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/25/2016 09:16 AM, Mark Brown wrote:
> On Mon, Jul 25, 2016 at 05:51:22PM +0200, Jan Glauber wrote:
>> On Sun, Jul 24, 2016 at 10:04:52PM +0100, Mark Brown wrote:
>>> On Sat, Jul 23, 2016 at 12:42:55PM +0200, Jan Glauber wrote:
>
>>>> +	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC
>
>>> This is a *weird* and most likely broken set of dependencies - why
>>> exclude this if we're on Octeon (or Octeon happens to have been enabled
>>> in a config)?
>
>> I agree that it looks weird, the reasoning is that we would like
>> to avoid making the driver depend on something like ARCH_THUNDER.
>
> Why?
>
>> So I made the driver depend on the things it actually uses
>> (PCI for probing and 64BIT because of readq/writeq) and don't care if it
>> compiles on other platforms too (like x86).
>
> The usual pattern would be something like (ARCH_THUNDER || COMPILE_TEST)
> && PCI && 64BIT (so that people on other platforms where the device will
> never actually appear don't get bothered by the prompt).

ARCH_THUNDER needs to die, so perhaps it should be (ARM64 || 
COMPILE_TEST) && PCI && 64BIT if you really want to hide it from 
non-arm64 kernel configs.


>
>> That said, I can remove the !CAVIUM_OCTEON_SOC, it compiles without
>> errors on MIPS too. Would that be ok?
>
> Sure.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
