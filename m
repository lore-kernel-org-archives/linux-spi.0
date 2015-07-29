From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to controller-data
Date: Wed, 29 Jul 2015 18:19:24 +0200
Message-ID: <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com> <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
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
In-Reply-To: <20150729140046.GB11082-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29 July 2015 at 16:00, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jul 29, 2015 at 12:19:57PM +0200, Michal Suchanek wrote:
>
> Please use subject lines matching the style for the subsytsem so people
> can spot that the patch is in some way relevant.
>
>> The controller-data subnode has no compatible. This can lead to other
>> drivers getting confused by it. Add a compatible to make devicetreee
>> unambiguous.
>
> I can't tell from this commit message what the issue you're trying to
> fix is, sorry.  Nodes without compatible strings are entirely normal and
> don't need compatible strings.  It sounds like a bug in whatever other
> driver is becoming confused.

The driver that gets confused is ofpart.

The two-line patch to allow it to just ignore controller-data has been
rejected on the basis that s3c64xx should use a compatible string
because ofpart monopolizes all nodes without compatible which are
children of a mtd device. Devicetrees containing such nodes that are
not partitions are presumably invalid and should be rejected when
ofpart is compiled into the kernel.

>
>> +     if (!of_get_property(data_np, "compatible", NULL) ||
>> +         strcmp(of_get_property(data_np, "compatible", NULL),
>> +                "samsung,s3c-controller-data"))
>> +             dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");
>
> This will break all existing users which is not acceptable for
> mainline, we need to preserve compatibility with existing device trees.

It will not break anything. It will just spam dmesg.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
