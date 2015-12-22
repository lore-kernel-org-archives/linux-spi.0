From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Tue, 22 Dec 2015 10:51:50 +0100
Message-ID: <CACRpkdYapF8br=c3utUmMbmPxyHwxZuT5pC8N-pySPY7dtEwng@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
	<1449863184-29668-2-git-send-email-afd@ti.com>
	<CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
	<566EF12C.4060509@ti.com>
	<CAL_Jsq+kYSJQd003RhYTeVFv6xLaSCxzZK7wnF2LVs502sWu4g@mail.gmail.com>
	<566F4E9B.8090202@ti.com>
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
In-Reply-To: <566F4E9B.8090202-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 15, 2015 at 12:19 AM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
> [Rob]
>> I agree the generic version is fine (or find who made the first part
>> ;)). What "pisosr" is is not very obvious though. Having 74165 in the
>> compatible would make it somewhat more obvious it is a standard logic
>> part.
>>
>
> A quick search shows shift-registers being made from vacuum tubes for
> the Colossus! Those might work with this driver if you could match the
> voltage to an SPI bus... :)
>
> I agree about the name not being very good, but I'm not sure about
> 74165 ether as it is also just a single part number.

We can add many compatible strings so it's not an issue.
"ti,74165" works for me as TI invented the 74xx series.

> The idea was to
> have a non-part number compatible string for any shift-register you
> can hook to the SPI line.

Again, one does not exclude the other. I'm happy with a generic
compatible *and* "ti,74165".

> That way when we have boards with a sn65x882
> or something we wont have to call it a 74165. But I guess that's why
> it's a "compatible:" string, and not "is-a:" string.

Compatible ranges from the specific to the more generic
so compatible = "ti,74165", "pisosr"; is just fine. Something
will match if there is a suitable driver. The OS may choose to
provide something part-specific or something more generic.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
