From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: Add missing cell-index OF property
Date: Sat, 26 May 2012 18:23:33 +0200
Message-ID: <OFB53233C6.0724FA94-ONC1257A0A.00593F62-C1257A0A.005A0C24@transmode.se>
References: <1337953769-28244-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20120525185226.A88A43E061A@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120525185226.A88A43E061A@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote on 2012/05/25 20:52:26:
>
> On Fri, 25 May 2012 15:49:29 +0200, Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> > espi does not look for a OF cell-index property which
> > makes the bus numbering dynamic only. This add an
> > optional cell-index.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
>
> Nack.  Use /aliases instead.

hmm, tried that but that didn't work:
      aliases {
               spi0 = &spi0;
      }
Maybe we need some other alias then(what)?

Anyhow, what is wrong with adding cell-index? Isn't that the standard ?

To be clear what we want to do is make spidev (in /dev) appear
as spidev0 instead of spidev<some random number>

>
> g.
>
> > ---
> >  drivers/spi/spi-fsl-espi.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> > index d770f03..c4bea1f 100644
> > --- a/drivers/spi/spi-fsl-espi.c
> > +++ b/drivers/spi/spi-fsl-espi.c
> > @@ -680,6 +680,10 @@ static int of_fsl_espi_get_chipselects(struct device *dev)
> >     }
> >
> >     pdata->max_chipselect = *prop;
> > +   prop = of_get_property(np, "cell-index", &len);
> > +   if (prop && len == sizeof(*prop))
> > +      pdata->bus_num = *prop;
> > +
> >     pdata->cs_control = NULL;
> >
> >     return 0;
> > --


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
