From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: create an optional message queueing
	infrastructure
Date: Fri, 3 Feb 2012 15:01:57 +0100
Message-ID: <CACRpkdbk5nytVnE81Rhp3AhA7+o2uhReopaCyoPWHA52oDK4Gg@mail.gmail.com>
References: <1328187599-12982-1-git-send-email-linus.walleij@stericsson.com>
	<20120202185247.GR15343@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120202185247.GR15343-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 2, 2012 at 7:52 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wr=
ote:

> This looks really good. =A0In fact, can you think of any reason why we wo=
uldn't
> force all spi drivers to use central queueing? =A0I don't see any advanta=
ge
> in leaving the old mechanism in place other than to allow driver to trans=
ition
> from the old API.

Not really... except that it'll be hard to convert all drivers.

> There is also the spi_bitbang which also implements its own message
> queue and workqueue. =A0Several drivers make use of even if they don't
> do bitbanging.

Sound like they're abusing it then :-/

> Can you investigate dropping patch 2 and making the normal register
> function set up queued transfers if the transfer hook is not set. =A0If
> it is set, then make the kernel complain to the console, quietly at
> first, but we'll get louder before ultimately removing the
> non-queued interface. =A0Thoughts?

OK I'll post v2 soon with these changes.

Thanks,
Linus Walleij

---------------------------------------------------------------------------=
---
Try before you buy =3D See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
