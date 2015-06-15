From: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Mon, 15 Jun 2015 19:47:37 +0200
Message-ID: <CA+rthh8WEzdY0vxV-oQ7xTUCtqbhJkTUeym9VNPU+Xm6a7T=YA@mail.gmail.com>
References: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
	<20150615095344.GE18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150615095344.GE18309-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 15 June 2015 at 11:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Jun 13, 2015 at 02:22:14PM +0200, Mathias Krause wrote:
>> Constify the ACPI device ID array, it doesn't need to be writable at
>> runtime.
>
> Applied, please do make an effort to CC relevant people working on the
> code when contributing patches (I'm not seeing any of the people working
> on the Intel platforms here and I'm at a bit of a loss why Rafael and
> Len are in the CCs).

I used the list of people that are mentioned in the MAINTAINERS file:

PXA2xx/PXA3xx SUPPORT
M:  Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
M:  Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
M:  Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
...
F:  drivers/spi/spi-pxa2xx*

Was that wrong? Who else should I've send the patch to? Maybe they
should be added to the MAINTAINERS file?

Rafael and Len are on Cc because of [1] -- an effort to constify all
users of struct acpi_device_id. They're on Cc because of the ACPI
relation. I hope that clears it up.

I was uncertain how to group those changes but tried to split them up
per-system. So you're seeing only the patches where you are mentioned
as a maintainer. I thought it would be less noise this way for the
non-ACPI related patches. It's a simple patch, after all.

[1] http://www.spinics.net/lists/linux-acpi/msg58593.html


Regards,
Mathias
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
