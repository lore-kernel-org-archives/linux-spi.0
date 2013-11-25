From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5 08/17] spi: mpc512x: adjust to OF based clock lookup
Date: Mon, 25 Nov 2013 20:06:41 +0100
Message-ID: <20131125190641.GL2760@book.gsilab.sittig.org>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-9-git-send-email-gsi@denx.de>
 <20131125173008.GQ14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131125173008.GQ14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Nov 25, 2013 at 17:30 +0000, Mark Brown wrote:
> 
> On Mon, Nov 18, 2013 at 12:06:08AM +0100, Gerhard Sittig wrote:
> > after device tree based clock lookup became available, the peripheral
> > driver need no longer construct clock names which include the PSC index,
> > remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> Have there been other changes which make this happen?

Not yet in mainline.  The patch you respond to is 08/17 within
the series, and depends on earlier patches in the series (namely
the introduction of CCF support for the MPC512x platform, making
the 'mclk' lookup against the PSC's OF node work while keeping
the global 'pscN_mclk' in place during migration).

This information was listed in the cover letter, but was not
duplicated within the individual patches.  Patches were sent to
individual Cc: lists to not spam too many people, but the cover
letter was CC'ed to every recipient of any part of the series.

Please note that I will have to re-submit the series, since it no
longer cleanly applies against v3.13-rc1 (which was not available
when I sent v5).  This patch won't change in its content, but may
experience changes in its context (catchup with changes between
v3.12 and v3.13-rc1).

Thank you for considering the patch, and for your feedback on
past versions!


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
