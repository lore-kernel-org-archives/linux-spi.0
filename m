From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Thu, 07 Jul 2016 00:04:33 +0200
Message-ID: <871t368lu6.fsf@belgarion.home>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
	<1467039249-7816-2-git-send-email-fcooper@ti.com>
	<CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
	<577D3B5C.7080805@ti.com>
	<CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
	<577D5E78.2010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	<david.s.gordon@intel.com>, Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lin <ming.l@ssi.samsung.com>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <577D5E78.2010307@ti.com> (Franklin S. Cooper, Jr.'s message of
	"Wed, 6 Jul 2016 14:39:36 -0500")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

"Franklin S Cooper Jr." <fcooper@ti.com> writes:

> Unfortunately, for the original purpose of this series the scatterlist I
> want to clone is indeed DMA mapped.
>
> The times I've seen dma_length != length is when the dma_map_sg is
> trying to combine contiguous sgl (ex ppc_iommu_map_sg and dma_map_cont).
> So maybe it is better to subtract a value from length and dma_length
> rather than explicitly setting it to a value. This way it wouldn't
> matter that dma_length and length aren't equal.
>
> This looks like a similar approach used by sg_split_mapped. Although
> sg_split skips first x number of bytes while I want to skip the last x
> number of bytes.
>
> Maybe Robert can add his thoughts since he created sg_split.

Hi,

I've not read it all, but the above chapter is right : dma_length might be
different from length when a dma mapping operation coallesced 2 sg entries into
a "DMA contiguous one". This coallescing might happen for at least for 2 reasons
as far as I know :
 - 2 sg entries are physically contiguous, ie :
   sg_phys(sga) + sga.length == sg_phys(sgb)
 - 2 sg entries are DMA contiguous when an IOMMU maps them contiguously, ie :
   sg_dma_address(sga) + sga.length == sg_dma_address(sgb)

Moreover, this 2 coallescing cases imply a "shift" between (page_link, length)
and (dma_address and dma_length). For example a mapped sglist might look like :
 -sg0: page_link=>page@0k, length=4096, dma_address=0, dma_length=8192
 -sg1: page_link=>page@4k, length=4096, dma_address=8192, dma_length=16
                                                          \=> see the shift here
                                                              coming from sg2
 -sg2: page_link=>page@8k, length=16, dma_address=0, dma_length=0

For these "tricky" cases, at the time I created sg_split I had done a tester as
well. It's very basic, doesn't cover all the corner cases, is a bit dumb, but
you might have a look, and the brain cost you'll pay to adapt it to test what
you want will hopefully pay off by the knowledge gained on scatterlist. It is
appended at the end of the mail.

Cheers.

-- 
Robert

---8>---
#include <assert.h>
#include <linux/scatterlist.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NB_MAX_SG 10

static void fatal(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vprintf(fmt, ap);
	exit(1);
	va_end(ap);
}

static int my_random(int max)
{
	double val = random() * max / RAND_MAX;

	return (int)val;
}

static int is_following(struct scatterlist *sg)
{
	return sg_phys(sg - 1) + sg[-1].length == sg_phys(sg);
}

static void print_sg(const char *prefix, struct scatterlist *sg_in, int nents)
{
	struct scatterlist *sg;
	int i;

	printf("%sPrinting sg %p:%d\n", prefix, sg_in, nents);
	for_each_sg(sg_in, sg, nents, i)
		printf("%s\t%s[%02d] page_link=0x%08x offset=0x%08x length=%6d dma=0x%08x dma_len=%6d\n",
		       prefix, i > 0 && is_following(sg) ? "-->" : "   ",
		       i, sg->page_link, sg->offset, sg->length,
		       sg_dma_address(sg), sg_dma_len(sg));
}

static int fill_random_sg(struct scatterlist *sg_in, int nents)
{
	struct scatterlist *sg;
	unsigned long phys;
	int i, new = 1;

	nents = 1 + my_random(nents - 1);
	for_each_sg(sg_in, sg, nents, i) {
		if (new) {
			/* sg->page_link = my_random(100000) & ~4095; */
			sg->page_link = 4096 * i;
			sg->length = 1024 * my_random(4);
			if (sg->length == 0)
				sg->length = 0x4 + my_random(4000);
			sg->offset = my_random(sg->length);
		} else {
			sg[-1].length &= ~0x3;
			sg[-1].offset &= ~0x3;
			phys = (sg_phys(sg - 1) + sg[-1].length) & ~0x3;
			sg->offset = phys % 4096;
			sg->page_link = phys - sg->offset;
			sg->length = 1024 * my_random(4);
			if (sg->length == 0)
				sg->length = 0x4 + my_random(4000);
		}

		new = (my_random(3) > 1) ? 0 : 1;
	}
	sg_mark_end(sg - 1);
	return nents;
}

static int map_random_sg(struct scatterlist *sg_in, int nents)
{
	struct scatterlist *sg, *sg_out;
	int i, follow, m = 0;
	unsigned long map_offs = 0x80000000;

	sg_out = sg_in;
	for_each_sg(sg_in, sg, nents, i) {
		if (i > 0 && is_following(sg))
			follow = 1;
		else
			follow = 0;

		if (follow) {
			sg_dma_len(sg_out - 1) += sg->length;
		} else {
			sg_dma_address(sg_out) = sg_phys(sg) + map_offs;
			sg_dma_len(sg_out) = sg->length;
			sg_out = sg_next(sg_out);
			m++;
		}
	}
	return m;
}

static int check_sgout_phys_continuity(struct scatterlist *sg_in, off_t skip, size_t size,
				       struct scatterlist *sg_out,
				       struct scatterlist **new_sg_in, off_t *new_skip)
{
	struct scatterlist *sg;
	int i, last_len, total_len = 0;
	unsigned long last_phys;
	int in_idx;

	for_each_sg(sg_out, sg, sg_nents(sg), i) {
		if (in_idx < 0) {
			last_phys = sg_phys(sg);
			last_len = sg->length;
			assert(last_phys == sg_phys(&sg_in[in_idx]));
		} else {
		}
	}
}

static int test_sg_split(struct scatterlist *sg_in, int nents, int mapped)
{
	struct scatterlist *sg, *sg_out[7];
	int ret, i, out_mapped_nents[7], nb_sizes = 7, span = 0, len;
	size_t sizes[7], tot_size;
	int sg_phys_span = 0, sg_map_span = 0;
	off_t skip;

	for_each_sg(sg_in, sg, nents, i)
		sg_phys_span += sg->length;
	for_each_sg(sg_in, sg, mapped, i)
		sg_map_span += sg_dma_len(sg);

	assert(sg_phys_span == sg_map_span);

	skip = my_random(sg_map_span);
	for (i = 0, span = 0; i< nb_sizes; i++) {
		sizes[i] = my_random(sg_phys_span / nb_sizes);
		span += sizes[i];
	}

	ret = sg_split(sg_in, mapped, skip, nb_sizes, sizes, sg_out,
		       out_mapped_nents, 0);
	printf("Test the split of sg(n=%d m=%d span=%d skip=%u) : sizes = [",
	       nents, mapped, sg_phys_span, skip);
	for (i = 0, tot_size = 0; i < nb_sizes; tot_size += sizes[i], i++)
		printf(" %d", sizes[i]);
	printf(" ] <=> [%u..%u] : %d\n", skip, skip + tot_size, ret);

	if (ret < 0)
		return ret;

	for (i = 0; i < nb_sizes; i++) {
		printf("\tsg[%02d] : mapped=%d\n", i, out_mapped_nents[i]);
		print_sg("\t\t", sg_out[i], sg_nents(sg_out[i]));
	}

	for (i = 0, sg = sg_in; i < nb_sizes; i++) {
		check_sgout_phys_continuity(sg, skip, sizes[i], sg_out[i], &sg, &len);
		skip += len;
	}

	for (i = 0; i < nb_sizes; i++)
		free(sg_out[i]);
}

int main(int argc, char **argv)
{
	struct scatterlist *sg_in;
	int m, n;
	unsigned int seed;

	if (argc == 1)
		seed = time(NULL);
	else
		seed = atoi(argv[1]);
	srandom(seed);
	printf("Executing: %s %u\n", argv[0], seed);

	sg_in = calloc(NB_MAX_SG, sizeof(struct scatterlist));
	if (!sg_in)
		fatal("Couldn't allocate sg_in\n");

	n = fill_random_sg(sg_in, NB_MAX_SG);
	m = map_random_sg(sg_in, n);
	print_sg("", sg_in, n);

	test_sg_split(sg_in, n, m);

	free(sg_in);
        return 0;
}
