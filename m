From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sirf: add support for new SiRFmarco SMP SoC
Date: Tue, 05 Feb 2013 12:43:50 +0000
Message-ID: <20130205124351.4DDA93E0E27@localhost>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
	<1356490114-18022-2-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356490114-18022-2-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 26 Dec 2012 10:48:34 +0800, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org> wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> 
> the driver is also compatible with SiRFmarco except SiRFprimaII,
> so simply add "sirf,marco-spi" to OF match table.
> 
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-sirf.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index 38a191c..09ca0e3 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -659,6 +659,7 @@ static const struct dev_pm_ops spi_sirfsoc_pm_ops = {
>  
>  static const struct of_device_id spi_sirfsoc_of_match[] = {
>  	{ .compatible = "sirf,prima2-spi", },
> +	{ .compatible = "sirf,marco-spi", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sirfsoc_spi_of_match);
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
