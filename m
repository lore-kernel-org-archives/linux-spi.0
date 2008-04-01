From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] Much improved mpc83xx SPI driver.
Date: Tue, 01 Apr 2008 14:43:42 +0200
Message-ID: <1207053822.9675.41.camel@gentoo-jocke.transmode.se>
References: <>
	<1205482942-29471-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1205841511.7589.92.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org  " "linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org spi-devel-general" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1205841511.7589.92.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Tue, 2008-03-18 at 12:58 +0100, Joakim Tjernlund wrote:
> On Fri, 2008-03-14 at 09:22 +0100, Joakim Tjernlund wrote:
> > Current driver may cause glitches on SPI CLK line since
> > one must disable the SPI controller before changing any HW settings.
> > Fix this by impl. a local spi_transfer function that won't allow
> > changing speed and/or word size while CS is active.
> > 
> > While doing that heavy lifting a few other issues were addressed to:
> > Make word size 16 and 32 work too.
> > Honor bits_per_word and speed_hz in spi transaction.
> > Optimize the common path.
> > 
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> > ---
> > 
> > This patch is against 2.6.23 so some trivial fixups might be needed
> > to apply.
> > David B., this is an updated patch.
> > I am sending this to the major contributors of the mpc83xx driver. 
> >  drivers/spi/spi_mpc83xx.c |  398 ++++++++++++++++++++++++++++++---------------
> >  1 files changed, 270 insertions(+), 128 deletions(-)
> > 
> > diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> 
> Ping?
> 
> Is there a chance to get it into 2.6.25?
> 
>  Jocke

I guess this isn't going to make .25 after all, but .26 would be nice.
Anyone wants to take care of this patch?

  Jocke

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
