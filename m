From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] spi: pxa2xx: Use ACPI_COMPANION() instead of acpi_bus_get_device()
Date: Sat, 26 Sep 2015 01:56:09 +0200
Message-ID: <4840826.juYE1IZ9q9@vostro.rjw.lan>
References: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com> <1443166038-31658-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-acpi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443166038-31658-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, September 25, 2015 10:27:18 AM Jarkko Nikula wrote:
> Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
> is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/spi/spi-pxa2xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 36cbb0f10856..6f834e5b0547 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1316,8 +1316,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
>  	const struct pci_device_id *pcidev_id = NULL;
>  	int devid, type;
>  
> -	if (!ACPI_HANDLE(&pdev->dev) ||
> -	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
>  		return NULL;
>  
>  	if (dev_is_pci(pdev->dev.parent))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
