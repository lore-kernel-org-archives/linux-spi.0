From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] spi: cadence: Add dependency on ARCH_ZYNQ
Date: Tue, 15 Apr 2014 17:26:21 +0100
Message-ID: <20140415162621.GO17408@arm.com>
References: <1397537392-3709-1-git-send-email-harinik@xilinx.com>
 <CAHTX3dJrMxWJ-8i-wLRkQYtR_zbA+nJyGW+r-DFMYHHU4Erzbw@mail.gmail.com>
 <20140415094541.GL12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140415094541.GL12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 15, 2014 at 10:45:41AM +0100, Mark Brown wrote:
> On Tue, Apr 15, 2014 at 08:11:37AM +0200, Michal Simek wrote:
> 
> > I sent the patch for it which solve this problem in generic way.
> > http://lkml.org/lkml/2014/4/8/42
> 
> > Feel free to give me ACK for it.
> 
> Will has been working on this too off and on, he was also trying to
> define some semantics for the relaxed versions.  It'd be really good to
> address this properly, this is a constant source of make work.

Yes, I have a series adding relaxed accessors to all architectures (and
asm-generic) along with an attempt at defining some semantics. This came
about from discussion with BenH at the last kernel summit, I just didn't get
around to posting what we came up with.

I should be able to post something this week, but there's still an open
question relating to mmiowb() that I'd like the PPC guys to chime in on.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
