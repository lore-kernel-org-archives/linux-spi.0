From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] spi: omap-uwire: fix compilation failure
Date: Fri, 27 Jun 2014 09:29:16 -0700
Message-ID: <CAOesGMhOjiqix9wKto=e0xM5=8B1eXhnmEMGgY=jLOCad6VmkA@mail.gmail.com>
References: <20140620203858.GA14718@himangi-Dell>
	<1403849258-21779-1-git-send-email-olof@lixom.net>
	<20140627090303.GB23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140627090303.GB23300-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jun 27, 2014 at 2:03 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 26, 2014 at 11:07:38PM -0700, Olof Johansson wrote:
>> Patch 'spi: omap-uwire: use devm_ functions' (b3f6a57506b8) introduced a
>> build error due to a missing include file. Add it.
>
> A similar patch was applied a few days ago.

Ah, cool. I've seen the build breakage a couple of days including last
night's next and I didn't notice a patch for it based on a quick
search.

http://arm-soc.lixom.net/buildlogs/next/next-20140627/buildall.arm.omap1_defconfig.log.failed
http://arm-soc.lixom.net/buildlogs/next/next-20140626/buildall.arm.omap1_defconfig.log.failed


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
