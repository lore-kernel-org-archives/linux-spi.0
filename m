From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/16] Blackfin SPI Driver: ensure
	cache coherency before doing DMA
Date: Fri, 6 Feb 2009 10:31:05 +0800
Message-ID: <386072610902051831k7b3530b1lc19a07b4a0e1eacc@mail.gmail.com>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<200811201405.06811.david-b@pacbell.net>
	<386072610902050130k27c6d7far752ac49183bf36ae@mail.gmail.com>
	<200902051551.14146.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200902051551.14146.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 6, 2009 at 7:51 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Thursday 05 February 2009, Bryan Wu wrote:
>> As you acked this patchset, is that possible to merge it?
>> Or need Andrew to keep them in -mm for a while.
>
> ISTR *NOT* acking the whole series though.  In fact, I recall
> giving a generic NAK part way through because of patches that
> didn't include comments (after manually NAKing many individual
> patches) and ones where $SUBJECT didn't match the patch comments.
> Plus even a few which seemed to be wrong.
>
> (And I've said the same thing about Blackfin patches before,
> too.  Please help the message get through to your co-workers:
> make sure the patches come with useful public descriptions.)
>
> At this point, best to resend the whole series, with the
> updates I requested.  The few patches which I did ack can
> include that ack.
>

OK, I will resend these 16 patches and next new 5 patches soon.
Thanks a lot

-Bryan

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
