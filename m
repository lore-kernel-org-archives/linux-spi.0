From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/spi-fsl-spi: reference correct pdata in
	fsl_spi_cs_control
Date: Sat, 19 May 2012 23:12:16 -0600
Message-ID: <20120520051216.AAAD73E03B8@localhost>
References: <1336775390-24128-1-git-send-email-herton.krzesinski@canonical.com>
	<OFDB3A7477.7395BFE4-ONC12579FD.003346CE-C12579FD.00337DEA@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	"Herton R. Krzesinski" <herton.krzesinski-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OFDB3A7477.7395BFE4-ONC12579FD.003346CE-C12579FD.00337DEA-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 13 May 2012 11:22:25 +0200, Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> "Herton R. Krzesinski" <herton.krzesinski-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wrote on 2012/05/12 00:29:50:
> >
> > From: Herton Ronaldo Krzesinski <herton.krzesinski-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> >
> > Commit 178db7d3, "spi: Fix device unregistration when unregistering
> > the bus master", changed spi device initialization of dev.parent pointer
> > to be the master's device pointer instead of his parent.
> >
> > This introduced a bug in spi-fsl-spi, since its usage of spi device
> > pointer was not updated accordingly. This was later fixed by commit
> > 5039a86, "spi/mpc83xx: fix NULL pdata dereference bug", but it missed
> > another spot on fsl_spi_cs_control function where we also need to update
> > usage of spi device pointer. This change address that.
> >
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> > ---
> >  drivers/spi/spi-fsl-spi.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> > index 5f748c0..6a62934 100644
> > --- a/drivers/spi/spi-fsl-spi.c
> > +++ b/drivers/spi/spi-fsl-spi.c
> > @@ -933,7 +933,7 @@ err:
> >
> >  static void fsl_spi_cs_control(struct spi_device *spi, bool on)
> >  {
> > -   struct device *dev = spi->dev.parent;
> > +   struct device *dev = spi->dev.parent->parent;
> >     struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
> >     u16 cs = spi->chip_select;
> >     int gpio = pinfo->gpios[cs];
> 
> So it seems
> Acked-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> 

Applied, thanks.

g.


-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
