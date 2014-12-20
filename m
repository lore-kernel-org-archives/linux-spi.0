From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFT] spi: dw: Fix off-by-one for checking fifo depth
Date: Sat, 20 Dec 2014 10:17:59 +0800
Message-ID: <CAFRkauAeny6cSrqDq=NpNrx2eyZ8sCzoWzH_KpTxTreuXuWwMQ@mail.gmail.com>
References: <1418976099.23257.4.camel@phoenix>
	<1418989567.17201.71.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418989567.17201.71.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-12-19 19:46 GMT+08:00 Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> On Fri, 2014-12-19 at 16:01 +0800, Axel Lin wrote:
>> The fifo depth could be from 2 to 256 from HW spec, so fix off-by-one for
>> checking fifo depth.
>> Without this patch, fifo is 258 after for loop iteration for the "no-match"
>> case. So below line does not catch the "no-match" case.
>>         dws->fifo_len = (fifo == 257) ? 0 : fifo;
>
> Seems reasonable, but never tried because in case of Medfield device we
> have fifo size defined.
>
> I would try this in January.

hi Andy,

I check the code again and I think what current code does is:
It tries to find the highest valid fifo depth so it checks the value it wrote
to DW_SPI_TXFLTR. I think the valid value range is 2 ~ 256.
So it will break out when writing 257 to DW_SPI_TXFLTR.

There is an off-by-one in dws->fifo_len setting because it assumes the
latest register write fails so the latest valid value is fifo - 1.

So I think you can set dws->fifo_len to 0 to test current behavior first.

I guess below change should work, please test this instead my previous patch.

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index d0d5542..1a0f266 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -621,13 +621,13 @@ static void spi_hw_init(struct dw_spi *dws)
  if (!dws->fifo_len) {
  u32 fifo;

- for (fifo = 2; fifo <= 257; fifo++) {
+ for (fifo = 2; fifo <= 256; fifo++) {
  dw_writew(dws, DW_SPI_TXFLTR, fifo);
  if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
  break;
  }

- dws->fifo_len = (fifo == 257) ? 0 : fifo;
+ dws->fifo_len = (fifo == 2) ? 0 : fifo - 1;
  dw_writew(dws, DW_SPI_TXFLTR, 0);
  }
 }

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
