From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: spi: tests driver to test basic alignment/length issues via loopback
Date: Wed, 25 Nov 2015 19:56:22 +0100
Message-ID: <753FCC7B-67D9-495B-A6C1-D49793502C90@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

While writing a patch that allows spi_masters (and maybe also the
framework) to modify a submitted spi_message so that the resulting
spi_message fits the =E2=80=9Climitations=E2=80=9D of the HW (this basi=
cally works
already, but I still need to split it into several patches and run
further testing before submitting...) I had to generate a test
harness to make sure that all situations were taken care of properly.

So I had to write a small test driver that allows for generate all sort=
s
of spi_messages with different length, rx/tx_buf alignments and more to
get generated - right now it submits something like 360 distinct
spi_messages:
* transfers starting on a page with rx and tx_buf set
  * length: 1, 16, 32, 64, 128, 256, 1024, 4096, 128k
  * alignment of rx_buf/tx_buf to 0, 1, 2, 3 ([0:sizeof(int)[)
    (if your spi_master defines dma_alignment, then [0:dma_alignment[)
  * a total of 144 spi-messages
* transfer starting on (page_size - 4) with rx and tx_buf set
  * same as above
  * a total of 144 spi-messages
* tx-only transfers
  * same as above, but only alignment for tx
  * total of 36 spi-messages
* rx-only transfers
  * same as above, but only alignment for rx
  * total of 36 spi-messages

Currently no multi-transfers are tested, but in principle these can=20
get defined very easily.

It is quite extensible and has already helped me identify some regressi=
ons
that the =E2=80=9Cmodify=E2=80=9D framework was introducing on the rasp=
berry Pi.

=46or complete testing the only thing it requires is  MOSI connected to=
 MISO.
and then it can detect lots of situations:
* incomplete writes in rx_buf
* writes outside of spi_transfer.rx_buf (dma writing to much)
* alignment issues

There is also several distinct tx-payload generators that can get used =
to
identify some issues - it may also help when using a logic-analyzer to =
see
the data that is really sent out.

Obviously it is not perfect and is only tested using 4 wire mode, but i=
t
may act as a =E2=80=9Ctool=E2=80=9D to test for some basic regressions.

So I wonder if there would be some interest in having such a test drive=
r
in the kernel for use during spi_master development.

If interested, you can have a look at: https://github.com/msperl/spi-te=
st <https://github.com/msperl/spi-test>
and if that seems to fulfill a requirement, then I can submit it as a
patch.

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
