From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
Date: Thu, 6 Jun 2019 11:17:41 +0200
Message-ID: <CAJZ5v0h+maPj-ijKV_vvQBpHD7N-VMiAqSeyztAkiUR9E2WdmQ@mail.gmail.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com> <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Add a generic helper to match a device by the acpi device.

"by its ACPI companion device object", please.

Also, it would be good to combine this patch with the patch(es) that
cause device_match_acpi_dev() to be actually used.

Helpers without any users are arguably not useful.

>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/base/core.c    | 6 ++++++
>  include/linux/device.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b827ca1..597095b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3346,3 +3346,9 @@ int device_match_devt(struct device *dev, const void *pdevt)
>         return dev->devt == *(dev_t *)pdevt;
>  }
>  EXPORT_SYMBOL_GPL(device_match_devt);
> +
> +int device_match_acpi_dev(struct device *dev, const void *adev)
> +{
> +       return ACPI_COMPANION(dev) == adev;
> +}
> +EXPORT_SYMBOL(device_match_acpi_dev);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index f315692..a03b50d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -166,6 +166,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
>  int device_match_of_node(struct device *dev, const void *np);
>  int device_match_fwnode(struct device *dev, const void *fwnode);
>  int device_match_devt(struct device *dev, const void *pdevt);
> +int device_match_acpi_dev(struct device *dev, const void *adev);
>
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
>                      int (*fn)(struct device *dev, void *data));
> --
> 2.7.4
>
