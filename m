From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] spi_topcliff_pch: change calling function order
 correctly in remove
Date: Tue, 28 Dec 2010 23:51:08 -0700
Message-ID: <20101229065108.GD8172@angua.secretlab.ca>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <1293449027-3219-2-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293449027-3219-2-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 27, 2010 at 08:23:46PM +0900, Tomoya MORINAGA wrote:
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Hi Tomoya,

This looks like a bug fix that should be applied now, but I cannot
apply it to mainline because it depends on the first patch in your
series which I'm not going to apply.  If you respin this patch to
apply without the first patch, then I can pick it up immediately.

g.

> ---
>  drivers/spi/spi_topcliff_pch.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
> index 18e077b..a796eaf 100644
> --- a/drivers/spi/spi_topcliff_pch.c
> +++ b/drivers/spi/spi_topcliff_pch.c
> @@ -1166,21 +1166,21 @@ static void pch_spi_remove(struct pci_dev *pdev)
>  		spin_unlock(&board_dat->data[i]->lock);
>  	}
>  
> -	/* Free resources allocated for PCH SPI */
> -	pch_spi_free_resources(board_dat);
> -
>  	/* Unregister SPI master */
>  	for (i = 0; i < board_dat->num; i++)
>  		spi_unregister_master(board_dat->data[i]->master);
>  
> -	/* free memory for private data */
> -	kfree(board_dat);
> +	/* Free resources allocated for PCH SPI */
> +	pch_spi_free_resources(board_dat);
>  
>  	pci_set_drvdata(pdev, NULL);
>  
>  	/* disable PCI device */
>  	pci_disable_device(pdev);
>  
> +	/* free memory for private data */
> +	kfree(board_dat);
> +
>  	dev_dbg(&pdev->dev, "%s invoked pci_disable_device\n", __func__);
>  }
>  
> -- 
> 1.6.0.6
> 
