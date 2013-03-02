From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of: spi: Return error from of_spi_register_master on bad
 "cs-gpios" property
Date: Sat, 02 Mar 2013 22:49:06 +0000
Message-ID: <20130302224906.369303E2F5C@localhost>
References: <1360761804-16044-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1360761804-16044-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Wed, 13 Feb 2013 14:23:24 +0100, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> wrote:
> This makes sure that an error is returned on an incorrectly formed
> "cs-gpios" property, but reports success when the "cs-gpios" property is
> well formed or missing.
> 
> When holes in the cs-gpios property phandle list is used to indicate
> that some other form of chipselect is to be used it is important that
> failure to read a broken "cs-gpios" property does not silently fail
> leading to the spi controller to use an unintended chipselect.
> 
> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.

> ---
> 
> Can only be applied to devicetree/next as it builds upon the
> "of: Add helper for counting phandle refernces" patch series.
> 
>  drivers/spi/spi.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 21c4748..9b5f024 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1068,8 +1068,11 @@ static int of_spi_register_master(struct spi_master *master)
>  	nb = of_gpio_named_count(np, "cs-gpios");
>  	master->num_chipselect = max(nb, (int)master->num_chipselect);
>  
> -	if (nb < 1)
> +	/* Return error only for an incorrectly formed cs-gpios property */
> +	if (nb == 0 || nb == -ENOENT)
>  		return 0;
> +	else if (nb < 0)
> +		return nb;
>  
>  	cs = devm_kzalloc(&master->dev,
>  			  sizeof(int) * master->num_chipselect,
> -- 
> 1.7.0.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
