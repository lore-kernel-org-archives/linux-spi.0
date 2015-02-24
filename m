From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 18:08:54 +0200
Message-ID: <54ECA216.306@linaro.org>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org> <20150224135622.GH6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150224135622.GH6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/24/2015 03:56 PM, Mark Brown wrote:
> On Tue, Feb 24, 2015 at 03:00:03PM +0200, Stanimir Varbanov wrote:
> 
>> +static void spi_qup_dma_done(void *data)
>> +{
>> +	struct spi_qup *qup = data;
>> +
>> +	if (atomic_dec_and_test(&qup->dma_outstanding))
>> +		complete(&qup->done);
>> +}
> 
> I'm finding it hard to be thrilled about the use of atomics for
> synchronization (they're just generally hard to work with) and...
> 
>> +	cookie = dmaengine_submit(desc);
>> +	ret = dma_submit_error(cookie);
>> +	if (ret)
>> +		return ret;
> 
>> +	atomic_inc(&qup->dma_outstanding);
> 
> ..don't we have two potential races here: one if somehow the DMA manages
> to complete prior to the atomic_inc() (unlikely but that's what race
> conditions are all about really) and one if we are issuing multiple DMAs
> and the early ones complete before the later ones are issued?
> 

yes, there is a potential race between atomic_inc and dma callback. I
reordered these calls to save few checks, and now it returns to me.

I imagine few options here:

 - reorder the dmaengine calls and atomic operations, i.e.
call atomic_inc for rx and tx channels before corresponding
dmaengine_submit and dmaengine_issue_pending.

 - have two different dma callbacks and two completions and waiting for
the two.

 - manage to receive only one dma callback, i.e. the last transfer in
case of presence of the rx_buf and tx_buf at the same time.

 - let me see for better solution.

Thanks for the comments.

regards,
Stan



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
