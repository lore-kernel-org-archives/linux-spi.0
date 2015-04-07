From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: bcm53xx: Refactor to make driver nonspecific to
 53xx SoCs
Date: Tue, 7 Apr 2015 11:03:09 +0300
Message-ID: <CAHp75Vf3Fyw-ZgcgsCki6_TvqMh9A3+dmeRLq42pcTj7YAieQQ@mail.gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
	<1428002603-21892-3-git-send-email-jonathar@broadcom.com>
	<CAHp75Vf0JrB5pqNEouLzyOf5mmi05Ut_cybd37suTrLbJOFHKA@mail.gmail.com>
	<5522D0BA.2050805@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5522D0BA.2050805-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 6, 2015 at 9:30 PM, Jonathan Richardson
<jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> On 15-04-03 06:35 AM, Andy Shevchenko wrote:
>> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
>> <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>>> The Broadcom MSPI controller is used on various SoCs. It is being
>>> renamed so that it can be extended and reused on other chips. It is
>>> renamed to bcm-mspi.
>>>
>> What if you resend this one with -M -C applied?
>>
>>
>
> I'm not seeing any difference in the patches unfortunately. I'll keep
> playing with it and re-send if I can find a way to improve it.
>
> The changes are just renaming variables, structures, functions, file
> name to get rid of 53xx and replace with mspi. The config is renamed
> from SPI_BCM53XX to SPI_BCMA_MSPI.
>

Better to split: a) moving, b) renaming something inside.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
