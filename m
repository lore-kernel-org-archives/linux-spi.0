From: Mok Keith <ek9852-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel-panic on pxa2xx_spi.c on pxa9xx cpu
	with dma enable
Date: Mon, 6 Apr 2009 10:22:29 +0800
Message-ID: <69f617130904051922w72810b52v576546c10c069941@mail.gmail.com>
References: <69f617130904042032o382f5084v4fe21884e2356c77@mail.gmail.com>
	<49D8E537.1010307@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49D8E537.1010307-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Ned,

> Is your application using the SSP in some unusual way that allows the RX
> FIFO to overrun? =A0I am not familiar with any PXA9xx chips. =A0What clock
> speed are you using. =A0What timeout setting are you using? =A0Are you us=
ing
> power management with suspend/resume?

No, it is not allow RX FIFO overrun.

Here is the settings in arch:
static struct pxa2xx_spi_chip libertas_spi=3D {
        .tx_threshold           =3D 7,
        .rx_threshold           =3D 8,
        .cs_control             =3D libertas_spi_cs,
        .dma_burst_size         =3D 8,
        .timeout                =3D 230,
};

Here is the settings in driver:
        spi->mode =3D SPI_MODE_0;
        spi->max_speed_hz =3D 1000000; /* REVISIT max=3D50MHz */
        spi->bits_per_word =3D 16;
        ret =3D spi_setup(spi);

I set the speed to : "spi->max_speed_hz =3D 1000000;" only, should be very =
low.
No power management has been enable, it just happen at the very
beginning during firmware download to chip.
I got a hint that if I enlarge the timeout to 1000, panic will not
happen and FIFO overrun
will not happen. But the chip just cannot run after firmware
downloaded. (It is okay in pure PIO mode).

>
> I have seen FIFO overruns in my application, but I use a heavily
> modified version of pxa2xx_spi.c that implements descriptor-fetch DMA,
> enables external clocks, and uses read-without-transmit (RWOT) mode, to
> collect data from an 11Mbit/sec external master.

No modification to pxa2xx_spi.c in my case.

> Are you sure that your transfers are actually operating in DMA mode?
> The driver reverts to PIO mode for any transfer that exceeds 8191bytes
> in length.

I am sure it is in DMA mode since it hangs up during download of
firmware to the chip
which has length around 512 bytes only and is dma aligned. I had
already add printk and
confirm it.


> I would bet that the fundamental cause of your problem is the FIFO
> overrun. =A0With some more information about your setup and use of
> pxa2xx_spi, I might be able to provide more clues. =A0I would hesitate to
> simply patch the above assignments without first understanding why
> pump_transfers() is being executed out of sequence.

I agree, it is meaningless to just add a null pointer checking without
knowning the execution sequence that leads to the problem.

Thanks,
Keith

---------------------------------------------------------------------------=
---
