From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [v2,4/7] scatterlist: add sg_alloc_table_from_buf() helper
Date: Thu, 31 Mar 2016 09:26:04 +0200
Message-ID: <20160331092604.219cf104@bbrezillon>
References: <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
	<56FCAE1B.90206@ti.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris
 <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Andrew
 Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Dave Gordon <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel
 Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
 Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob
 Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Richard
 Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Mark Brown
 <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Laurent
 Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kumar Gala
 <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard
 <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan
 Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
 <linux-arm-kernel-IAPFreCvJWMMKQXVYFwzLw@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBDVC6O3QKGQEVJXLWZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <56FCAE1B.90206-l0cyMroinI0@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Vignesh,

On Thu, 31 Mar 2016 10:26:59 +0530
Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:

> Hi,
> 
> On 03/30/2016 09:09 PM, Boris BREZILLON wrote:
> 
> [...]
> 
> > +int sg_alloc_table_from_buf(struct sg_table *sgt, const void *buf, size_t len,
> > +			    const struct sg_constraints *constraints,
> > +			    gfp_t gfp_mask)
> > +{
> > +	struct sg_constraints cons = { };
> > +	size_t remaining, chunk_len;
> > +	const void *sg_buf;
> > +	int i, ret;
> > +
> > +	if (constraints)
> > +		cons = *constraints;
> > +
> > +	ret = sg_check_constraints(&cons, buf, len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	sg_buf = buf;
> > +	remaining = len;
> > +	i = 0;
> > +	sg_for_each_chunk_in_buf(sg_buf, remaining, chunk_len, &cons)
> > +		i++;
> > +
> > +	ret = sg_alloc_table(sgt, i, gfp_mask);
> > +	if (ret)
> > +		return ret;
> > +
> > +	sg_buf = buf;
> > +	remaining = len;
> > +	i = 0;
> > +	sg_for_each_chunk_in_buf(sg_buf, remaining, chunk_len, &cons) {
> > +		if (is_vmalloc_addr(sg_buf)) {
> > +			struct page *vm_page;
> > +
> > +			vm_page = vmalloc_to_page(sg_buf);
> > +			if (!vm_page) {
> > +				ret = -ENOMEM;
> > +				goto err_free_table;
> > +			}
> > +
> > +			sg_set_page(&sgt->sgl[i], vm_page, chunk_len,
> > +				    offset_in_page(sg_buf));
> > +		} else {
> > +			sg_set_buf(&sgt->sgl[i], sg_buf, chunk_len);
> > +		}
> > +
> 
> If the buf address is in PKMAP_BASE - PAGE_OFFSET-1 region (I have
> observed that JFFS2 FS provides buffers in above region to MTD layer),
> if CONFIG_DEBUG_SG is set then sg_set_buf() will throw a BUG_ON() as
> virt_addr_is_valid() will return false. Is there a sane way to handle
> buffers of PKMAP_BASE region with sg_*  APIs?
> Or, is the function sg_alloc_table_from_buf() not to be used with such
> buffers?

It should be usable with kmapped buffers too: I'll provide a new version
to support that.
That makes me realize I'm not checking the virtual address consistency
in sg_check_constraints().

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
