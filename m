From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/5] Generalize module_platform_driver
Date: Wed, 16 Nov 2011 08:02:06 -0800
Message-ID: <20111116160206.GA27049@suse.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Hennerich <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1321434819-23678-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 16, 2011 at 10:13:34AM +0100, Lars-Peter Clausen wrote:
> Grant Likely recently introduced the module_platform_driver macro which can be
> used to eliminate a few lines on boilerplate code in platform driver modules.
> The same approach can be used to do the same for other bus type drivers.
> 
> The first patch of this series generalizes the module_platform_driver macro and
> introduces the module_driver macro. It is similar to module_platform_driver
> macro but has two additional parameters to pass in the driver register and
> unregister function. The intend is that this macro is used to construct bus
> specific macros for generating the driver register/unregister boilerplate code.
> 
> The next two patches in this series add the module_i2c_driver and
> module_spi_driver macro which use the module_driver macro to generate the I2C
> and SPI driver boilerplate code.
> 
> The last two patches convert the driver found in the IIO framework to use the
> new module_i2c_driver and module_spi_driver macros to demonstrate their
> potential and remove over 700 lines of code.
> 
> While this series only introduces these kind of helper macros for I2C and SPI
> bus drivers the same scheme should be applicable to most other bus driver types.
> For example PCI and USB seem to be good candidates.
> 
> It probably makes sense to merge the first three patches together. The last two
> can probably, since this is not urgent, wait until the first three have reached
> mainline.

Nice, I like this, unless people object, I'll merge the first patch to
the driver-core tree.

I'll gladly take the i2c and spi patches as well if the subsystem
maintainers there don't object, and I'll work on the USB patch as well.

thanks,

greg k-h
