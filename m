From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Tue, 5 May 2015 14:20:08 +0200
Message-ID: <20150505142008.2087baac@north>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
	<1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
	<20150504134226.GY15510@sirena.org.uk>
	<9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 4 May 2015 16:25:01 +0200, Martin Sperl wrote:
> > On 04.05.2015, at 15:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > This is unsuitable for sysfs as it is, sysfs is strictly one value =
per
> > file.  debugfs would be a more suitable place for a file like this,=
 or
> > if they are going to go into sysfs they should go in as a directory=
 of
> > files with one value per file like the network device statistics
> > directory.  I'm ambivalent about which is the best place, both have
> > their merits. =20
>
> that makes it much more complicated to add things per spi_master
> implementation (which was my original idea: have a framework that exp=
oses
> the distinct transfer modes of the spi-bcm2835 driver (polling, inter=
rupt
> and dma driven) and also to get some stats on how often we run into t=
hose
> =E2=80=9Ccorner=E2=80=9D cases - that is also why I want to gather th=
e histogram
> statistics, as it may make it easier to understand the use cases of p=
eople
> who complain about =E2=80=9Cperformance=E2=80=9D in case they share t=
hose infos=E2=80=A6

You can also consider adding few strategically placed tracepoints. =20
It saves the amount of kernel code necessary and is generally more
flexible.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
