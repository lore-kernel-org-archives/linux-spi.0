From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 7/7] spi: spi-fsl-spi: Add support for gpio chipselects
	for GRLIB type cores
Date: Sat, 02 Mar 2013 21:34:47 +0000
Message-ID: <20130302213447.2478B3E2249@localhost>
References: <1360242731-13700-1-git-send-email-andreas@gaisler.com>
	<1360242731-13700-8-git-send-email-andreas@gaisler.com>
	<20130207160821.GA22224@lizard.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130207160821.GA22224-1CZZkhFgUWNRmOO2HpYVOJIbA5emDH3N@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 7 Feb 2013 08:08:21 -0800, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Feb 07, 2013 at 02:12:11PM +0100, Andreas Larsson wrote:
> > This relies upon of_spi_register_master to find out which gpios to use.
> > 
> > Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-fsl-lib.h |    1 +
> >  drivers/spi/spi-fsl-spi.c |   53 +++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 48 insertions(+), 6 deletions(-)
> 
> Just a couple of minor nits...
> 
> > diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
> > index d5c788b..52db693 100644
> > --- a/drivers/spi/spi-fsl-lib.h
> > +++ b/drivers/spi/spi-fsl-lib.h
> > @@ -71,6 +71,7 @@ struct mpc8xxx_spi {
> >  
> >  #ifdef CONFIG_SPI_FSL_SPI
> >  	int type;
> > +	int native_chipselects;
> >  	u8 max_bits_per_word;
> >  
> >  	void (*set_shifts)(u32 *rx_shift, u32 *tx_shift,
> > diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> > index 55652e6..2befe16 100644
> > --- a/drivers/spi/spi-fsl-spi.c
> > +++ b/drivers/spi/spi-fsl-spi.c
> > @@ -418,7 +418,7 @@ static int fsl_spi_setup(struct spi_device *spi)
> >  {
> >  	struct mpc8xxx_spi *mpc8xxx_spi;
> >  	struct fsl_spi_reg *reg_base;
> > -	int retval;
> > +	int retval, desel;
> 
> We don't usually place variable declarations on the same line, unless the
> variables are closely related.

That's not something I've ever heard before. I certainly won't reject a
patch over it.

g.


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
