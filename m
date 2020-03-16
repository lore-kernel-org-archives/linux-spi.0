From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Date: Mon, 16 Mar 2020 18:23:48 +0200
Message-ID: <CA+h21hqt7Xe1LrSDsCVS8zqunQp2tKGhmHDraMirxL595go4nA@mail.gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk> <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk> <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
 <d05fda0e119405343e540b9768db534f@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
To: Michael Walle <michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d05fda0e119405343e540b9768db534f@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 16 Mar 2020 at 15:25, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-16 14:00, schrieb Vladimir Oltean:
> > On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
> >>
> >> > Correct, the real problem is that I forgot to add a Fixes: tag for
> >> > patch 5. I'll do that now.
> >>
> >> OK.  The series otherwise looked fine but I'll wait for testing.
> >> Michael, if there's issues remaining it might be good to get some
> >> Tested-bys for the patches prior to whatever's broken so we can get
> >> those fixes in (but obviously verifying that is work so only if you
> >> have time).
>
> I'm just about to test it. While my former "cat /dev/mtdN > /dev/null"
> is working. I had the impression that it was slower, so I tried to test
> it with dd now and a known chunk size.. only to find out that it is
> still not working:
>
> # dmesg|grep spi
> [    1.894891] spi-nor spi1.0: w25q128fw (16384 Kbytes)
> ..
> # time cat /dev/mtd0 > /dev/null
> real    0m 30.73s
> user    0m 0.00s
> sys     0m 1.02s
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> 262144+0 records in
> 262144+0 records out
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> 262144+0 records in
> 262144+0 records out
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> dd: /dev/mtd0: Input/output error

I don't really have a SPI flash connected to DSPI on any LS1028A board.
Is this DMA or XSPI mode?

>
> I also wanted to test how it behaves if there are multiple processes
> access the /dev/mtdN device. I haven't found the time to dig into
> the call chain if see if there is any locking. Because what happens
> if transfer_one_message() is called twice at the same time from two
> different processes?
>

There is a mutex on the SPI bus, and therefore all variants of the
.transfer() call are operating under this lock protection, which
simplifies things quite a bit.

> >
> > This time I verified with a protocol analyzer all transfer lengths
> > from 1 all the way to 256, with this script:
> >
> > #!/bin/bash
> >
> > buf=3D''
> >
> > for i in $(seq 0 255); do
> > =C2=BB       buf=3D"${buf}\x$(printf '%02x' ${i})"
> > =C2=BB       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
> > 5000000 -p "${buf}"
> > done
> >
> > It looked fine as far as I could tell, and also the problems
> > surrounding Ctrl-C are no longer present. Nonetheless it would be good
> > if Michael could confirm, but I know that he's very busy too so it's
> > understandable if he can no longer spend time on this.
>
> I'm working on it ;)
>
> -michael

Thanks,
-Vladimir
