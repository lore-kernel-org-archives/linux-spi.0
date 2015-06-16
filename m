From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Tue, 16 Jun 2015 12:37:28 +0300
Message-ID: <20150616093728.GW1478@lahna.fi.intel.com>
References: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
 <20150615095344.GE18309@sirena.org.uk>
 <878ubkbxbd.fsf@belgarion.home>
 <20150615192025.GE18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Robert Jarzmik Work <robert.jarzmik-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150615192025.GE18309-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 15, 2015 at 08:20:25PM +0100, Mark Brown wrote:
> On Mon, Jun 15, 2015 at 09:12:22PM +0200, Robert Jarzmik wrote:
> 
> > Actually there is one working on Intel embedded devices, it's just that it's his
> > dark side, see "To:" of this mail with an unusual mail address :)
> 
> Huh, I'd forgotten you were working for Intel now sorry - I was mainly
> thinking of Mika and Jarkko here.  I did remember you used to work on
> some of the PXA handhelds!
> 
> > All of this brings me to the next point : Mika, wouldn't you add yourself as
> > spi-pxa2xx maintainer ? I can't recall if it's for Edison or another platform,
> > but you contribute a lot to spi-pxa2xx, so wouldn't it make sense ?
> 
> Yeah.

Jarkko Nikula (CC'd) has been taking care of this driver lately. I would
recommend him to be listed as a maintainer if this driver. If it is OK
for him, that is.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
