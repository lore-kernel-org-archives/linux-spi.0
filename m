From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Fri, 8 Jul 2016 10:18:44 +0200
Message-ID: <20160708081844.GQ6247@sirena.org.uk>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
 <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
 <577D3B5C.7080805@ti.com>
 <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
 <577D5E78.2010307@ti.com>
 <871t368lu6.fsf@belgarion.home>
 <20160707080241.GE6247@sirena.org.uk>
 <87twg1739e.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c3iVMYArYos8XHMA"
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Ming Lin <ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87twg1739e.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--c3iVMYArYos8XHMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2016 at 07:43:25PM +0200, Robert Jarzmik wrote:

> I'll try, but I don't trust much my chances of success, given that this tester :
>  - should compile and link in $(TOP)/lib/scatterlist.c, as this is where
>    sg_split() is defined
>  - this implies all its includes
>  - this implies at least these ones :
> 	bug.h
> 	mm.h
> 	scatterlist.h
> 	string.h
> 	types.h
>  - this implies having page_to_phys and co. defined somewhere without
>    draining the whole include/linux and include/asm* trees

> For the tester, I had created an apart include/linux tree where all the includes
> were _manually_ filled in with minimal content.

> I don't know if an existing selftest had already this kind of problem,
> ie. having to compile and link a kernel .c file, and that makes me feel this
> might be difficult to keep a nice standalone tester.

Right, that's messy :(  Could it be refactored as a boot/module load
time test so it could be built in the kernel environment?  Less
convenient to use (though KVM/UML help) but easier to build.

--c3iVMYArYos8XHMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXf2HgAAoJECTWi3JdVIfQJJEH/i+C9tszDYoZQKMHSSjP/uou
AQXabVfVK3JXAOF6qixHgtuKtbhXp0rv0waSUBW6rYhPtrrQDyYl1hBVJZTk9mo2
JLyhl75RExpAmf4qSuP+d4NeWaba5C4Y4SeF1AZo0mKBBZ+SVGBdLc2g7Z3BE6yP
9aZLzlq7VOuqVtRvFKhbBrVxLJcNSpJ5+JGb+FCQLWESMxJzfJrBZbuUgYpCdJe4
DrzYgWQUtM981A9T+uB1zH66BZiP6IaxZwKpEi7lcJKMOyFDuGyRJp83BtF6YlPc
n3RFUCj4Bwv6h22ZFwJ/EeLQPmXpe+urktrtzf1OQLG01drgk5cO+mgg8QYgrN4=
=VApL
-----END PGP SIGNATURE-----

--c3iVMYArYos8XHMA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
