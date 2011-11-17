From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] drivercore: Generalize module_platform_driver
Date: Thu, 17 Nov 2011 12:04:11 -0800
Message-ID: <20111117200411.GA8691@kroah.com>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de>
 <1321434819-23678-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Hennerich <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1321434819-23678-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 16, 2011 at 10:13:35AM +0100, Lars-Peter Clausen wrote:
> This patch generalizes the module_platform_driver macro and introduces a new
> module_driver macro. The module_driver macro takes a driver name, a register
> and a unregister function for this driver type. Using these it construct the
> module init and exit sections which register and unregister the driver. Since
> such init/exit sections are commonly found in drivers this macro can be used
> to eliminate a lot of boilerplate code.
> 
> The macro is not intended to be used by driver modules directly, instead it
> should be used to generate bus specific macros for registering drivers like
> the module_platform_driver macro.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  include/linux/init.h            |   21 +++++++++++++++++++++

I've moved this from init.h (which is trying to get away from
module-specific stuff) to device.h, which is where this really should
be.

thanks,

greg k-h
