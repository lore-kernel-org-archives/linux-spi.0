From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Wed, 15 Jul 2015 11:45:07 +0200
Message-ID: <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
 <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com> <20150604171547.GA1530@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	"linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dan Williams <dan.j.williams@i
To: Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150604171547.GA1530-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 4 June 2015 at 19:15, Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jun 04, 2015 at 10:31:45AM +0200, Michal Suchanek wrote:
>> You might want to try to run the bus at 60MHz or 80MHz and then the
>> values would probably again be different.
>>
>> The first two values are set in DT so the logical place for setting
>> the third is also in DT.
>>
>> Otherwise you would need some in-kernel table of these settings.
>
> Or a formula.
>

This formula probably needs to take into account

 - the unknown reason for the pl330 to fail transfer
 - the device transfer speed and transfer phase as set in DT
 - possibly device-specific latency and board-specific trace design
and assembly tolerances

Seriously, until I have at least a vague idea why the transfer fails I
am not comfortable pulling some formula out of thin air and pretending
I have a working patch.

On the other hand, a parameter you can set in the DT and which comes
with a suggested value which can be tuned depending on the system
seems more viable.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
