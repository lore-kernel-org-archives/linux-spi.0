From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake
Date: Tue, 16 Apr 2019 11:00:17 +0300
Message-ID: <CAHp75VcPYu1APhcqcu-Df5ucpW-q597OCKHwne1dgqQsMM9+Fg@mail.gmail.com>
References: <20190416032743.180517-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
To: Evan Green <evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416032743.180517-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 16, 2019 at 6:28 AM Evan Green <evgreen@chromium.org> wrote:
>
> Add PCI IDs for SPI on Comet Lake.
>

I didn't check IDs, perhaps Jarkko can do it.
>From other prospectives looks good.
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> ---
>
>  drivers/spi/spi-pxa2xx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index b6ddba833d021..493223e1d032d 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1451,6 +1451,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
>         { PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
> +       /* CML-LP */
> +       { PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
>         { },
>  };
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
