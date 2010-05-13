From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Thu, 13 May 2010 11:36:15 +0200
Message-ID: <OFD4A1BD4A.1E890808-ONC1257722.00336F58-C1257722.0034C1F5@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100512164321.GA5522-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/12 18:43:21:
>
> On Wed, May 12, 2010 at 06:28:51PM +0200, Joakim Tjernlund wrote:
> > Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/12 18:22:31:
> > >
> > > On Wed, May 12, 2010 at 05:50:50PM +0200, Joakim Tjernlund wrote:
> > > > tx_dma/rx_dma are already set to a dummy buffer when no
> > > > tx/rx buffer and t->tx_dma/t->rx_dma does not contain a dma
> > > > address, but NULL.
> > > > This may lead to corruption of kernel memory. Fix this by
> > > > leaving tx_dma/rx_dma alone.
> > > >
> > > > Do not INIT_TX_RX while controller is enabled, this is bad according
> > > > to the MPC8321 manual.
> > > >
> > > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> > >
> > > Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >
> > > Thanks!
> > :)
> >
> > Who will make sure this goes to Linus?
>
> I guess it's Grant. Cc'ed.
>
> >  Jocke
> >
> > BTW, I am having another problem too. An ADC doesn't work when in QE/CPM
> mode(CPU mode is fine)
> > The only thing I can think of ATM is if word size is handled differently? We
> > are using 16 bits words.
>
> No idea. Have you tried loopback mode? Create a dummy spidev
> device, and try Documentation/spi/spidev_test.c's --loop switch.
>
> Personally I tested QE/CPM mode with M25Pxx flashes. IIRC, I
> also tested it with the spi_mmc driver on MPC8323E-RDB board.
> Both drivers work with 8 bits words.

The new QE mode is so broken :(
This is spidev run with the original CPU mode somewhat shorten:

root@localhost:~# ./spidev -D /dev/spidev0.3 -b 8
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)

01 9D C0 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 16
spi mode: 0
bits per word: 16
max speed: 500000 Hz (500 KHz)

01 9D E0 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 32
spi mode: 0
bits per word: 32
max speed: 500000 Hz (500 KHz)

01 9D C0 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 8 -L
spi mode: 8
bits per word: 8
max speed: 500000 Hz (500 KHz)

80 B9 03 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 16 -L
spi mode: 8
bits per word: 16
max speed: 500000 Hz (500 KHz)

B9 80 00 07 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 32 -L
spi mode: 8
bits per word: 32
max speed: 500000 Hz (500 KHz)

00 03 B9 80 00 00


This is the new QE mode:

root@localhost:~# ./spidev -D /dev/spidev0.3 -b 8
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)

01 9D E0 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 16
spi mode: 0
bits per word: 16
max speed: 500000 Hz (500 KHz)

9D 01 00 C0 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 32
spi mode: 0
bits per word: 32
max speed: 500000 Hz (500 KHz)

00 C0 9D 01 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 8 -L
spi mode: 8
bits per word: 8
max speed: 500000 Hz (500 KHz)

80 B9 07 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 16 -L
spi mode: 8
bits per word: 16
max speed: 500000 Hz (500 KHz)

80 B9 03 00 00 00
root@localhost:~# ./spidev -D /dev/spidev0.3 -b 32 -L
spi mode: 8
bits per word: 32
max speed: 500000 Hz (500 KHz)

80 B9 03 00 00 00


Notice how the byte order is swapped for word = 16, 32
Not even sure what is right to begin with :)
Can't see how one should fix this either.

 Jocke


------------------------------------------------------------------------------
