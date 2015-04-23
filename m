From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as "spidev"
Date: Thu, 23 Apr 2015 15:21:26 +0200
Message-ID: <5538F1D6.7020503@martin.sperl.org>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org> <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org> <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com> <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw@mail.gmail.com> <20150423103652.GT22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150423103652.GT22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 2015-04-23 12:36, Mark Brown wrote:
> On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wrote:
>
>> I guess this has been suggested before: the spi core could provide spidev
>> access to all spi client devices which are not bound by a driver?
>
> I don't know if it's been suggested before, certainly nobody did the
> work to make it happen.  I don't think I have a massive objection in
> principal.
>

Maybe until that is fixed keep the warning message but remove the
WARN_ON(...), which is responsible for the 50+ lines in dmesg which
looks like a major issue because of the full stack-trace produced
and not just a "simple" warning...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
