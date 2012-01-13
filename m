From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/5] drivercore: Generalize module_platform_driver
Date: Fri, 13 Jan 2012 10:23:26 -0800
Message-ID: <20120113182326.GA30411@suse.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de>
 <1321434819-23678-2-git-send-email-lars@metafoo.de>
 <Pine.LNX.4.64.1201131003270.29680@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jean Delvare <khali@linux-fr.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, spi-devel-general@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201131003270.29680@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 13, 2012 at 10:07:19AM +0100, Guennadi Liakhovetski wrote:
> I didn't find this patch either in "next" or in Greg's "driver-core" 
> trees, so, couldn't generate a patch and had to comment here:

It's in Linus's tree now.

> > +/**
> > + * module_driver() - Helper macro for drivers that don't do anything
> > + * special in module init/exit. This eliminates a lot of boilerplate.
> > + * Each module may only use this macro once, and calling it replaces
> > + * module_init() and module_exit().
> > + * Use this macro to construct bus specific macros for registering
> > + * drivers.
> > + */
> > +#define module_driver(__driver, __register, __unregister) \
> > +static int __init __driver##_init(void) \
> > +{ \
> > +	return __register(&(__driver)); \
> > +} \
> > +module_init(__driver##_init); \
> > +static void __exit __driver##_exit(void) \
> > +{ \
> > +	__unregister(&(__driver)); \
> > +} \
> > +module_exit(__driver##_exit);
> 
> Shall we maybe remove the trailing semicolon above?

Sure, but either way it doesn't really matter.

Care to send a fix-up patch that I can apply for 3.4?

thanks,

greg k-h
