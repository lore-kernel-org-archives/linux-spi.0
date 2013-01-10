From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 10 Jan 2013 12:52:44 +0100
Message-ID: <CACRpkdYLwrgu53kUrdsUq+YEjSvJwLjNghW8KqNc5DNotSx+4A@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
	<CACRpkdad3fHxWRpRqD-eP8-sKKexN+s-JZCT6XLggv92Q=5kMA@mail.gmail.com>
	<1355809660.11831.284.camel@bichao>
	<20130109042535.GL19691@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	alan-b5Z7lJ3WibVrdx17CPfAsdBPR1lH4CV8@public.gmane.org, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130109042535.GL19691-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 9, 2013 at 5:25 AM, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Also I have some questions on this approach. Is this driver for SSP ip or SPI
> ip, looks like latter. In both the cases there are some existing drivers in
> kernel and adding one more IMHO doesnt make sense. What we really need a
> common core for dw IP and SSP IP (i think pxa uses same stuff). That way lot of
> code will get reduced from driver

+1 on this comment, I didn't even notice :-(

Linus Walleij

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
