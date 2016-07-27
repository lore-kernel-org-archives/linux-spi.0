From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Wed, 27 Jul 2016 11:25:10 -0700
Message-ID: <5798FC86.8040601@caviumnetworks.com>
References: <cover.1469174814.git.jglauber@cavium.com> <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com> <20160724210452.GB6345@sirena.org.uk> <20160725155122.GA2710@hardcore> <20160725161632.GD11806@sirena.org.uk> <57963ED3.4090402@caviumnetworks.com> <20160727181205.GT11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160727181205.GT11806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/27/2016 11:12 AM, Mark Brown wrote:
> On Mon, Jul 25, 2016 at 09:31:15AM -0700, David Daney wrote:
>> On 07/25/2016 09:16 AM, Mark Brown wrote:
>
>>> The usual pattern would be something like (ARCH_THUNDER || COMPILE_TEST)
>>> && PCI && 64BIT (so that people on other platforms where the device will
>>> never actually appear don't get bothered by the prompt).
>
>> ARCH_THUNDER needs to die, so perhaps it should be (ARM64 || COMPILE_TEST)
>> && PCI && 64BIT if you really want to hide it from non-arm64 kernel configs.
>
> It does?  Why?

It adds clutter.  If we build a generic kernel, we first must select all 
the ARCH_*, then go back and select the devices we want.  Not much of a 
value add.

Better to just directly select the devices and remove this middle ARCH_* 
layer.

Also who is responsible for making sure the proper ARCH_* constraints 
are maintained?  If we remove ARCH_THUNDER, no need to worry about this.


>  One of the functions of the vendor specific Kconfig
> options is to improve UX when configuring the kernel, if you're building
> for a particular SoC or set of SoCs then we can avoid showing you
> drivers that can never possibly appear in your system which makes life
> a bit easier.  We shouldn't be using them in the code itself but they do
> help people in Kconfig.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
