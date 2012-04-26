From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix calculate_effective_freq()
Date: Thu, 26 Apr 2012 10:29:19 +0200
Message-ID: <CACRpkdb7YuWAwXDzn+6TuZ_KDADi1KMy7_z-ngtVUx1B=e13mQ@mail.gmail.com>
References: <a90e4161f6d2fa30827bedcc2b001dbb50585b46.1334826569.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vinit.shenoy-qxv4g6HH51o@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <a90e4161f6d2fa30827bedcc2b001dbb50585b46.1334826569.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 19, 2012 at 11:14 AM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:

> calculate_effective_freq() was still not optimized and there were cases when it
> returned without error and with values of cpsr and scr as zero.
>
> Also, the variable named found is not used well.
>
> This patch targets to optimize and correct this routine. Tested for SPEAr.
>
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> Tested-by: Vinit Kamalaksha Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
