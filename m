From: Stanimir Varbanov <svarbanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Fri, 27 Feb 2015 16:46:17 +0200
Message-ID: <54F08339.5020708@mm-sol.com>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org> <20150224135622.GH6236@finisterre.sirena.org.uk> <54ECA216.306@linaro.org> <20150226023317.GE6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150226023317.GE6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/26/2015 04:33 AM, Mark Brown wrote:
> On Tue, Feb 24, 2015 at 06:08:54PM +0200, Stanimir Varbanov wrote:
> 
>> yes, there is a potential race between atomic_inc and dma callback. I
>> reordered these calls to save few checks, and now it returns to me.
> 
>> I imagine few options here:
> 
>>  - reorder the dmaengine calls and atomic operations, i.e.
>> call atomic_inc for rx and tx channels before corresponding
>> dmaengine_submit and dmaengine_issue_pending.
> 
>>  - have two different dma callbacks and two completions and waiting for
>> the two.
> 
>>  - manage to receive only one dma callback, i.e. the last transfer in
>> case of presence of the rx_buf and tx_buf at the same time.
> 
>>  - let me see for better solution.
> 
> Any solution which doesn't make use of atomics is likely to be better,
> as I said they are enormously error prone.  A more common approach is a
> single completion triggering on the RX (for RX only or bidirectional
> transfers) or TX if that's the only thing active.  For most hardware you
> can just use the RX to manage completion since it must of necessity
> complete at the same time as or later than the transmit side, transmit
> often completes early since the DMA completes when the FIFO is full not
> when the data is on the wire.
> 

yep, that's what I wanted to express in third option above.

-- 
regards,
Stan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
