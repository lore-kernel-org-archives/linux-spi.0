From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: Make core DMA mapping functions generate scatterlists
Date: Wed, 5 Feb 2014 07:30:57 +0100
Message-ID: <201402050730.57398.marex@denx.de>
References: <1391349172-27668-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lukasz Czerwinski <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391349172-27668-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sunday, February 02, 2014 at 02:52:52 PM, Mark Brown wrote:

Hi, thanks for preparing this patch!

I have just a few very minor nitpicks, ignore if you please.

[...]
 
> +static int spi_map_buf(struct spi_master *master, struct device *dev,
> +		       struct sg_table *sgt, void *buf, size_t len,
> +		       enum dma_data_direction dir)
> +{
> +	const bool vmalloced_buf = is_vmalloc_addr(buf);
> +	const int desc_len = vmalloced_buf ? PAGE_SIZE : master->max_dma_len;

You might want to rename this to "sg_chunk_max_size" or something, "desc_len" 
doesn't make much sense here. The variable describes the maximum size of one 
single scatterlist element.

> +	const int sgs = DIV_ROUND_UP(len, desc_len);

Looking at this, the variables could generally use a more meaningful name. I 
think it'd be clearer to call this "num_sg_chunks" or so ?

> +	struct page *vm_page;
> +	void *sg_buf;
> +	size_t min;
> +	int i, ret;
> +
> +	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
> +	if (ret != 0)
> +		return ret;
> +
> +	for (i = 0; i < sgs; i++) {
> +		min = min_t(size_t, len, desc_len);
> +
> +		if (vmalloced_buf) {
> +			vm_page = vmalloc_to_page(buf);

Just curious, but shouldn't we check if buf != NULL right at the begining of 
this function?

[...]

> +static void spi_unmap_buf(struct spi_master *master, struct device *dev,
> +			  struct sg_table *sgt, enum dma_data_direction dir)
> +{
> +	if (sgt->orig_nents) {

I don't want to nag, but why not use if (!sgt->...) return; ? This would cut 
down one level of indent.

> +		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
> +		sg_free_table(sgt);
> +	}
> +}
> +

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
