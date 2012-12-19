From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4 v2] spi: sh-msiof: Add device tree parsing to driver
Date: Wed, 19 Dec 2012 16:41:15 +0000
Message-ID: <20121219164115.62A403E0C18@localhost>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
	<1355313289-29769-3-git-send-email-hechtb+renesas@gmail.com>
	<CABMQnV+CSEKwq=4kQYUDXOuARLA_WgvnkJEME_VeYmAv3PLXBg@mail.gmail.com>
	<CABYn4sybRf4vxxGccCDSCEMcza4DZdaZgTD6kZ7+v9CDspzCBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CABYn4sybRf4vxxGccCDSCEMcza4DZdaZgTD6kZ7+v9CDspzCBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 17 Dec 2012 12:25:26 +0100, Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Nobuhiro,
> 
> 2012/12/17 Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>:
> > Hi, Bastian.
> >
> > On Wed, Dec 12, 2012 at 8:54 PM, Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> From: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> This adds the capability to retrieve setup data from the device tree
> >> node. The usage of platform data is still available.
> >>
> >> Signed-off-by: Bastian Hecht <hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---

Applied, thanks.

> >> +               .of_match_table = sh_msiof_match,
> >
> > You can use of_match_ptr(sh_msiof_match).
> >
> 
> Ok very nice, will do so.

Please send a fixup patch for this change.

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
