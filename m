From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] spi: pxa2xx: Enable support for
 compile-testing
Date: Mon, 10 Feb 2020 08:21:18 -0600
Message-ID: <abf31c4f-638c-0732-6dc3-957a903e8d56@linux.intel.com>
References: <20200210093027.6672-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210093027.6672-1-geert@linux-m68k.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2/10/20 3:30 AM, Geert Uytterhoeven wrote:
> m68k/allmodconfig:
> 
>      WARNING: unmet direct dependencies detected for SPI_PXA2XX
>        Depends on [n]: SPI [=y] && SPI_MASTER [=y] && (ARCH_PXA || ARCH_MMP || PCI [=n] || ACPI)
>        Selected by [m]:
>        - SND_SOC_INTEL_BDW_RT5677_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_INTEL_HASWELL [=n] || SND_SOC_SOF_BROADWELL [=m]) && I2C [=m] && (I2C_DESIGNWARE_PLATFORM [=m] || COMPILE_TEST [=y]) && (GPIOLIB [=y] || COMPILE_TEST [=y]) && (X86_INTEL_LPSS || COMPILE_TEST [=y]) && SPI_MASTER [=y]
> 
> This happens because SND_SOC_INTEL_BDW_RT5677_MACH selects SPI_PXA2XX,
> and the former depends on COMPILE_TEST, while the latter does not.
> 
> Fix this by enabling compile-testing for SPI_PXA2XX.
> 
> Fixes: 630db1549356f644 ("ASoC: Intel: bdw-rt5677: fix Kconfig dependencies")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Makes sense.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/spi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ee96708aa3a77156..2e1c3a575f7a6cc3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -557,7 +557,7 @@ config SPI_PPC4xx
>   
>   config SPI_PXA2XX
>   	tristate "PXA2xx SSP SPI master"
> -	depends on (ARCH_PXA || ARCH_MMP || PCI || ACPI)
> +	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
>   	select PXA_SSP if ARCH_PXA || ARCH_MMP
>   	help
>   	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
> 
