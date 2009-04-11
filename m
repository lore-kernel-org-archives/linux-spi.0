From: Mok Keith <ek9852@gmail.com>
Subject: Re: [spi-devel-general] kernel-panic on pxa2xx_spi.c on pxa9xx cpu
	with dma enable
Date: Sat, 11 Apr 2009 10:23:44 +0800
Message-ID: <69f617130904101923t1c05f2ebicbc2d16e82f03e54@mail.gmail.com>
References: <69f617130904042032o382f5084v4fe21884e2356c77@mail.gmail.com>
	<49D8E537.1010307@whoi.edu>
	<69f617130904051922w72810b52v576546c10c069941@mail.gmail.com>
	<49DCC09D.1040701@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-kernel@lists.arm.linux.org.uk,
	spi-devel-general@lists.sourceforge.net
To: Ned Forrester <nforrester@whoi.edu>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <49DCC09D.1040701@whoi.edu>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Hi Ned,

Thanks for your detailed description.
I encounter no more dma fifo overflow after enlarge timeout value to
1000, but still get no response from spi device
after firmware is downloaded.
(I can get response using pure I/O, i.e. enable_dma=3D0 and dma_burst_size=
=3D0):

> Try setting dma_burst_size to 16. =A0That will compute tx and rx
> thresholds of 8, representing half the FIFO. =A0That is the way I normally
> use the driver. =A0If there is a bug in the computation of burst and
> threshold, then this might change the behavior.
I tried it before with different combination:
dma_burst_size=3D16, tx_threshold=3D7, rx_threshold=3D8
dma_burst_size=3D16, tx_threshold=3D1, rx_threshold=3D1
dma_burst_size=3D16, tx_threshold=3D0, rx_threshold=3D0
dma_burst_size=3D8, tx_threshold=3D0, rx_threshold=3D0
dma_burst_size=3D, tx_threshold=3D1, rx_threshold=3D1
dma_burst_size=3D16, tx_threshold=3D8, rx_threshold=3D8

All gives same result. (after firmware download to spi device, no response)

> You did not show your values for struct pxa2xx_spi_master. =A0I assume you
> have enable_dma =3D 1, in this structure.
Yes I did it.


> On the PXA255, running at 400MHz, I carefully
> measured the clock (using long timeouts) to be 99.5MHz, which is
> run-clock/4. =A0I have no idea what clock is used on a PXA3xx or PXA9xx.
In PXA9xx manual, it states that timeout equals to value/26MHz.
So I enlarge it to 1000, no more dma fifo overrun now, but still
cannot get spi device work under dma mode.

The PXA9XX manual said that TXFIFO overruns and RXFIFO underruns are
silent errors.
There is no indication of the overrun or underrun condition other than
missing data
at the receiving end of the link. I don't know whether I fall into
this trap or not.

Any clue ?

Keith

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
