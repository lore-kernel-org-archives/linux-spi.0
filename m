From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Fri, 14 May 2010 14:30:58 +0200
Message-ID: <OF63D31135.40E66F3C-ONC1257723.00441203-C1257723.0044C125@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
	<AANLkTillcDbtpIcq7ZYID9xBpHuGfcBQNNSZJFuyqHYM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTillcDbtpIcq7ZYID9xBpHuGfcBQNNSZJFuyqHYM-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org wrote on 2010/05/13 23:13:52:
>
> On Wed, May 12, 2010 at 6:43 PM, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Wed, May 12, 2010 at 06:28:51PM +0200, Joakim Tjernlund wrote:
> >> Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/12 18:22:31:
> >> >
> >> > On Wed, May 12, 2010 at 05:50:50PM +0200, Joakim Tjernlund wrote:
> >> > > tx_dma/rx_dma are already set to a dummy buffer when no
> >> > > tx/rx buffer and t->tx_dma/t->rx_dma does not contain a dma
> >> > > address, but NULL.
> >> > > This may lead to corruption of kernel memory. Fix this by
> >> > > leaving tx_dma/rx_dma alone.
> >> > >
> >> > > Do not INIT_TX_RX while controller is enabled, this is bad according
> >> > > to the MPC8321 manual.
> >> > >
> >> > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> >> >
> >> > Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> >
> >> > Thanks!
> >> :)
> >>
> >> Who will make sure this goes to Linus?
> >
> > I guess it's Grant. Cc'ed.
>
> Yeah, it's me.  I'm just traveling so I'm a little slow on the uptake
> right now.  I've picked it up.

Thanks, I think it should go to Linus now.

I also just sent another patch, fixing brain dead Little Endian problem
in QE mode. You might want to consider that one too for early inclusion as
potential QE SPI users might start using word size > 8 bits and compensate
for LE in their app.

Anton should first ack it though.

 Jocke


------------------------------------------------------------------------------
