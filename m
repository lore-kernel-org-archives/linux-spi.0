From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Thu, 7 Jul 2016 10:58:02 -0500
Message-ID: <577E7C0A.2000103@ti.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
 <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
 <577D3B5C.7080805@ti.com>
 <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
 <577D5E78.2010307@ti.com> <871t368lu6.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Ming Lin <ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871t368lu6.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 07/06/2016 05:04 PM, Robert Jarzmik wrote:
> "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org> writes:
> 
>> Unfortunately, for the original purpose of this series the scatterlist I
>> want to clone is indeed DMA mapped.
>>
>> The times I've seen dma_length != length is when the dma_map_sg is
>> trying to combine contiguous sgl (ex ppc_iommu_map_sg and dma_map_cont).
>> So maybe it is better to subtract a value from length and dma_length
>> rather than explicitly setting it to a value. This way it wouldn't
>> matter that dma_length and length aren't equal.
>>
>> This looks like a similar approach used by sg_split_mapped. Although
>> sg_split skips first x number of bytes while I want to skip the last x
>> number of bytes.
>>
>> Maybe Robert can add his thoughts since he created sg_split.
> 
> Hi,
> 
> I've not read it all, but the above chapter is right : dma_length might be
> different from length when a dma mapping operation coallesced 2 sg entries into
> a "DMA contiguous one". This coallescing might happen for at least for 2 reasons
> as far as I know :
>  - 2 sg entries are physically contiguous, ie :
>    sg_phys(sga) + sga.length == sg_phys(sgb)
>  - 2 sg entries are DMA contiguous when an IOMMU maps them contiguously, ie :
>    sg_dma_address(sga) + sga.length == sg_dma_address(sgb)
> 
> Moreover, this 2 coallescing cases imply a "shift" between (page_link, length)
> and (dma_address and dma_length). For example a mapped sglist might look like :
>  -sg0: page_link=>page@0k, length=4096, dma_address=0, dma_length=8192
>  -sg1: page_link=>page@4k, length=4096, dma_address=8192, dma_length=16
>                                                           \=> see the shift here
>                                                               coming from sg2
>  -sg2: page_link=>page@8k, length=16, dma_address=0, dma_length=0
> 
> For these "tricky" cases, at the time I created sg_split I had done a tester as
> well. It's very basic, doesn't cover all the corner cases, is a bit dumb, but
> you might have a look, and the brain cost you'll pay to adapt it to test what
> you want will hopefully pay off by the knowledge gained on scatterlist. It is
> appended at the end of the mail.


Thanks Robert for your input and sharing your test program. After
looking at sg_split and test program I realized that I can use it
instead of creating my own clone function. Seems like you and your patch
reviewers already considered and dealt with the above complex scenario.

I updated my patchset to use sg_split rather than my custom function
since it seems to solve my original problem. I plan on sending out a v3
that incorporates this change.
> 
> Cheers.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
