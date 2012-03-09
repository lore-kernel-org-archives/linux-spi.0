From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically to get DMA device info
Date: Fri, 09 Mar 2012 16:45:58 -0700
Message-ID: <20120309234558.692513E093E@localhost>
References: <1323403905-3432-1-git-send-email-tomoya.rohm@gmail.com>
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, Wolfram Sang <w.sang@pengutronix.de>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323403905-3432-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri,  9 Dec 2011 13:11:42 +0900, Tomoya MORINAGA <tomoya.rohm@gmail.com> wrote:
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
> ---
>  drivers/spi/spi-topcliff-pch.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 99ec279..fcd9462 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -920,7 +920,8 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
>  	dma_cap_set(DMA_SLAVE, mask);
>  
>  	/* Get DMA's dev information */
> -	dma_dev = pci_get_bus_and_slot(2, PCI_DEVFN(12, 0));
> +	dma_dev = pci_get_bus_and_slot(data->board_dat->pdev->bus->number,
> +				       PCI_DEVFN(12, 0));

Applied, thanks

g.
