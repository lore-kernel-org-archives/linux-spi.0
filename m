From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Remove duplicate spi_imx_data definition
Date: Tue, 27 Mar 2012 16:04:51 -0600
Message-ID: <20120327220451.20B583E13FC@localhost>
References: <1332785632-17799-1-git-send-email-fabio.estevam@freescale.com>
	<20120326205940.GM15647@pengutronix.de>
	<4F7123BE.8090608@freescale.com>
	<20120327070135.GN15647@pengutronix.de>
Content-Type: multipart/mixed; boundary="===============0081232117448766654=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120327070135.GN15647-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============0081232117448766654==

On Tue, 27 Mar 2012 09:01:35 +0200, Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Hello Fabio,
> 
> On Mon, Mar 26, 2012 at 11:19:42PM -0300, Fabio Estevam wrote:
> > On 3/26/2012 5:59 PM, Uwe Kleine-König wrote:
> > 
> > > In my version of drivers/spi/spi-imx.c struct spi_imx_data is only
> > > defined once. I guess you wanted to say "forward declaration".
> > 
> > Yes, correct.
> > 
> > ...
> > 
> > > Does this really work? struct spi_imx_data has a member
> > 
> > Yes, tested it on a mx31pdk board.
> Strange, I can confirm it compiles without warnings. Even sparse doesn't
> complain about it. I don't understand it. *shrug*

Still doesn't look right though because there needs to be a forward
declaration for spi_imx_devtype_data before it is used.  I'm not going
to apply.

g.



--===============0081232117448766654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============0081232117448766654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0081232117448766654==--
