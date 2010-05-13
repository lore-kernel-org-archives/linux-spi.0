From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Thu, 13 May 2010 14:33:51 +0200
Message-ID: <OFC4AE5CC5.5C9876FC-ONC1257722.004405E1-C1257722.0045047E@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
	<OFD4A1BD4A.1E890808-ONC1257722.00336F58-C1257722.0034C1F5@transmode.se>
	<20100513095545.GA11506@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100513095545.GA11506-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/13 11:55:45:
>
> On Thu, May 13, 2010 at 11:36:15AM +0200, Joakim Tjernlund wrote:
> [...]
> > The new QE mode is so broken :(
> > Notice how the byte order is swapped for word = 16, 32
>
> *yawn*, it's not a news... :-) Remember QE-specific rx/tx_shift
> stuff?

How can I forget, I impl. that crap :)

>
> I'm sure the issue is related to how the QE SPI shift register
> works. I.e. SDMA just feeds the shift register, and it's shift
> register that is causing > 8 bits words to misbehave, or the
> issue is in how SDMA and shift registers connected.

Not sure, how one be BE and the LE on byte level?
I wonder if one can play with?
 out_8(&mspi->pram->tfcr, CPMFCR_EB | CPMFCR_GBL);
 out_8(&mspi->pram->rfcr, CPMFCR_EB | CPMFCR_GBL);
>
> > Not even sure what is right to begin with :)
> > Can't see how one should fix this either.
>
> I guess by copying the whole buffer, shifting bytes back and
> forth, remapping it, doing transfer, and copying data back.
> I think that'll work, but no idea how efficient that will be.

Not a chance, better to hardcode 8 bit word size, then one
case will work for all sizes and reject LSB.

>
> Also, I'd not do that for CPM hardware, I tend to believe
> that it's not affected.

Sure, I can't belelive how freescale HW guys managed to screw QE SPI so badly.


------------------------------------------------------------------------------
