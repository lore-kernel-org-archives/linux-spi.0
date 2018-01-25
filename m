From: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Subject: Issue with spi_map_buf
Date: Thu, 25 Jan 2018 15:47:54 +0100
Message-ID: <20180125154754.48a30b23@smile-e5570>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi everyone,

While developing support for DMA transfers in the SPI controller for
armada 3700, I stumbled on an issue with the way buffers are splitted
into scatterlists in drivers/spi/spi.c, and I would like some
knowledgeable people to take a quick look at this (I don't really know
how to solve this) :

In the function spi_map_buf [1] :

The issue boils down to this (for the sake of clarity, I simplified the
function by taking the following assumptions :

- We work on a vmalloced buffer
- max_seg_size < PAGE_SIZE
- len > max_seg_size (len is size of the buffer we want to split)

desc_len = min_t(int, max_seg_size, PAGE_SIZE);

sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);

for (i = 0; i < sgs; i++) {

	min = min_t(size_t,
		    len, desc_len - offset_in_page(buf));
		    
	vm_page = vmalloc_to_page(buf);
			
	sg_set_page(sg, vm_page,
		    min, offset_in_page(buf));

	buf += min;
	len -= min;
	sg = sg_next(sg);
}

The 'min' variable computation seems incorrect when max_seg_size is less
than PAGE_SIZE, in particular the "desc_len - offset_in_page(buf)",
which should be something like "(len % PAGE_SIZE) - offset_in_page(buf)"

Unfortunately, this start to be complex if we want to take all possible
cases into account : If we want to split a buffer in segments, where
some might cross page boundaries, how do we know how much sg elements
will there be ?

I thought about using something like  __sg_alloc_table_from_pages, but
the "max_segment" parameter is expected to be page aligned, which is not
the case here.

Another solution would be to iterate twice, one to find out how much
elements there will be, then allocate the scatterlist, then fill it.

I also might be overthinking or musunderstanding this, so any help on
this issue is welcome.

I found this issue with a prototype implementation of SPI DMA xfers on
armada 3700, using fpga-pgr as a spi device. In my case, max_seg_size is
set to 512 bytes.

This should occur with other DMA / SPI controllers, as long as the
max_seg_size is less than PAGE_SIZE.

Thanks,

Maxime

[1] :
http://elixir.free-electrons.com/linux/v4.15-rc9/source/drivers/spi/spi.c#L743
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
