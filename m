From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] spi_topcliff_pch: fix resource leak issue
Date: Tue, 28 Dec 2010 23:51:44 -0700
Message-ID: <20101229065144.GE8172@angua.secretlab.ca>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <1293449027-3219-2-git-send-email-tomoya-linux@dsn.okisemi.com>
 <1293449027-3219-3-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293449027-3219-3-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 27, 2010 at 08:23:47PM +0900, Tomoya MORINAGA wrote:
> In case spi_register_master fails in probe function,
> pch_spi_free_resources is not called.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Ditto for patch 2.  This looks like a bug fix, please respin to apply
without patch #1

Thanks,
g.

> ---
>  drivers/spi/spi_topcliff_pch.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
> index a796eaf..e806e31 100644
> --- a/drivers/spi/spi_topcliff_pch.c
> +++ b/drivers/spi/spi_topcliff_pch.c
> @@ -1125,6 +1125,7 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  err_spi_reg_master:
>  	for (j = 0; j < i; j++)
>  		spi_unregister_master(master[j]);
> +	pch_spi_free_resources(board_dat);
>  err_spi_get_resources:
>  err_spi_alloc_master:
>  	for (j = 0; j < i; j++)
> -- 
> 1.6.0.6
> 
