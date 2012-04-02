From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v5 2/4] mfd: mc13xxx-core: use regmap for register
 access
Date: Mon, 2 Apr 2012 17:00:36 +0100
Message-ID: <20120402160036.GA29808@sirena.org.uk>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <1333262499-25871-3-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexg-uRCCPK1wpQlR0G4FFNCX/g@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1333262499-25871-3-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 01, 2012 at 04:41:37PM +1000, Marc Reilly wrote:
> This change converts the mc13xxx core to use regmap rather than direct
> spi r/w.
> The spidev member of mc13xxx struct becomes redundant and is removed.
> Extra debugging aids are added to mc13xxx_reg_rmw.

To repeat what I've said on previous versions please push this down into
regmap.  There's already extensive diagnostic features there, let's not
have people open coding things that are missing.
