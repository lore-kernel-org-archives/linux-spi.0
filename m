From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to controller-data
Date: Thu, 30 Jul 2015 10:24:37 +0200
Message-ID: <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com> <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk> <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk> <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
 <20150729184043.GL11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Padmavathi Venna <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150729184043.GL11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29 July 2015 at 20:40, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jul 29, 2015 at 08:21:34PM +0200, Michal Suchanek wrote:
>> On 29 July 2015 at 19:16, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> >> It will not break anything. It will just spam dmesg.
>
>> > I'm confused - if all this change does is to spam dmesg then what's the
>> > point?
>
>> Presumably when your SPI NOR flash fails to probe this message will be
>> just above and you will look into the binding doc and add the
>> compatible.
>
> If you're looking to add a warning message when the flash device fails
> to probe then add that in the flash driver when it detects an error,
> this will cause needless noise for everyone else using this controller
> purely to work around the broken binding.

Technically nobody needs to see the warning with in-tree boards since
the dts can be amended with the compatible.

There is no error in flash device driver.

There is only error parsing partition scheme. In my opinion this
should never cause an error. With disk drives failure to parse
partition table results in unpartitioned disk. As there are number of
partitioning schemes failure to parse one still does not prevent other
in succeding.

>
> And like I say compatible really seems like it isn't an appropriate
> property here.

So to sum up the discussion adding compatible to s3c64xx
controller-data is not desirable and making ofpart more robust is
desirable.

I think the suggestion to use a subnode for ofpart gives the most
robust solution.

Even adding compatibles to the partition subnodes ofpart still
monopolizes the address and cells property of the mtd node which does
not pass the 'if another driver did the same would it work together?'
test.

So my suggestion is to

1) search of ofpart subnode in mtd node. If present read address and
reg from it and search partitions as subnodes of the ofpart node. In
this case unknown nodes can cause error.

2) failing that issue a warning and try to parse ofpart partitions
from the mtd node itself. In this case unknown nodes cannot cause
error for compatibility with other drivers including the already
exisitn s3c64xx controller-data node.

The parser code can be the same for both cases and only operate on
different node with a flag to reject unknown subnodes or not.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
