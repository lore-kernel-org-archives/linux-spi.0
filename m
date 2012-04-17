From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V2] spi/pl022: Fix range checking for bits per word
Date: Tue, 17 Apr 2012 17:54:29 -0600
Message-ID: <20120417235429.25BF03E0579@localhost>
References: <1334646613-12560-1-git-send-email-vinit.shenoy@st.com>
	<CACRpkdbJ+c5zyQKHKE_=AgD3qbiKoHkfjwiQmrouQT=qEu7vdw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="===============7737102445131699097=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdbJ+c5zyQKHKE_=AgD3qbiKoHkfjwiQmrouQT=qEu7vdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============7737102445131699097==

On Tue, 17 Apr 2012 11:29:37 +0200, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Apr 17, 2012 at 9:10 AM, Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org> wrote:
> 
> > pl022 ssp controller supports word lengths from 4 to 16 (or 32) bits.
> > Currently implemented checks were incorrect. It has following check
> >
> > if (pl022->vendor->max_bpw >= 32)
> >
> > which must be checking for <=.
> >
> > Also error print message is incorrect, that prints "range is from 1 to
> > 16".
> >
> > Fix both these issues.
> >
> > Signed-off-by: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
> > ---
> > V1->V2:
> > - Fixed the check:
> >        if (pl022->vendor->max_bpw >= 32)
> > - Re-written complete range check logic.
> 
> Looks correct to me:
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied, thanks

g.



--===============7737102445131699097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============7737102445131699097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============7737102445131699097==--
