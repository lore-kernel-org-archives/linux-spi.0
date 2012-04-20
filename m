From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-rspi: add dmaengine supporting
Date: Fri, 20 Apr 2012 13:14:09 +0900
Message-ID: <4F90E291.6020302@renesas.com>
References: <4F8FE77D.7020000@renesas.com>
	<20120420013610.GE22189@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20120420013610.GE22189-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2012/04/20 10:36, Paul Mundt wrote:
> On Thu, Apr 19, 2012 at 07:22:53PM +0900, Shimoda, Yoshihiro wrote:
>> +static struct dma_async_tx_descriptor *rspi_dma_prep_sg(struct scatterlist *sg,
>> +				void *buf, unsigned len, struct dma_chan *chan,
>> +				enum dma_transfer_direction dir)
>> +{
>> +	sg_init_table(sg, 1);
>> +	sg_set_buf(sg, buf, len);
>> +	sg_dma_len(sg) = len,
>> +	dma_map_sg(chan->device->dev, sg, 1, dir);
>> +	return dmaengine_prep_slave_sg(chan, sg, 1, dir,
>> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +}
>> +
> ..
> 
>> +	desc = rspi_dma_prep_sg(&sg, buf, len, rspi->chan_tx, DMA_TO_DEVICE);
>> +	if (!desc) {
>> +		ret = -EIO;
>> +		goto error;
>> +	}
>> +
> ..
>> +error:
>> +	if (rspi->dma_width_16bit)
>> +		kfree(buf);
>> +
>> +	return ret;
>> +}
>> +
> The sg list handling is unbalanced. Specifically you always map the
> scatterlist with dma_map_sg() but you have no corresponding
> dma_unmap_sg() anywhere, either in the error path or your regular exit
> path.
> 

Thank you for the point. I will fix this.

Best regards,
Yoshihiro Shimoda

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
