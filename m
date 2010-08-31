From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] spi/dw_spi: Enable Intel Moorestown SPI controller 1
Date: Tue, 31 Aug 2010 15:39:36 +0800
Message-ID: <20100831153936.2ca0475c@feng-i7>
References: <20100831061416.GA5904@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<alan@linux.intel.com>
To: Yong Wang <yong.y.wang@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100831061416.GA5904@ywang-moblin2.bj.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


NAK.

We should not export SPI1 has x86 core has no way to access its register.
though the device physically exists.

Thanks,
Feng

On Tue, 31 Aug 2010 14:14:16 +0800
Yong Wang <yong.y.wang@linux.intel.com> wrote:

> Enable Intel Moorestown SPI controller 1
> 
> Signed-off-by: Yong Wang <yong.y.wang@intel.com>
> ---
>  drivers/spi/dw_spi_pci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
> index 1f52755..eec9d0b 100644
> --- a/drivers/spi/dw_spi_pci.c
> +++ b/drivers/spi/dw_spi_pci.c
> @@ -142,6 +142,8 @@ static int spi_resume(struct pci_dev *pdev)
>  static const struct pci_device_id pci_ids[] __devinitdata = {
>  	/* Intel Moorestown platform SPI controller 0 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
> +	/* Intel Moorestown platform SPI controller 1 */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0801) },
>  	{},
>  };
>  
