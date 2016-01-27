From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Wed, 27 Jan 2016 14:57:32 +0100
Message-ID: <CACRpkdaCp1xSXK+ibRZzQCsFLTnGySDCHVFjVuKNSOgWadZ4gg@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
	<1449863184-29668-2-git-send-email-afd@ti.com>
	<CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
	<566EF12C.4060509@ti.com>
	<CAL_Jsq+kYSJQd003RhYTeVFv6xLaSCxzZK7wnF2LVs502sWu4g@mail.gmail.com>
	<566F4E9B.8090202@ti.com>
	<CACRpkdYapF8br=c3utUmMbmPxyHwxZuT5pC8N-pySPY7dtEwng@mail.gmail.com>
	<56840ED0.6070205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56840ED0.6070205-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 30, 2015 at 6:05 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
> [Me]
>> Compatible ranges from the specific to the more generic
>> so compatible = "ti,74165", "pisosr"; is just fine. Something
>> will match if there is a suitable driver. The OS may choose to
>> provide something part-specific or something more generic.
>>
>
> And so we won't need to have "ti,74165" in the driver itself,
> if we just have "pisosr", then dts files can use what ever they
> like to correctly identify the part then fall back to pisosr.
>
> compatible = "company,random_numbers_of_exact_part_actually_on_board",
> "pisosr";

Exactly. Sorry for slow replies.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
