From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Thu, 8 Jan 2009 12:20:22 +0000
Message-ID: <20090108122022.GO12431@fluff.org.uk>
References: <20090107125619.052023040@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090107125619.052023040-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 07, 2009 at 12:56:19PM +0000, ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org wrote:
> A number of drivers in drivers/gpio return -ENODEV when confronted
> with missing setup parameters such as the platform data. However,
> returning -ENODEV causes the driver layer to silently ignore the
> driver as it assumes the probe did not find anything and was only
> speculative.
> 
> To make life easier to discern why a driver is not being attached,
> change to returning -EINVAL, which is a better description of the
> fact that the driver data was not valid.
> 
> Also add a set of dev_dbg() statements to the error paths to provide
> an better explanation of the error as there may be more that one point
> in the driver.

sorry, sent from the wrong email address please ignore.
-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
