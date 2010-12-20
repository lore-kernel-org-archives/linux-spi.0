From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare
	for separate i2c and spi
Date: Mon, 20 Dec 2010 11:48:12 +0000
Message-ID: <20101220114811.GA14986@sirena.org.uk>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au> <1292817055-17715-2-git-send-email-marc@cpdesign.com.au> <20101220083120.GP1940@pengutronix.de> <201012202100.29212.marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Kleine-K?nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012202100.29212.marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 20, 2010 at 09:00:29PM +1100, Marc Reilly wrote:
> On Monday, December 20, 2010 07:31:20 pm Uwe Kleine-K?nig wrote:

> > This list isn't complete, but see below.

> Do you mean the list above is incomplete? I should have said "Changes to the 
> struct _include_". 
> I'm ignorant of "patch summary etiquette" (or what people otherwise like to 
> see) but I had just assumed that the patch comments were more like a 
> highlights reel - the real info is in the patch itself.

No, the patch summary should generally be complete - if your patch is
changing so many things that it's getting tedious to list them all then
that's usually a sign that it should be split up into a series of
changes.
