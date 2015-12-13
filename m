From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: dts: sun4i: Add support for inter-word wait
 cycles using the SPI Wait Clock Register
Date: Sun, 13 Dec 2015 22:52:12 +0100
Message-ID: <CAGNoLaMe1wmo5cz1D0LXVc2uTatG+t4LEeipHJEmozByg_OwRw@mail.gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
	<20151213210719.GC19456@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151213210719.GC19456@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-12-13 22:07 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
[...]
>> There is one review comment that I didn't address: Rob Herring suggested
>> that this should be in the core-binding rather than in sun4i. I checked
>> many of the hardware manuals of other SPI drivers and it looks to me like
>> this hardware based inter-word delay is a feature that not many SPI
>> controllers offer. And the SPI core currently has no way to control an
>> inter-word delay, only inter-message. So I would like to propose this again
>> as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
>> feature.
>
> Only a few of them justify to have this in the framework. There's a
> bunch of controllers that support such a feature, and it definitely
> belongs in the core.
>
> The point of the framework is not to be the least common denominator,
> it's about having as much code in common as possible, and it
> definitely falls into that category.

Ok, now I understand. I did indeed think that the SPI core is more
like a least common denominator. So I will add the property to the
spi-core binding, as initially requested by Rob and send a v3.

Thanks for the review, Maxime!

Marcus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
