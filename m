From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Mon, 28 Oct 2013 15:15:25 +0200
Message-ID: <526E636D.3070005@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <98785510.yWYAtabkbj@vostro.rjw.lan> <526A726F.1030407@linux.intel.com> <2889412.bEKBLJtgSW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2889412.bEKBLJtgSW-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Rafael

On 10/25/2013 05:08 PM, Rafael J. Wysocki wrote:
> On Friday, October 25, 2013  04:30:23 PM Jarkko Nikula wrote:
 >>>
 >> Hmm, not only. Referencing to dev field in struct acpi_device by
 >> dev_name(&adev->dev) here will fail too.
 >
 > Well, something is not quite right here.
 >
 > One of the *reasons* for having ACPI_HANDLE() defined this way is to
 > avoid using explicit CONFIG_ACPI checks, so if that doesn't work,
 > then all of that becomes a bit pointless.
 >
One possible thing to do is to let structure definitions to be available 
for non-ACPI builds. Then compiler won't fail on structure access which 
will be anyway optimized away by later compiler stages.

With a quick test below vmlinux section sizes don't change for couple 
non-ACPI build tests and allow to get rid off IS_ENABLED(CONFIG_ACPI) 
test in this patch. It's very minimal as it only moves the CONFIG_ACPI 
test just after the struct acpi_device definition and defines 
acpi_bus_get_device for non-ACPI case.

What I don't know how consistent it is as there are still couple 
structure definitions under CONFIG_ACPI, doesn't touch other acpi 
headers and requires to include acpi_bus.h in driver (or move acpi_bus.h 
include in linux/acpi.h currently under CONFIG_ACPI).

-- 
Jarkko

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d901982..7ab7870 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -66,8 +66,6 @@ bool acpi_ata_match(acpi_handle handle);
  bool acpi_bay_match(acpi_handle handle);
  bool acpi_dock_match(acpi_handle handle);

-#ifdef CONFIG_ACPI
-
  #include <linux/proc_fs.h>

  #define ACPI_BUS_FILE_ROOT    "acpi"
@@ -314,6 +312,8 @@ struct acpi_device {
      void (*remove)(struct acpi_device *);
  };

+#if IS_ENABLED(CONFIG_ACPI)
+
  static inline void *acpi_driver_data(struct acpi_device *d)
  {
      return d->driver_data;
@@ -531,6 +531,8 @@ static inline bool acpi_device_can_poweroff(struct 
acpi_device *adev)

  static inline int register_acpi_bus_type(void *bus) { return 0; }
  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
+static inline int acpi_bus_get_device(acpi_handle handle,
+                      struct acpi_device **device) { return 0; }

  #endif                /* CONFIG_ACPI */
