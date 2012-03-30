From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Bug fix in commit 178db7d3 triggered a bug in the SPI
	driver for MPC83XX (pdata is NULL).
Date: Fri, 30 Mar 2012 16:25:42 -0600
Message-ID: <20120330222542.E63AB3E0709@localhost>
References: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
To: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, joakim.tjernlund-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1333119930-21129-1-git-send-email-kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 30 Mar 2012 17:05:30 +0200, Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org> wrote:
> After commit 178db7d3 devices are initialized as children of the bus master, not children of the bus masters parent device. The pdata pointer used in fsl_spi_chipselect must updated to reflect the changed initialization.
> 
> Signed-off-by: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>

Applied; but I have a comments on your commit text.

SHA1 id's are great for looking up commits, but they don't help at all
for casual readers on the mailing list or doing web searches.  Please
always include the commit title when referencing an earlier commit.  I
had to edit the commit text.  Here is what I changed it to:

    spi/mpc83xx: fix NULL pdata dereference bug
    
    Commit 178db7d3, "spi: Fix device unregistration when unregistering
    the bus master", changed device initialization to be children of the
    bus master, not children of the bus masters parent device. The pdata
    pointer used in fsl_spi_chipselect must updated to reflect the changed
    initialization.

g.

> ---
>  drivers/spi/spi-fsl-spi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 7d6ca68..dc747a0 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -139,10 +139,12 @@ static void fsl_spi_change_mode(struct spi_device *spi)
>  static void fsl_spi_chipselect(struct spi_device *spi, int value)
>  {
>  	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
> -	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
> +	struct fsl_spi_platform_data *pdata;
>  	bool pol = spi->mode & SPI_CS_HIGH;
>  	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
>  
> +	pdata = spi->dev.parent->parent->platform_data;
> +
>  	if (value == BITBANG_CS_INACTIVE) {
>  		if (pdata->cs_control)
>  			pdata->cs_control(spi, !pol);
> -- 
> 1.7.3.4
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
