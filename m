From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: linux-next: manual merge of the pxa tree
Date: Mon, 15 Sep 2008 09:18:30 -0400
Message-ID: <48CE60A6.4000705@whoi.edu>
References: <20080915052750.0b0c924c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080915052750.0b0c924c.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
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

Stephen Rothwell wrote:
> Hi Eric,
> 
> Today's linux-next merge of the pxa tree got a conflict in
> drivers/spi/pxa2xx_spi.c between commit
> 8423597d676615f3dd2d9ab36f59f147086b90b8 ("pxa2xx_spi: chipselect
> bugfixes") from Linus' tree and commit
> 5625ef19d54c02838c867b6a5c87823e021ac7a5 ("spi: pxa2xx_spi introduce chip
> select gpio to simplify the common cases") from the pxa tree.
> 
> I fixed it up (see below) and can carry the fixup (though it could be
> fixed in the pxa tree in a merge with Linus' tree).  Please check the
> fixup.

The last word I had from David Brownell, was that Eric should make his
patch fit after mine.  I think Eric was planning to re-submit, but maybe
you have saved him the trouble.  I will leave it to Eric to decide if
you fixed everything needed.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
