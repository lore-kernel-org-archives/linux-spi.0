From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Date: Mon, 16 Mar 2020 14:25:02 +0100
Message-ID: <d05fda0e119405343e540b9768db534f@walle.cc>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
 <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk>
 <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-16 14:00, schrieb Vladimir Oltean:
> On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> 
>> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
>> 
>> > Correct, the real problem is that I forgot to add a Fixes: tag for
>> > patch 5. I'll do that now.
>> 
>> OK.  The series otherwise looked fine but I'll wait for testing.
>> Michael, if there's issues remaining it might be good to get some
>> Tested-bys for the patches prior to whatever's broken so we can get
>> those fixes in (but obviously verifying that is work so only if you
>> have time).

I'm just about to test it. While my former "cat /dev/mtdN > /dev/null"
is working. I had the impression that it was slower, so I tried to test
it with dd now and a known chunk size.. only to find out that it is
still not working:

# dmesg|grep spi
[    1.894891] spi-nor spi1.0: w25q128fw (16384 Kbytes)
..
# time cat /dev/mtd0 > /dev/null
real    0m 30.73s
user    0m 0.00s
sys     0m 1.02s
# dd if=/dev/mtd0 of=/dev/null bs=64
262144+0 records in
262144+0 records out
# dd if=/dev/mtd0 of=/dev/null bs=64
262144+0 records in
262144+0 records out
# dd if=/dev/mtd0 of=/dev/null bs=64
dd: /dev/mtd0: Input/output error

I also wanted to test how it behaves if there are multiple processes
access the /dev/mtdN device. I haven't found the time to dig into
the call chain if see if there is any locking. Because what happens
if transfer_one_message() is called twice at the same time from two
different processes?

> 
> This time I verified with a protocol analyzer all transfer lengths
> from 1 all the way to 256, with this script:
> 
> #!/bin/bash
> 
> buf=''
> 
> for i in $(seq 0 255); do
> »       buf="${buf}\x$(printf '%02x' ${i})"
> »       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
> 5000000 -p "${buf}"
> done
> 
> It looked fine as far as I could tell, and also the problems
> surrounding Ctrl-C are no longer present. Nonetheless it would be good
> if Michael could confirm, but I know that he's very busy too so it's
> understandable if he can no longer spend time on this.

I'm working on it ;)

-michael
