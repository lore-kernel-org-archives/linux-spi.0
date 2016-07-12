From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Tue, 12 Jul 2016 19:14:02 +0200
Message-ID: <87vb0a3hk5.fsf@belgarion.home>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
	<1467039249-7816-2-git-send-email-fcooper@ti.com>
	<CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
	<577D3B5C.7080805@ti.com>
	<CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
	<577D5E78.2010307@ti.com> <871t368lu6.fsf@belgarion.home>
	<20160707080241.GE6247@sirena.org.uk> <87twg1739e.fsf@belgarion.home>
	<20160708081844.GQ6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Franklin S Cooper Jr." <fcooper@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	david.s.gordon@intel.com, Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lin <ming.l@ssi.samsung.com>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160708081844.GQ6247@sirena.org.uk> (Mark Brown's message of
	"Fri, 8 Jul 2016 10:18:44 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Jul 07, 2016 at 07:43:25PM +0200, Robert Jarzmik wrote:
>
>> I'll try, but I don't trust much my chances of success, given that this tester :
>>  - should compile and link in $(TOP)/lib/scatterlist.c, as this is where
>>    sg_split() is defined
>>  - this implies all its includes
>>  - this implies at least these ones :
>> 	bug.h
>> 	mm.h
>> 	scatterlist.h
>> 	string.h
>> 	types.h
>>  - this implies having page_to_phys and co. defined somewhere without
>>    draining the whole include/linux and include/asm* trees
>
>> For the tester, I had created an apart include/linux tree where all the includes
>> were _manually_ filled in with minimal content.
>
>> I don't know if an existing selftest had already this kind of problem,
>> ie. having to compile and link a kernel .c file, and that makes me feel this
>> might be difficult to keep a nice standalone tester.
>
> Right, that's messy :(  Could it be refactored as a boot/module load
> time test so it could be built in the kernel environment?  Less
> convenient to use (though KVM/UML help) but easier to build.

Actually I thought a bit about it and I got a "messy" idea.

In order to keep things in userspace (for tests it really is more convenient),
I'm going to try this approach :
 - make tools/testing/selftests/lib/sg_split.c, based on the tester
 - make the Makefile generate a scatterlist_generated.c out of lib/scatterlist.c,
   where all the includes will be 'grepped; out and replaced by a single "#include
   sg_split.h" containing all the necessary defines
 - create the sg_split.h as a concatenation of all the .h files I had to use for
   the tester (I will reuse existing .h if it is applicable)

We'll see if that's feasible or not. As long as the "mess" is contained within
sg_split.h, and if it doesn't become a too ugly beast, it might work.

Cheers.

-- 
Robert
