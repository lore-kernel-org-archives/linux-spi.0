From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/7] scatterlist: add sg_alloc_table_from_buf()
 helper
Date: Tue, 8 Mar 2016 17:57:15 +0100
Message-ID: <20160308175715.44245676@bbrezillon>
References: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
	<1457435715-24740-5-git-send-email-boris.brezillon@free-electrons.com>
	<1932521.ciegjbjXWo@avalon>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Dave Gordon
 <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian
 Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark
 Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime
 Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
 linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan
 Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro
 Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil
 <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring
 <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland
 <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
 Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB34I7S3AKGQETRHUCBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1932521.ciegjbjXWo@avalon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

On Tue, 08 Mar 2016 18:51:49 +0200
Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:

> Hi Boris,
>=20
> Thank you for the patch.
>=20
> On Tuesday 08 March 2016 12:15:12 Boris Brezillon wrote:
> > sg_alloc_table_from_buf() provides an easy solution to create an sg_tab=
le
> > from a virtual address pointer. This function takes care of dealing wit=
h
> > vmallocated buffers, buffer alignment, or DMA engine limitations (maxim=
um
> > DMA transfer size).
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  include/linux/scatterlist.h |  24 ++++++++
> >  lib/scatterlist.c           | 142 ++++++++++++++++++++++++++++++++++++=
+++++
> >  2 files changed, 166 insertions(+)
> >=20
> > diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> > index 556ec1e..4a75362 100644
> > --- a/include/linux/scatterlist.h
> > +++ b/include/linux/scatterlist.h
> > @@ -41,6 +41,27 @@ struct sg_table {
> >  	unsigned int orig_nents;	/* original size of list */
> >  };
> >=20
> > +/**
> > + * struct sg_constraints - SG constraints structure
> > + *
> > + * @max_chunk_len: maximum chunk buffer length. Each SG entry has to b=
e
> > smaller
> > + *		   than this value. Zero means no constraint.
> > + * @required_alignment: minimum alignment. Is used for both size and
> > pointer
> > + *			alignment. If this constraint is not met, the function
> > + *			should return -EINVAL.
> > + * @preferred_alignment: preferred alignment. Mainly used to optimize
> > + *			 throughput when the DMA engine performs better when
> > + *			 doing aligned accesses.
> > + *
> > + * This structure is here to help sg_alloc_table_from_buf() create the
> > optimal
> > + * SG list based on DMA engine constraints.
> > + */
> > +struct sg_constraints {
> > +	size_t max_chunk_len;
> > +	size_t required_alignment;
> > +	size_t preferred_alignment;
> > +};
> > +
> >  /*
> >   * Notes on SG table design.
> >   *
> > @@ -265,6 +286,9 @@ int sg_alloc_table_from_pages(struct sg_table *sgt,
> >  	struct page **pages, unsigned int n_pages,
> >  	unsigned long offset, unsigned long size,
> >  	gfp_t gfp_mask);
> > +int sg_alloc_table_from_buf(struct sg_table *sgt, const void *buf, siz=
e_t
> > len,
> > +			    const struct sg_constraints *constraints,
> > +			    gfp_t gfp_mask);
> >=20
> >  size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, voi=
d
> > *buf, size_t buflen, off_t skip, bool to_buffer);
> > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > index bafa993..706b583 100644
> > --- a/lib/scatterlist.c
> > +++ b/lib/scatterlist.c
> > @@ -433,6 +433,148 @@ int sg_alloc_table_from_pages(struct sg_table *sg=
t,
> >  }
> >  EXPORT_SYMBOL(sg_alloc_table_from_pages);
> >=20
> > +static size_t sg_buf_chunk_len(const void *buf, size_t len,
> > +			       const struct sg_constraints *cons)
> > +{
> > +	size_t chunk_len =3D len;
> > +
> > +	if (cons->max_chunk_len)
> > +		chunk_len =3D min_t(size_t, chunk_len, cons->max_chunk_len);
> > +
> > +	if (is_vmalloc_addr(buf))
> > +		chunk_len =3D min_t(size_t, chunk_len,
> > +				  PAGE_SIZE - offset_in_page(buf));
>=20
> This will lead to page-sized scatter-gather entries even for pages of the=
=20
> vmalloc memory that happen to be physically contiguous. That works, but I=
=20
> wonder whether we'd want to be more efficient.

Hm, I thought dma_map_sg() was taking care of merging p=C4=A5ysically
contiguous memory regions, but maybe I'm wrong. Anyway, that's
definitely something I can add at this level.

>=20
> > +	if (!IS_ALIGNED((unsigned long)buf, cons->preferred_alignment)) {
> > +		const void *aligned_buf =3D PTR_ALIGN(buf,
> > +						    cons->preferred_alignment);
> > +		size_t unaligned_len =3D (unsigned long)(aligned_buf - buf);
> > +
> > +		chunk_len =3D min_t(size_t, chunk_len, unaligned_len);
> > +	} else if (chunk_len > cons->preferred_alignment) {
> > +		chunk_len &=3D ~(cons->preferred_alignment - 1);
> > +	}
> > +
> > +	return chunk_len;
> > +}
> > +
> > +#define sg_for_each_chunk_in_buf(buf, len, chunk_len, constraints)	\
> > +	for (chunk_len =3D sg_buf_chunk_len(buf, len, constraints);	\
> > +	     len;							\
> > +	     len -=3D chunk_len, buf +=3D chunk_len,			\
> > +	     chunk_len =3D sg_buf_chunk_len(buf, len, constraints))
> > +
> > +static int sg_check_constraints(struct sg_constraints *cons,
> > +				const void *buf, size_t len)
> > +{
> > +	if (!cons->required_alignment)
> > +		cons->required_alignment =3D 1;
> > +
> > +	if (!cons->preferred_alignment)
> > +		cons->preferred_alignment =3D cons->required_alignment;
> > +
> > +	/* Test if buf and len are properly aligned. */
> > +	if (!IS_ALIGNED((unsigned long)buf, cons->required_alignment) ||
> > +	    !IS_ALIGNED(len, cons->required_alignment))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * if the buffer has been vmallocated and required_alignment is
> > +	 * more than PAGE_SIZE we cannot guarantee it.
> > +	 */
> > +	if (is_vmalloc_addr(buf) && cons->required_alignment > PAGE_SIZE)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * max_chunk_len has to be aligned to required_alignment to
> > +	 * guarantee that all buffer chunks are aligned correctly.
> > +	 */
> > +	if (!IS_ALIGNED(cons->max_chunk_len, cons->required_alignment))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * preferred_alignment has to be aligned to required_alignment
> > +	 * to avoid misalignment of buffer chunks.
> > +	 */
> > +	if (!IS_ALIGNED(cons->preferred_alignment, cons->required_alignment))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sg_alloc_table_from_buf - create an SG table from a buffer
> > + *
> > + * @sgt: SG table
> > + * @buf: buffer you want to create this SG table from
> > + * @len: length of buf
> > + * @constraints: optional constraints to take into account when creati=
ng
> > + *		 the SG table. Can be NULL if no specific constraints are
> > + *		 required.
> > + * @gfp_mask: type of allocation to use when creating the table
> > + *
> > + * This function creates an SG table from a buffer, its length and som=
e
> > + * SG constraints.
> > + *
> > + * Note: This function supports vmallocated buffers.
>=20
> What other types of memory does it support ? kmalloc() quite obviously, a=
re=20
> there others ? I think you should explicitly list the memory types that t=
he=20
> function intends to support.

Sure, I can explicitly list all memory types. Do you see any other kind
of memory other than the vmalloced and physically-contiguous ones?

Thanks for your review.

Boris
--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
