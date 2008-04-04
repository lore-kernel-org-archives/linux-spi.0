From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH]  jffs2 summary allocation
Date: Fri, 4 Apr 2008 16:58:38 -0700
Message-ID: <200804041658.38499.david-b@pacbell.net>
References: <713171.37644.qm@web26213.mail.ukl.yahoo.com>
	<200804041609.41092.david-b@pacbell.net>
	<1207351282.3224.79.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Michael Trimarchi <trimarchimichael-whZMOeQn8C0@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Josh Boyer <jwboyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207351282.3224.79.camel-ao9So7SQ8LBXjJKHA5322XviChZXdy27@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 04 April 2008, Josh Boyer wrote:
> =

> > =A0 ... This means specifically that you may _not_ use the
> > =A0 memory/addresses returned from vmalloc() for DMA. =A0...
> > =

> > So I'm rather surprised to see *ANY* kernel code trying to do
> > that. =A0That rule has been in effect for many, many years now.
> =

> I don't think it was intentional. =A0You're going through several layers
> here:
> =

> JFFS2 -> mtd parts -> mtd dataflash -> atmel_spi.
> =

> Typically MTD drivers aren't doing DMAs to flash and JFFS2 has no idea
> which particular chip driver is being used because it's abstracted by
> MTD.

That's true ... although I can imagine using DMA to
avoid dcache trashing if its setup cost is low enough,
with either NAND or NOR chips.

Still:  in this context vmalloc() is wrong.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Register now and save $200. Hurry, offer ends at 11:59 p.m., =

Monday, April 7! Use priority code J8TLD2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
