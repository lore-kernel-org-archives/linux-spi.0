From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Thu, 27 Mar 2014 18:24:16 +0100
Message-ID: <20140327172416.GW3998@book.gsilab.sittig.org>
References: <1395932757.17331.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395932757.17331.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2014-03-27 at 23:05 +0800, Axel Lin wrote:
> 
> Refactor to use default implementation of transfer_one_message() which provides
> standard handling of delays and chip select management.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
> Hi Gerhard and Anatolij,
> I don't have this h/w. I'd appreciate if you can test this patch.
> 
> Thanks,
> Axel

although the change appears to work (LCD and SPI flash remain
operational), it dramatically reduces throughput (increase of
transfer time from 10 to 150 seconds)

before:

  root@ac14xx:~# uname -srm
  Linux 3.14.0-rc8-00011-gf217c44ebd41 ppc
  root@ac14xx:~# time wc /dev/mtd6
	 23        68  16777216 /dev/mtd6
  real    0m 9.87s
  user    0m 0.68s
  sys     0m 0.17s
  root@ac14xx:~# time dd if=/dev/mtd6 of=/dev/null bs=1024
  16384+0 records in
  16384+0 records out
  real    0m 10.11s
  user    0m 0.04s
  sys     0m 0.55s

after:

  root@ac14xx:~# uname -srm 
  Linux 3.14.0-rc8-00012-gc47c572ff209 ppc
  root@ac14xx:~# time wc /dev/mtd6
	 23        68  16777216 /dev/mtd6
  real    2m 34.97s
  user    0m 0.00s
  sys     0m 0.94s
  root@ac14xx:~# time dd if=/dev/mtd6 of=/dev/null bs=1024
  16384+0 records in
  16384+0 records out
  real    3m 17.11s
  user    0m 0.00s
  sys     0m 0.91s

can you reproduce this on other hardware?  the change looks
innocent, and the core routine looks straight forward -- is some
expensive diagnostics enabled ATM during transition to common
logic?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
