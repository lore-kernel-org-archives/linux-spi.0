From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] spi: spi-ti-qspi: Add DMA support for QSPI mmap
 read
Date: Wed, 27 Apr 2016 10:34:44 +0530
Message-ID: <5720486C.1040104@ti.com>
References: <1461577442-8853-1-git-send-email-vigneshr@ti.com>
 <1461577442-8853-4-git-send-email-vigneshr@ti.com>
 <CAHp75Vc=1QnKtQ=E6FgKj5=LqVkdEp4mciYi2adgdTo8Z5C7Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vc=1QnKtQ=E6FgKj5=LqVkdEp4mciYi2adgdTo8Z5C7Ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 04/26/2016 08:16 PM, Andy Shevchenko wrote:
> On Mon, Apr 25, 2016 at 12:44 PM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>> Use mem-to-mem DMA to read from flash when reading in mmap mode. This
>> gives improved read performance and reduces CPU load.
>>
>> With this patch the raw-read throughput is ~16MB/s on DRA74 EVM. And CPU
>> load is <20%. UBIFS read ~13 MB/s.
> 
>> +static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
>> +                           dma_addr_t dma_src, size_t len)
>> +{
>> +       struct dma_chan *chan = qspi->rx_chan;
>> +       struct dma_device *dma_dev = chan->device;
>> +       dma_cookie_t cookie;
>> +       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> 
>> +       struct dma_async_tx_descriptor *tx = NULL;
> 
> Redundant assignment.
> 
>> +       int ret;
>> +
>> +       tx = dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
>> +                                            len, flags);
> 
> Can you use dmaengine API wrappers?
> 
>> +       if (!tx) {
>> +               dev_err(qspi->dev, "device_prep_dma_memcpy error\n");
>> +               ret = -EIO;
>> +               goto err;
>> +       }
>> +
>> +       tx->callback = ti_qspi_dma_callback;
>> +       tx->callback_param = qspi;
>> +       cookie = tx->tx_submit(tx);
>> +
>> +       ret = dma_submit_error(cookie);
>> +       if (ret) {
>> +               dev_err(qspi->dev, "dma_submit_error %d\n", cookie);
>> +               goto err;
>> +       }
>> +
>> +       dma_async_issue_pending(chan);
>> +       ret = wait_for_completion_timeout(&qspi->transfer_complete,
>> +                                         msecs_to_jiffies(len));
>> +       if (ret <= 0) {
>> +               dmaengine_terminate_all(chan);
>> +               dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
>> +               if (!ret)
>> +                       ret = -ETIMEDOUT;
>> +               goto err;
>> +       }
>> +
>> +       ret = 0;
>> +
> 
>> +err:
>> +       return ret;
> 
> Are you planning to have a lock here? Otherwise remove this.
> 
>> +}
>> +
>> +static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table rx_sg,
>> +                              loff_t from)
>> +{
>> +       struct scatterlist *sg;
>> +       dma_addr_t dma_src = qspi->mmap_phys_base + from;
>> +       dma_addr_t dma_dst;
>> +       int i, len, ret = 0;
> 
> Redundant assignment, see below.
> 
>> +
>> +       for_each_sg(rx_sg.sgl, sg, rx_sg.nents, i) {
>> +               dma_dst = sg_dma_address(sg);
>> +               len = sg_dma_len(sg);
>> +               ret = ti_qspi_dma_xfer(qspi, dma_dst, dma_src, len);
>> +               if (ret)
>> +                       return ret;
>> +               dma_src += len;
>> +       }
>> +
>> +       return ret;
> 
> return 0;
> 
>> +}
> 
> [...]
> 
>> +err:
> 
> exit_unlock or err_unlock.
> 
>>         mutex_unlock(&qspi->list_lock);
>>
>>         return ret;
> 

I will fix all the issues in the next version. Will wait couple of days
for further comments if any
Thanks for the review!


-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
