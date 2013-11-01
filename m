From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri, 01 Nov 2013 01:26:30 +0100
Message-ID: <3950709.TpLA3UW14U@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <526E636D.3070005@linux.intel.com> <1433914.mn8USodCgb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433914.mn8USodCgb-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, November 01, 2013 01:08:47 AM Rafael J. Wysocki wrote:
> On Monday, October 28, 2013 03:15:25 PM Jarkko Nikula wrote:
> > Hi Rafael
> > 
> > On 10/25/2013 05:08 PM, Rafael J. Wysocki wrote:
> > > On Friday, October 25, 2013  04:30:23 PM Jarkko Nikula wrote:
> >  >>>
> >  >> Hmm, not only. Referencing to dev field in struct acpi_device by
> >  >> dev_name(&adev->dev) here will fail too.
> >  >
> >  > Well, something is not quite right here.
> >  >
> >  > One of the *reasons* for having ACPI_HANDLE() defined this way is to
> >  > avoid using explicit CONFIG_ACPI checks, so if that doesn't work,
> >  > then all of that becomes a bit pointless.
> >  >
> 
> Can you please send patches inline instead of using inline attachments,
> so that people don't have to paste your patches back to comment them?
> 
> > One possible thing to do is to let structure definitions to be available 
> > for non-ACPI builds. Then compiler won't fail on structure access which 
> > will be anyway optimized away by later compiler stages.
> 
> Yes, we can do that, but as I said that means we're giving up on the "why
> ACPI_HANDLE() doesn't work as expected" front.  For now, I'd like to
> understand what's up before making that change.  Moreover ->

OK, so I *think* what happens is that the compiler checks if the particular
symbols make sense before trying to optimize out the whole block.

So the patch below modulo the return value of the acpi_bus_get_device() stub
would be fine by me.

Thanks!

> > With a quick test below vmlinux section sizes don't change for couple 
> > non-ACPI build tests and allow to get rid off IS_ENABLED(CONFIG_ACPI) 
> > test in this patch. It's very minimal as it only moves the CONFIG_ACPI 
> > test just after the struct acpi_device definition and defines 
> > acpi_bus_get_device for non-ACPI case.
> > 
> > What I don't know how consistent it is as there are still couple 
> > structure definitions under CONFIG_ACPI, doesn't touch other acpi 
> > headers and requires to include acpi_bus.h in driver (or move acpi_bus.h 
> > include in linux/acpi.h currently under CONFIG_ACPI).
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index d901982..7ab7870 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -66,8 +66,6 @@ bool acpi_ata_match(acpi_handle handle);
> > 
> >   bool acpi_bay_match(acpi_handle handle);
> >   bool acpi_dock_match(acpi_handle handle);
> > 
> > -#ifdef CONFIG_ACPI
> > -
> > 
> >   #include <linux/proc_fs.h>
> >   
> >   #define ACPI_BUS_FILE_ROOT    "acpi"
> > 
> > @@ -314,6 +312,8 @@ struct acpi_device {
> > 
> >       void (*remove)(struct acpi_device *);
> >   
> >   };
> > 
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +
> > 
> >   static inline void *acpi_driver_data(struct acpi_device *d)
> >   {
> >   
> >       return d->driver_data;
> > 
> > @@ -531,6 +531,8 @@ static inline bool acpi_device_can_poweroff(struct
> > acpi_device *adev)
> > 
> >   static inline int register_acpi_bus_type(void *bus) { return 0; }
> >   static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> > 
> > +static inline int acpi_bus_get_device(acpi_handle handle,
> > +                      struct acpi_device **device) { return 0; }
> 
> This has to return an error code, because otherwise the caller can assume
> *device to be a valid pointer after it returns which may not be the case.
> 
> > 
> >   #endif                /* CONFIG_ACPI */

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
