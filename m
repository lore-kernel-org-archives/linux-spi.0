From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 14:57:47 -0300
Message-ID: <564A191B.3040004@osg.samsung.com>
References: <56104E88.3040807@gmail.com> <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com> <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com> <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com> <564A101F.9090807@osg.samsung.com>
 <20151116174942.GG31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151116174942.GG31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On 11/16/2015 02:49 PM, Mark Brown wrote:
> On Mon, Nov 16, 2015 at 02:19:27PM -0300, Javier Martinez Canillas wrote:
>> On 11/13/2015 08:48 PM, Brian Norris wrote:
> 
>>> (I believe I avoided this in the first place for mostly-aesthetic
>>> reasons; technically this allows people to put garbage in their DT, like
>>> "garbage,spi-nor". It's unclear whether "garbage" becomes part of the
>>> mythical DT ABI [1].)
> 
>> I don't believe your examples are part of the mythical DT ABI. What I
>> understand is that an ABI is whatever is documented in the DT binding
>> docs but the only document that mentions the m25p80 is:
> 
>> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> 
> Not really, in practice an ABI is something that people notice breaking.
> This means that if enough people ship an undocumented ABI (or it goes
> into important enough products) it's just as good as something that's
> documented, perhaps better than something that's documented and nobody
> ever uses as an ABI.
> 

I see, fair enough. Let's see what Brian say about the spi-nor case and
I'll also post my RFC patch but as a proper patch and adding the comments
you asked me later today.

It would be unfortunate if the SPI drivers would have as a requirement to
always have an SPI device ID table even for OF-only IPs but I don't think
that is that bad either.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
