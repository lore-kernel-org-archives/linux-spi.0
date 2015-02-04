From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: only include mach/dma.h for legacy DMA
Date: Wed, 4 Feb 2015 06:58:52 -0600
Message-ID: <CAL_JsqLWVk_QA4ag61S3CTr-RhqcNs-kf=bs+MAsmaRjCCUyTA@mail.gmail.com>
References: <1423004615-16085-1-git-send-email-robh@kernel.org> <20150204103027.GS21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150204103027.GS21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 4, 2015 at 4:30 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Feb 03, 2015 at 05:03:35PM -0600, Rob Herring wrote:
>
>> Move the include of mach/dma.h to the legacy PXA DMA code where it is used.
>> This enables building spi-pxa2xx on ARM64.
>
> If this enables the building of spi-pxa2xx on ARMv8 I'd expect to see a
> Kconfig change as well, we're not getting build failures at the minute?

Sorry, I should have said it is in preparation to enable/add ARCH_MMP
on ARM64 for PXA1928.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
