From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Mon, 15 Jun 2015 21:12:22 +0200
Message-ID: <878ubkbxbd.fsf@belgarion.home>
References: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
	<20150615095344.GE18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik Work <robert.jarzmik-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150615095344.GE18309-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Mon, 15 Jun 2015 10:53:44 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Sat, Jun 13, 2015 at 02:22:14PM +0200, Mathias Krause wrote:
>> Constify the ACPI device ID array, it doesn't need to be writable at
>> runtime.
>
> Applied, please do make an effort to CC relevant people working on the
> code when contributing patches (I'm not seeing any of the people working
> on the Intel platforms here
Actually there is one working on Intel embedded devices, it's just that it's his
dark side, see "To:" of this mail with an unusual mail address :)

And Mathias, even if it's not obvious, and even obfuscated, look at this :
rj@belgarion:~/mio_linux/kernel$ scripts/get_maintainer.pl --rolestats --roles
--git-max-maintainers=10 --git-blame -f drivers/spi/spi-pxa2xx.c
  Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org> (authored lines:553/1600=35%)
  Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> (authored lines:321/1600=20%,commits:25/80=31%)

These are the top 2 authors.

All of this brings me to the next point : Mika, wouldn't you add yourself as
spi-pxa2xx maintainer ? I can't recall if it's for Edison or another platform,
but you contribute a lot to spi-pxa2xx, so wouldn't it make sense ?

Cheers.

--
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
