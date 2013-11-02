From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 1/3] ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI builds
Date: Sat, 02 Nov 2013 23:18:31 +0100
Message-ID: <3858838.4tAO673dDi@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com> <1383309356-25430-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1383309356-25430-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, November 01, 2013 02:35:54 PM Jarkko Nikula wrote:
> We may find use for struct acpi_device and acpi_bus_get_device() in generic
> code without wanting to add #if IS_ENABLED(CONFIG_ACPI) churn there.
> 
> Code can use ACPI_HANDLE() test to let compiler optimize out code blocks
> that are not used in !CONFIG_ACPI builds but structure definitions and
> function stubs must be available.
> 
> This patch moves CONFIG_ACPI test so that struct acpi_device definition
> is available for all builds that include acpi_bus.h and provides a stub for
> acpi_bus_get_device().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

This turns out the cause build problems to happen on some architectures.

I guess it's sufficient to simply define a stub struct acpi_device as

struct acpi_device {
	struct device dev;
};

for !CONFIG_ACPI instead.

> ---
>  include/acpi/acpi_bus.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 15100f6..232b37d3 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -66,8 +66,6 @@ bool acpi_ata_match(acpi_handle handle);
>  bool acpi_bay_match(acpi_handle handle);
>  bool acpi_dock_match(acpi_handle handle);
>  
> -#ifdef CONFIG_ACPI
> -
>  #include <linux/proc_fs.h>
>  
>  #define ACPI_BUS_FILE_ROOT	"acpi"
> @@ -315,6 +313,8 @@ struct acpi_device {
>  	void (*remove)(struct acpi_device *);
>  };
>  
> +#if IS_ENABLED(CONFIG_ACPI)
> +
>  static inline void *acpi_driver_data(struct acpi_device *d)
>  {
>  	return d->driver_data;
> @@ -532,6 +532,11 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> +static inline int acpi_bus_get_device(acpi_handle handle,
> +				      struct acpi_device **device)
> +{
> +	return -ENODEV;
> +}
>  
>  #endif				/* CONFIG_ACPI */
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
