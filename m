From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
Date: Mon, 2 Dec 2013 16:10:50 +0100
Message-ID: <20131202151050.GU2982@book.gsilab.sittig.org>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-9-git-send-email-gsi@denx.de>
 <20131202095034.GB12952@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131202095034.GB12952-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 02, 2013 at 09:50 +0000, Mark Rutland wrote:
> 
> On Sat, Nov 30, 2013 at 10:51:28PM +0000, Gerhard Sittig wrote:
> > after device tree based clock lookup became available, the peripheral
> > driver need no longer construct clock names which include the PSC index,
> > remove the "psc%d_mclk" template and unconditionally use 'mclk'
> > 
> > acquire and release the 'ipg' clock item for register access as well
> 
> For this and the other peripheral updates, it would be nice to have the
> expected clock-names entries added to the respective binding documents.
> Otherwise this looks fine to me.

I will look into adding these 'clock-names' to binding documents
for the peripherals, too (not just SPI but the others as well).
Thank you for the feedback!

It appears that not all of those peripherals have existing
binding docs, so introducing these docs in the first place may
exceed the scope of the CCF support introduction series, and I
may have to create another series for the doc updates.  I assume
that it's OK to address the issue of missing documentation in a
separate action.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
