From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Thu, 07 Jul 2016 19:43:25 +0200
Message-ID: <87twg1739e.fsf@belgarion.home>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
	<1467039249-7816-2-git-send-email-fcooper@ti.com>
	<CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
	<577D3B5C.7080805@ti.com>
	<CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
	<577D5E78.2010307@ti.com> <871t368lu6.fsf@belgarion.home>
	<20160707080241.GE6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Ming Lin <ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160707080241.GE6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Thu, 7 Jul 2016 10:02:41 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Thu, Jul 07, 2016 at 12:04:33AM +0200, Robert Jarzmik wrote:
>
>> For these "tricky" cases, at the time I created sg_split I had done a tester as
>> well. It's very basic, doesn't cover all the corner cases, is a bit dumb, but
>> you might have a look, and the brain cost you'll pay to adapt it to test what
>> you want will hopefully pay off by the knowledge gained on scatterlist. It is
>> appended at the end of the mail.
>
> Might be worth getting this into the kernel source, under tools/testing
> perhaps?

Maybe so.

I'll try, but I don't trust much my chances of success, given that this tester :
 - should compile and link in $(TOP)/lib/scatterlist.c, as this is where
   sg_split() is defined
 - this implies all its includes
 - this implies at least these ones :
	bug.h
	mm.h
	scatterlist.h
	string.h
	types.h
 - this implies having page_to_phys and co. defined somewhere without
   draining the whole include/linux and include/asm* trees

For the tester, I had created an apart include/linux tree where all the includes
were _manually_ filled in with minimal content.

I don't know if an existing selftest had already this kind of problem,
ie. having to compile and link a kernel .c file, and that makes me feel this
might be difficult to keep a nice standalone tester.

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
