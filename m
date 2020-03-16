From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Date: Mon, 16 Mar 2020 15:00:03 +0200
Message-ID: <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk> <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200316124945.GF5010@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
>
> > Correct, the real problem is that I forgot to add a Fixes: tag for
> > patch 5. I'll do that now.
>
> OK.  The series otherwise looked fine but I'll wait for testing.
> Michael, if there's issues remaining it might be good to get some
> Tested-bys for the patches prior to whatever's broken so we can get
> those fixes in (but obviously verifying that is work so only if you
> have time).

This time I verified with a protocol analyzer all transfer lengths
from 1 all the way to 256, with this script:

#!/bin/bash

buf=3D''

for i in $(seq 0 255); do
=C2=BB       buf=3D"${buf}\x$(printf '%02x' ${i})"
=C2=BB       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
5000000 -p "${buf}"
done

It looked fine as far as I could tell, and also the problems
surrounding Ctrl-C are no longer present. Nonetheless it would be good
if Michael could confirm, but I know that he's very busy too so it's
understandable if he can no longer spend time on this.

Thanks,
-Vladimir
