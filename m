From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: Make core DMA mapping functions generate scatterlists
Date: Wed, 5 Feb 2014 19:13:20 +0100
Message-ID: <201402051913.20422.marex@denx.de>
References: <1391349172-27668-1-git-send-email-broonie@kernel.org> <201402050730.57398.marex@denx.de> <20140205120002.GH22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lukasz Czerwinski <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140205120002.GH22609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, February 05, 2014 at 01:00:02 PM, Mark Brown wrote:
> On Wed, Feb 05, 2014 at 07:30:57AM +0100, Marek Vasut wrote:
> > On Sunday, February 02, 2014 at 02:52:52 PM, Mark Brown wrote:
> > > +static int spi_map_buf(struct spi_master *master, struct device *dev,
> > > +		       struct sg_table *sgt, void *buf, size_t len,
> > > +		       enum dma_data_direction dir)
> > > +{
> > > +	const bool vmalloced_buf = is_vmalloc_addr(buf);
> > > +	const int desc_len = vmalloced_buf ? PAGE_SIZE : master->max_dma_len;
> > 
> > You might want to rename this to "sg_chunk_max_size" or something,
> > "desc_len" doesn't make much sense here. The variable describes the
> > maximum size of one single scatterlist element.
> 
> A scatterlist entry is pretty much an abstract descriptor though.  I
> seem to remember looking at the name and thinking it was good that it
> was something less easily applicable to the length of the table but it
> doesn't make much odds.

It's the length of the entry, but I see your point.

> > > +	const int sgs = DIV_ROUND_UP(len, desc_len);
> > 
> > Looking at this, the variables could generally use a more meaningful
> > name. I think it'd be clearer to call this "num_sg_chunks" or so ?
> 
> You do know where I lifted most of these variable names from, right?  :P

Yeah, I don't like looking at my old code, it's always so frustrating ;-) Still, 
it's a good source for learning how to NOT do things again :)

> Looking at the code again everything seems idiomatic with the naming of
> the fields inside the sg_table - I probably would apply a patch to
> rename but I wouldn't write one.

OK, makes sense.

> > > +		min = min_t(size_t, len, desc_len);
> > > +
> > > +		if (vmalloced_buf) {
> > > +			vm_page = vmalloc_to_page(buf);
> > 
> > Just curious, but shouldn't we check if buf != NULL right at the begining
> > of this function?
> 
> No need, the check is outside the function along with the check that the
> controller is OK with DMAing on this transfer and so on.

OK, thank you for checking this.

> > > +static void spi_unmap_buf(struct spi_master *master, struct device
> > > *dev, +			  struct sg_table *sgt, enum dma_data_direction 
dir)
> > > +{
> > > +	if (sgt->orig_nents) {
> > 
> > I don't want to nag, but why not use if (!sgt->...) return; ? This would
> > cut down one level of indent.
> 
> I was looking at some stuff which might add a bit more in here if it's
> not just the core doing mappings.  Not sure that's sensible though so it
> might never materialise.

OK.

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
