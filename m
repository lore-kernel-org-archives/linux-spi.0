From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Wed, 12 May 2010 18:28:51 +0200
Message-ID: <OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100512162231.GA449-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/12 18:22:31:
>
> On Wed, May 12, 2010 at 05:50:50PM +0200, Joakim Tjernlund wrote:
> > tx_dma/rx_dma are already set to a dummy buffer when no
> > tx/rx buffer and t->tx_dma/t->rx_dma does not contain a dma
> > address, but NULL.
> > This may lead to corruption of kernel memory. Fix this by
> > leaving tx_dma/rx_dma alone.
> >
> > Do not INIT_TX_RX while controller is enabled, this is bad according
> > to the MPC8321 manual.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
>
> Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Thanks!
:)

Who will make sure this goes to Linus?

 Jocke

BTW, I am having another problem too. An ADC doesn't work when in QE/CPM mode(CPU mode is fine)
The only thing I can think of ATM is if word size is handled differently? We
are using 16 bits words.


------------------------------------------------------------------------------
