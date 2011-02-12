From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: mc13xxx-core, support for i2c, V4
Date: Sat, 12 Feb 2011 01:40:35 -0700
Message-ID: <20110212084035.GB17755@angua.secretlab.ca>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294119299-18352-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> Hi,
> 
> These patches add i2c support for the mc13xxx-core drive. For v4 I've tried to take
> in all previous comments, hopefully making it better to follow, and bisectable.

This series looks okay to me.  Since this is audio drivers, I expect
that it would best be taken via the ASoC tree?  Have you sent it to
Mark Brown and the ALSA list for review?

g.
