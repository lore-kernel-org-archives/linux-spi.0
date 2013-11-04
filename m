From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCHv2 1/3] ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI builds
Date: Mon, 04 Nov 2013 02:00:45 +0100
Message-ID: <5990097.jCz86Yqdpc@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1383309356-25430-2-git-send-email-jarkko.nikula@linux.intel.com> <3858838.4tAO673dDi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3858838.4tAO673dDi-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday, November 02, 2013 11:18:31 PM Rafael J. Wysocki wrote:
> On Friday, November 01, 2013 02:35:54 PM Jarkko Nikula wrote:
> > We may find use for struct acpi_device and acpi_bus_get_device() in generic
> > code without wanting to add #if IS_ENABLED(CONFIG_ACPI) churn there.
> > 
> > Code can use ACPI_HANDLE() test to let compiler optimize out code blocks
> > that are not used in !CONFIG_ACPI builds but structure definitions and
> > function stubs must be available.
> > 
> > This patch moves CONFIG_ACPI test so that struct acpi_device definition
> > is available for all builds that include acpi_bus.h and provides a stub for
> > acpi_bus_get_device().
> > 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> This turns out the cause build problems to happen on some architectures.
> 
> I guess it's sufficient to simply define a stub struct acpi_device as
> 
> struct acpi_device {
> 	struct device dev;
> };
> 
> for !CONFIG_ACPI instead.

Generally, it is a bad idea to #include acpi_bus.h for !CONFIG_ACPI.

The appended patch works for me, sorry for stealing part of your changelog.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI: Define struct acpi_device for CONFIG_ACPI unset

We may find use for struct acpi_device and acpi_bus_get_device() in
generic code without wanting to add #if IS_ENABLED(CONFIG_ACPI) churn
there.

Code can use ACPI_HANDLE() test to let compiler optimize out code
blocks that are not used in !CONFIG_ACPI builds but structure
definitions and function stubs must be available.

Define a stub struct acpi_device for CONFIG_ACPI unset containing dev
as the only member and a stub acpi_bus_get_device() always returning
an error code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/acpi.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -472,7 +472,17 @@ static inline bool acpi_driver_match_dev
 }
 
 #define ACPI_PTR(_ptr)	(NULL)
+typedef void * acpi_handle;
 
+struct acpi_device {
+	struct device dev;
+};
+
+static inline int acpi_bus_get_device(acpi_handle handle,
+				      struct acpi_device **device)
+{
+	return -ENODEV;
+}
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
